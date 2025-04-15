module DFF_128(clk, rst, data_in, data_out);
    input clk, rst;
    input [127:0] data_in;
    output [127:0] data_out;

    reg [127:0] data_out;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 128'b0;
        end else begin
            data_out <= data_in;
        end
    end
    
endmodule