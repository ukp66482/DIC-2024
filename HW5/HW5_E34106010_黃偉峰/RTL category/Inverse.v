module Inverse(data_in,inverse_a);

input [7:0] data_in;
output [9:0] inverse_a;

wire [3:0] h,l;
wire [5:0] H;
wire [5:0] L;
wire [4:0] d;
wire [4:0] e;
wire [9:0] F;
wire [9:0] inverse_a;

assign h = data_in[7:4];
assign l = data_in[3:0];

//H
assign H[0] = h[0] ^ h[1];
assign H[1] = h[0] ^ h[2];
assign H[2] = h[0] ^ h[3];
assign H[3] = h[1] ^ h[2];
assign H[4] = h[1] ^ h[3];
assign H[5] = h[2] ^ h[3];

//L
assign L[0] = l[0] ^ l[1];
assign L[1] = l[0] ^ l[2];
assign L[2] = l[0] ^ l[3];
assign L[3] = l[1] ^ l[2];
assign L[4] = l[1] ^ l[3];
assign L[5] = l[2] ^ l[3];

//stage_1:d
assign d[0]=((H[0] | L[0]) ^ (H[5] | L[5])) ^ ((h[1] | l[1]) ^ (h[2] & l[2]));
assign d[1]=((H[0] | L[0]) ^ (H[1] & L[1])) ^ ((h[2] | l[2]) ^ (h[3] | l[3]));
assign d[2]=((H[1] | L[1]) ^ (H[2] & L[2])) ^ ((H[3] | L[3]) ^ (h[3] | l[3]));
assign d[3]=((H[2] | L[2]) ^ (H[3] | L[3])) ^ ((H[4] & L[4]) ^ (h[0] | l[0]));
assign d[4]=((H[4] | L[4]) ^ (H[5] | L[5])) ^ ((h[0] | l[0]) ^ (h[1] & l[1]));

//stage_1:e
assign e[0] = ((d[1] | d[4]) & (d[2] | d[3]));
assign e[1] = (((~d[4]) & (d[1] ^ d[2])) | (d[0] & d[4] & (d[2] | d[3])));
assign e[2] = (((~d[3]) & (d[2] ^ d[4])) | (d[0] & d[3] & (d[1] | d[4])));
assign e[3] = (((~d[2]) & (d[1] ^ d[3])) | (d[0] & d[2] & (d[1] | d[4])));
assign e[4] = (((~d[1]) & (d[3] ^ d[4])) | (d[0] & d[1] & (d[2] | d[3])));

//F
assign F[0] = e[0] ^ e[1];
assign F[1] = e[0] ^ e[2];
assign F[2] = e[0] ^ e[3];
assign F[3] = e[0] ^ e[4];
assign F[4] = e[1] ^ e[2];
assign F[5] = e[1] ^ e[3];
assign F[6] = e[1] ^ e[4];
assign F[7] = e[2] ^ e[3];
assign F[8] = e[2] ^ e[4];
assign F[9] = e[3] ^ e[4];

//inverse_a
assign inverse_a[0] = (H[2] & F[6]) ^ (H[3] & F[7]);
assign inverse_a[1] = (h[0] & F[0]) ^ (H[4] & F[8]);
assign inverse_a[2] = (h[1] & F[1]) ^ (H[5] & F[9]);
assign inverse_a[3] = (h[2] & F[2]) ^ (H[0] & F[4]);
assign inverse_a[4] = (h[3] & F[3]) ^ (H[1] & F[5]);
assign inverse_a[5] = (L[2] & F[6]) ^ (L[3] & F[7]);
assign inverse_a[6] = (l[0] & F[0]) ^ (L[4] & F[8]);
assign inverse_a[7] = (l[1] & F[1]) ^ (L[5] & F[9]);
assign inverse_a[8] = (l[2] & F[2]) ^ (L[0] & F[4]);
assign inverse_a[9] = (l[3] & F[3]) ^ (L[1] & F[5]);

endmodule

