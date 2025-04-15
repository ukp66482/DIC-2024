`timescale 1ns/10ps
module MM( in_data, col_end, row_end, is_legal, out_data, rst, clk , change_row,valid,busy);
input           clk;
input           rst;
input           col_end;
input           row_end;
input  signed  [7:0]     in_data;

output reg signed [19:0]   out_data;
output is_legal;
output change_row,valid,busy;

reg [1:0] state;
reg [1:0] nextState;
reg [1:0] rowCnt, colCnt, calCnt;
reg [1:0] row1, row2;
reg [1:0] col1, col2;
reg signed [7:0] matrix1 [0:3][0:3];
reg signed [7:0] matrix2 [0:3][0:3];

parameter INPUT1 = 2'd0, INPUT2 = 2'd1, CAL = 2'd2, OUTPUT = 2'd3;

always @(posedge clk or posedge rst) begin //state
    if(rst)begin
        state <= INPUT1;
    end else begin
        state <= nextState;
    end
end

always @(*) begin //nextState
    case(state)
        INPUT1:begin
            if(row_end) nextState = INPUT2;
            else nextState = INPUT1;
        end
        INPUT2:begin
            if(row_end) nextState = CAL;
            else nextState = INPUT2;
        end
        CAL:begin
            if(calCnt == col1 || col1 != row2) nextState = OUTPUT;
            else nextState = CAL;
        end
        OUTPUT:begin
            if((rowCnt == row1 && colCnt == col2) || col1 != row2) nextState = INPUT1;
            else nextState = CAL;
        end
        default: nextState = INPUT1;
    endcase
end

always @(posedge clk or posedge rst) begin //rowCnt colCnt
    if(rst)begin
        rowCnt <= 0;
        colCnt <= 0;
        calCnt <= 0;
        row1 <= 0;
        row2 <= 0;
        col1 <= 0;
        col2 <= 0;
    end else begin
        case(state)
            INPUT1:begin
                if(row_end)begin
                    row1 <= rowCnt;
                    col1 <= colCnt;
                    rowCnt <= 0;
                    colCnt <= 0;
                end else begin
                    if(col_end)begin
                        colCnt <= 0;
                        rowCnt <= rowCnt + 1;
                    end else begin
                        colCnt <= colCnt + 1;
                    end
                end
            end
            INPUT2:begin
                if(row_end)begin
                    row2 <= rowCnt;
                    col2 <= colCnt;
                    rowCnt <= 0;
                    colCnt <= 0;
                end else if(col_end)begin
                    colCnt <= 0;
                    rowCnt <= rowCnt + 1;
                end else begin
                    colCnt <= colCnt + 1;
                end
            end
            CAL: calCnt <= calCnt + 1;
            OUTPUT:begin
                if((rowCnt == row1 && colCnt == col2) || col1 != row2)begin
                    rowCnt <= 0;
                    colCnt <= 0;
                    calCnt <= 0;
                end else begin
                    if(colCnt == col2)begin
                        colCnt <= 0;
                        rowCnt <= rowCnt + 1;
                        calCnt <= 0;
                    end else begin
                        colCnt <= colCnt + 1;
                        calCnt <= 0;
                    end
                end
            end
        endcase
    end
end

always @(posedge clk or posedge rst) begin //out_data
    if(rst)begin
        out_data <= 0;
    end else begin
        case(state)
            CAL: out_data <= out_data + (matrix1[rowCnt][calCnt] * matrix2[calCnt][colCnt]);
            OUTPUT: out_data <= 0;
        endcase
    end
end

always @(posedge clk)begin //matrix
    case(state)
        INPUT1: matrix1[rowCnt][colCnt] <= in_data;
        INPUT2: matrix2[rowCnt][colCnt] <= in_data;
    endcase
end

assign change_row = (colCnt == col2); //change_row

assign valid = (state == OUTPUT); //valid

assign is_legal = (col1 == row2); //is_legal

assign busy = (state == CAL || state == OUTPUT); //busy

endmodule
