module Butterfly(
    input signed [31:0] a, //sign bit + Integer 15 bit . Fraction 16 bit
    input signed [31:0] b, //sign bit + Integer 15 bit . Fraction 16 bit
    input signed [31:0] c, //sign bit + Integer 15 bit . Fraction 16 bit
    input signed [31:0] d, //sign bit + Integer 15 bit . Fraction 16 bit
    input signed [31:0] w_real, //sign bit + Integer 15 bit . Fraction 16 bit
    input signed [31:0] w_img, //sign bit + Integer 15 bit . Fraction 16 bit
    output signed [31:0] fft_a_real, //sign bit + Integer 15 bit . Fraction 16 bit
    output signed [31:0] fft_a_img, //sign bit + Integer 15 bit . Fraction 16 bit
    output signed [31:0] fft_b_real, //sign bit + Integer 15 bit . Fraction 16 bit
    output signed [31:0] fft_b_img //sign bit + Integer 15 bit . Fraction 16 bit
);

//fft_a
assign fft_a_real = a + c;
assign fft_a_img = b + d;

//fft_b
wire signed [31:0] a_c; //sign bit + Integer 15 bit . Fraction 16 bit
wire signed [31:0] d_b; //sign bit + Integer 15 bit . Fraction 16 bit
wire signed [62:0] a_c_w_real; //sign bit + Integer 30bit . Fraction 32 bit
wire signed [62:0] a_c_w_img;  //sign bit + Integer 30bit . Fraction 32 bit
wire signed [62:0] d_b_w_real; //sign bit + Integer 30bit . Fraction 32 bit
wire signed [62:0] d_b_w_img;  //sign bit + Integer 30bit . Fraction 32 bit
wire signed [63:0] fft_b_real_temp; //sign bit + Integer 31bit . Fraction 32 bit
wire signed [63:0] fft_b_img_temp;  //sign bit + Integer 31bit . Fraction 32 bit

assign a_c = a - c;
assign d_b = d - b;

assign a_c_w_real = a_c * w_real; 
assign a_c_w_img = a_c * w_img;
assign d_b_w_real = d_b * w_real;
assign d_b_w_img = d_b * w_img;
assign fft_b_real_temp = a_c_w_real + d_b_w_img;
assign fft_b_img_temp = a_c_w_img - d_b_w_real;

//fft_b result
assign fft_b_real = {fft_b_real_temp[47:16]};
assign fft_b_img = {fft_b_img_temp[47:16]};

endmodule