module Serial_to_Parallel(
    input clk,
    input rst,
    input [15:0] data_in,
    input fir_valid,
    output reg full,
    output reg [15:0] data_out_0,
    output reg [15:0] data_out_1,
    output reg [15:0] data_out_2,
    output reg [15:0] data_out_3,
    output reg [15:0] data_out_4,
    output reg [15:0] data_out_5,
    output reg [15:0] data_out_6,
    output reg [15:0] data_out_7,
    output reg [15:0] data_out_8,
    output reg [15:0] data_out_9,
    output reg [15:0] data_out_10,
    output reg [15:0] data_out_11,
    output reg [15:0] data_out_12,
    output reg [15:0] data_out_13,
    output reg [15:0] data_out_14,
    output reg [15:0] data_out_15
);

reg [3:0] cnt;
reg enable;

always @(posedge clk or posedge rst) begin
    if(rst) enable <= 1'd0;
    else enable <= 1'd1;
end

always @(posedge clk or posedge rst) begin //cnt
    if(rst) cnt <= 4'd0;
    else if(fir_valid && enable) cnt <= cnt + 4'd1;
end

always @(posedge clk or posedge rst) begin //full
    if(rst) full <= 1'd0;
    else if(cnt == 4'd15) full <= 1'd1;
    else full <= 1'd0;
end

always @(posedge clk)begin //data_out
    case(cnt)
        4'd0: data_out_0 <= data_in;
        4'd1: data_out_1 <= data_in;
        4'd2: data_out_2 <= data_in;
        4'd3: data_out_3 <= data_in;
        4'd4: data_out_4 <= data_in;
        4'd5: data_out_5 <= data_in;
        4'd6: data_out_6 <= data_in;
        4'd7: data_out_7 <= data_in;
        4'd8: data_out_8 <= data_in;
        4'd9: data_out_9 <= data_in;
        4'd10: data_out_10 <= data_in;
        4'd11: data_out_11 <= data_in;
        4'd12: data_out_12 <= data_in;
        4'd13: data_out_13 <= data_in;
        4'd14: data_out_14 <= data_in;
        4'd15: data_out_15 <= data_in;
    endcase
end

endmodule