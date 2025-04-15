module CIPU(
input       clk, 
input       rst,
input       [7:0]people_thing_in,
input       ready_fifo,
input       ready_lifo,
input       [7:0]thing_in,
input       [3:0]thing_num,
output      valid_fifo,
output      valid_lifo,
output      valid_fifo2,
output      [7:0]people_thing_out,
output reg  [7:0]thing_out,
output      done_thing,
output      done_fifo,
output      done_lifo,
output      done_fifo2);

parameter RESET = 3'd0, INPUT = 3'd1, STACK_OUT = 3'd2, QUEUE_OUT = 3'd3, CLEAR = 3'd4, DONE = 3'd5;

reg [2:0] state;
reg [2:0] next_state;
reg [7:0] MEM [31:0];
reg [4:0] queue_cnt;
reg [4:0] stack_cnt;
reg [4:0] output_cnt;

always @(posedge clk or posedge rst) begin //state
    if(rst) state <= RESET;
    else state <= next_state;
end

always @(*) begin //next_state
    case(state)
        RESET: begin
            if(ready_fifo && ready_lifo) next_state = INPUT;
            else next_state = RESET;
        end
        INPUT: begin
            if(thing_in == 8'h3b) next_state = STACK_OUT;
            else if(thing_in == 8'h24) next_state = DONE;
            else next_state = INPUT;
        end
        STACK_OUT:begin
            if(stack_cnt == 2 || stack_cnt == 1) next_state = CLEAR;
            else if(output_cnt + 1 == thing_num || thing_num == 0) next_state = QUEUE_OUT;
            else next_state = STACK_OUT;
        end
        QUEUE_OUT:begin
            if(queue_cnt == stack_cnt - 2) next_state = CLEAR;
            else next_state = QUEUE_OUT;
        end
        CLEAR: next_state = INPUT;
    endcase
end

always @(posedge clk ) begin //MEM
    if(state == INPUT) begin
        MEM[stack_cnt] <= thing_in;
    end
end

always @(*) begin //thing_out
    if(state == STACK_OUT)begin
        if(thing_num == 0) thing_out = 8'h30;
        else thing_out = MEM[stack_cnt - 2];
    end else if(state == QUEUE_OUT)begin
        thing_out = MEM[queue_cnt];
    end else begin
        thing_out = 8'h00;
    end
end

always @(posedge clk or posedge rst) begin //stack_cnt
    if(rst)begin
        stack_cnt <= 0;
    end else begin
        case(state)
            INPUT: stack_cnt <= stack_cnt + 1;
            STACK_OUT: begin
                if(thing_num == 0) stack_cnt <= stack_cnt;
                else stack_cnt <= stack_cnt - 1;
            end
            CLEAR: stack_cnt <= 0;
        endcase
    end
end

always @(posedge clk or posedge rst) begin //queue_cnt
    if(rst)begin
        queue_cnt <= 0;
    end else begin
        case(state)
            QUEUE_OUT: queue_cnt <= queue_cnt + 1;
            CLEAR: queue_cnt <= 0;
        endcase
    end
end

always @(posedge clk or posedge rst) begin //output_cnt
    if(rst)begin
        output_cnt <= 0;
    end else begin
        case(state)
            STACK_OUT: output_cnt <= output_cnt + 1;
            CLEAR: output_cnt <= 0;
        endcase
    end
end

assign valid_fifo = (people_thing_in >= 8'd65 && people_thing_in <= 8'd90) ? 1 : 0; //valid_fifo

assign valid_lifo = (state == STACK_OUT); //valid_lifo

assign valid_fifo2 = (state == QUEUE_OUT); //valid_fifo2

assign people_thing_out = people_thing_in; //people_thing_out

assign done_fifo = (people_thing_in == 8'h24); //done_fifo

assign done_thing = (state == CLEAR); //done_thing

assign done_lifo = (state == DONE); //done_lifo

assign done_fifo2 = (state == DONE); //done_fifo2

endmodule