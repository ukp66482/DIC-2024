module MPQ(clk,rst,data_valid,data,cmd_valid,cmd,index,value,busy,RAM_valid,RAM_A,RAM_D,done);
input clk;
input rst;
input data_valid;
input [7:0] data;
input cmd_valid;
input [2:0] cmd;
input [7:0] index;
input [7:0] value;
output reg busy;
output reg RAM_valid;
output reg [7:0]RAM_A;
output reg [7:0]RAM_D;
output done;

reg [3:0] state;
reg [3:0] next_state;

reg [3:0] size;
reg [3:0] idx;
wire [4:0] left;
wire [4:0] right;
wire [2:0] parent;
reg [3:0] largest;
reg [2:0] heapify_times;

wire left_bigger;
wire right_bigger;
wire right_bigger_than_left;
wire bigger_than_parent;

reg [7:0] Queue [1:13];

assign left = idx << 1;
assign right = (idx << 1) + 1;
assign parent = idx >> 1;

assign left_bigger = (left <= size && Queue[left] > Queue[idx]);
assign right_bigger = (right <= size && Queue[right] > Queue[idx]);
assign right_bigger_than_left = (left <= size && right <= size && Queue[right] > Queue[left]);
assign bigger_than_parent = (idx > 1 && Queue[idx] > Queue[parent]);

parameter 
HEAPIFY = 4'd0, 
EXTRACT_MAX = 4'd1, 
INCREASE = 4'd2, 
INSERT = 4'd3, 
WRITE_DELAY = 4'd4,  
INPUT = 4'd5, 
IDLE = 4'd6, 
DONE = 4'd7, 
EXCHANGE_WITH_LARGEST = 4'd8, 
NEXT_HEAPIFY = 4'd9, 
//WRITE_DONE = 4'd10,
WRITE = 4'd11;

always @(posedge clk or posedge rst) begin //state
    if(rst) state <= INPUT;
    else if(cmd_valid && !busy) state <= cmd;
    else state <= next_state;
end

always @(*) begin //next_state
    case(state)
        INPUT:begin
            if(data_valid) next_state = INPUT;
            else next_state = HEAPIFY;
        end
        HEAPIFY:begin
            if(left_bigger || right_bigger) next_state = EXCHANGE_WITH_LARGEST;
            else next_state = NEXT_HEAPIFY;
        end
        EXCHANGE_WITH_LARGEST: next_state = HEAPIFY;
        NEXT_HEAPIFY:begin
            if(heapify_times > 1) next_state = HEAPIFY;
            else next_state = IDLE;
        end
        EXTRACT_MAX: next_state = HEAPIFY;
        INCREASE:begin
            if(bigger_than_parent) next_state = INCREASE;
            else next_state = IDLE;
        end
        INSERT: next_state = INCREASE;
        WRITE_DELAY: begin 
            if(idx == size + 1) next_state = DONE;
            else next_state = WRITE;
        end
        WRITE: next_state = WRITE_DELAY;
        //WRITE_DONE: next_state = DONE;
        DONE: next_state = DONE;
        default: next_state = IDLE;
    endcase
end

always @(posedge clk) begin //Queue
    case(state)
        INPUT: if(data_valid) Queue[idx] <= data;
        EXCHANGE_WITH_LARGEST:begin
            Queue[idx] <= Queue[largest];
            Queue[largest] <= Queue[idx];
        end
        EXTRACT_MAX: Queue[1] <= Queue[size];
        INCREASE:begin
            if(bigger_than_parent)begin
                Queue[idx] <= Queue[parent];
                Queue[parent] <= Queue[idx];
            end
        end
        IDLE:begin
            case(cmd)
                INSERT: Queue[size + 1] <= value;
                INCREASE: Queue[index] <= value;
            endcase
        end
    endcase
end

always @(posedge clk or posedge rst) begin //size
    if(rst)begin
        size <= 0;
    end else begin
        case(state)
            INPUT: if(data_valid) size <= idx;
            EXTRACT_MAX: size <= size - 1;
            IDLE: if(cmd == INSERT) size <= size + 1;
        endcase
    end
end

always @(posedge clk or posedge rst) begin //idx
    if(rst)begin
        idx <= 1;
    end else begin
        case(state)
            INPUT:begin
                if(data_valid) idx <= idx + 1;
                else idx <= idx >> 1;
            end
            EXCHANGE_WITH_LARGEST: idx <= largest;
            NEXT_HEAPIFY: idx <= heapify_times - 1;
            WRITE_DELAY: idx <= idx + 1; 
            EXTRACT_MAX: idx <= 1;
            INSERT: idx <= size;
            INCREASE: idx <= idx >> 1;
            IDLE:begin
                case(cmd)
                    INCREASE: idx <= index;
                    WRITE_DELAY: idx <= 1;
                endcase
            end
        endcase
    end
end

always @(posedge clk or posedge rst) begin //heapify_times
    if(rst)begin
        heapify_times <= 0;
    end else begin
        case(state)
            INPUT: heapify_times <= idx >> 1;
            NEXT_HEAPIFY: heapify_times <= heapify_times - 1;
            IDLE: heapify_times <= 1;
        endcase
    end
end

always @(posedge clk or posedge rst) begin //largest
    if(rst)begin
        largest <= 0;
    end else begin
        case(state)
            INPUT: largest <= idx >> 1;
            HEAPIFY:begin
                if(right_bigger && right_bigger_than_left) largest <= right;
                else if(left_bigger) largest <= left;
                else largest <= idx;
            end
            NEXT_HEAPIFY: largest <= heapify_times - 1;
        endcase 
    end
end

always @(posedge clk or posedge rst) begin //RAM_A
    if(rst)begin
        RAM_A <= 8'hff;
    end else begin
        if(state == WRITE_DELAY) RAM_A <= RAM_A + 1;
    end
end

always @(posedge clk or posedge rst) begin //RAM_D
    if(rst)begin
        RAM_D <= 0;
    end else begin
        if(state == WRITE_DELAY) RAM_D <= Queue[idx];
    end   
end

always @(posedge clk or posedge rst) begin //RAM_valid
    if(rst)begin
        RAM_valid <= 0;
    end else begin
        if(state == WRITE) RAM_valid <= 1;
        else RAM_valid <= 0;
    end
end

assign done = (state == DONE); //done

//assign busy = (state != IDLE && state != DONE); //busy

always @(posedge clk or posedge rst) begin //busy
    if(rst)begin
        busy <= 1;
    end else begin
        if(cmd_valid && !busy) busy <= 1;
        else if(next_state == IDLE || next_state == DONE) busy <= 0;
        else busy <= 1;
    end
end

endmodule