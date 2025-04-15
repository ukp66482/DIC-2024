module BMenc(in,enc);

input [9:0] in;
output [7:0] enc;

assign enc[7]=in[0]^in[3]^in[5]^in[6]^in[7]^in[9];
assign enc[6]=in[1]^in[2]^in[5]^in[6]^1;
assign enc[5]=in[1]^in[4]^in[6]^in[7]^in[8]^in[9]^1;
assign enc[4]=in[0]^in[2]^in[8]^in[9];
assign enc[3]=in[2]^in[3]^in[5]^in[6]^in[8]^in[9];
assign enc[2]=in[1]^in[3]^in[5]^in[6]^in[7]^in[9];
assign enc[1]=in[1]^in[2]^in[6]^in[9]^1;
assign enc[0]=in[0]^in[1]^in[3]^in[4]^1;

endmodule
