module TMenc(in,enc);

input [7:0] in;
output [7:0] enc;

assign enc[7]=in[1]^in[2]^in[3]^in[7];
assign enc[6]=in[0]^in[1]^in[5]^in[7];
assign enc[5]=in[3]^in[4]^in[5]^in[6];
assign enc[4]=in[1]^in[4]^in[5];
assign enc[3]=in[1]^in[6];
assign enc[2]=in[1]^in[4]^in[5]^in[7];
assign enc[1]=in[0]^in[4]^in[5];
assign enc[0]=in[3]^in[4]^in[5];

endmodule

