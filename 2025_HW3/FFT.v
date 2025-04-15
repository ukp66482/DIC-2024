`include "Butterfly.v"
`include "Serial_to_Parallel.v"

module  FFT(
    input           clk      , 
    input           rst      , 
    input  [15:0]   fir_d    , 
    input           fir_valid,
    output reg      fft_valid, 
    output reg      done     ,
    output reg [15:0]   fft_d1   , 
    output reg [15:0]   fft_d2   ,
    output reg [15:0]   fft_d3   , 
    output reg [15:0]   fft_d4   , 
    output reg [15:0]   fft_d5   , 
    output reg [15:0]   fft_d6   , 
    output reg [15:0]   fft_d7   , 
    output reg [15:0]   fft_d8   ,
    output reg [15:0]   fft_d9   , 
    output reg [15:0]   fft_d10  , 
    output reg [15:0]   fft_d11  , 
    output reg [15:0]   fft_d12  , 
    output reg [15:0]   fft_d13  , 
    output reg [15:0]   fft_d14  , 
    output reg [15:0]   fft_d15  , 
    output reg [15:0]   fft_d0
);

parameter 
W0_real = 32'h00010000,
W0_img = 32'h00000000,
W1_real = 32'h0000EC83,
W1_img = 32'hFFFF9E09,
W2_real = 32'h0000B504,
W2_img = 32'hFFFF4AFC,
W3_real = 32'h000061F7,
W3_img = 32'hFFFF137D,
W4_real = 32'h00000000,
W4_img = 32'hFFFF0000,
W5_real = 32'hFFFF9E09,
W5_img = 32'hFFFF137D,
W6_real = 32'hFFFF4AFC,
W6_img = 32'hFFFF4AFC,
W7_real = 32'hFFFF137D,
W7_img = 32'hFFFF9E09;

parameter
INPUT = 2'd0,
FFT = 2'd1,
OUTPUT = 2'd2,
DONE = 2'd3;

reg [1:0] state;
reg [1:0] next_state;

//buffer
reg signed [31:0] data_real [15:0];
reg signed [31:0] data_img [15:0];

reg [1:0] round;
integer i;

//a+bj
reg signed [31:0] a [7:0];
reg signed [31:0] b [7:0];
//c+dj
reg signed [31:0] c [7:0];
reg signed [31:0] d [7:0];

reg signed [31:0] w_real [7:0];
reg signed [31:0] w_img [7:0];

reg signed [31:0] fft_a_real [7:0];
reg signed [31:0] fft_a_img [7:0];
reg signed [31:0] fft_b_real [7:0];
reg signed [31:0] fft_b_img [7:0];

wire full;
wire [15:0] bufferout [15:0];

Butterfly butterfly0(.a(a[0]), .b(b[0]), .c(c[0]), .d(d[0]), .w_real(w_real[0]), .w_img(w_img[0]), .fft_a_real(fft_a_real[0]), .fft_a_img(fft_a_img[0]), .fft_b_real(fft_b_real[0]), .fft_b_img(fft_b_img[0]));
Butterfly butterfly1(.a(a[1]), .b(b[1]), .c(c[1]), .d(d[1]), .w_real(w_real[1]), .w_img(w_img[1]), .fft_a_real(fft_a_real[1]), .fft_a_img(fft_a_img[1]), .fft_b_real(fft_b_real[1]), .fft_b_img(fft_b_img[1]));
Butterfly butterfly2(.a(a[2]), .b(b[2]), .c(c[2]), .d(d[2]), .w_real(w_real[2]), .w_img(w_img[2]), .fft_a_real(fft_a_real[2]), .fft_a_img(fft_a_img[2]), .fft_b_real(fft_b_real[2]), .fft_b_img(fft_b_img[2]));
Butterfly butterfly3(.a(a[3]), .b(b[3]), .c(c[3]), .d(d[3]), .w_real(w_real[3]), .w_img(w_img[3]), .fft_a_real(fft_a_real[3]), .fft_a_img(fft_a_img[3]), .fft_b_real(fft_b_real[3]), .fft_b_img(fft_b_img[3]));
Butterfly butterfly4(.a(a[4]), .b(b[4]), .c(c[4]), .d(d[4]), .w_real(w_real[4]), .w_img(w_img[4]), .fft_a_real(fft_a_real[4]), .fft_a_img(fft_a_img[4]), .fft_b_real(fft_b_real[4]), .fft_b_img(fft_b_img[4]));
Butterfly butterfly5(.a(a[5]), .b(b[5]), .c(c[5]), .d(d[5]), .w_real(w_real[5]), .w_img(w_img[5]), .fft_a_real(fft_a_real[5]), .fft_a_img(fft_a_img[5]), .fft_b_real(fft_b_real[5]), .fft_b_img(fft_b_img[5]));
Butterfly butterfly6(.a(a[6]), .b(b[6]), .c(c[6]), .d(d[6]), .w_real(w_real[6]), .w_img(w_img[6]), .fft_a_real(fft_a_real[6]), .fft_a_img(fft_a_img[6]), .fft_b_real(fft_b_real[6]), .fft_b_img(fft_b_img[6]));
Butterfly butterfly7(.a(a[7]), .b(b[7]), .c(c[7]), .d(d[7]), .w_real(w_real[7]), .w_img(w_img[7]), .fft_a_real(fft_a_real[7]), .fft_a_img(fft_a_img[7]), .fft_b_real(fft_b_real[7]), .fft_b_img(fft_b_img[7]));

Serial_to_Parallel Serial_to_Parallel(.clk(clk), .rst(rst), .fir_valid(fir_valid), .data_in(fir_d), .full(full), 
    .data_out_0(bufferout[0]), .data_out_1(bufferout[1]), .data_out_2(bufferout[2]), .data_out_3(bufferout[3]), 
    .data_out_4(bufferout[4]), .data_out_5(bufferout[5]), .data_out_6(bufferout[6]), .data_out_7(bufferout[7]), 
    .data_out_8(bufferout[8]), .data_out_9(bufferout[9]), .data_out_10(bufferout[10]), .data_out_11(bufferout[11]), 
    .data_out_12(bufferout[12]), .data_out_13(bufferout[13]), .data_out_14(bufferout[14]), .data_out_15(bufferout[15])
    );

always @(posedge clk or posedge rst) begin //state
    if(rst) state <= INPUT;
    else state <= next_state;
end

always @(*) begin //next_state
    case(state)
        INPUT:begin
            if(full) next_state = FFT;
            else next_state = INPUT;
        end
        FFT:begin
            if(round == 2'd3) next_state = OUTPUT;
            else next_state = FFT;
        end
        OUTPUT:begin //round = 0 OUTPUT REAL, round = 1 OUTPUT IMG
            if(round)begin
                if(fir_valid) next_state = INPUT;
                else next_state = DONE;
            end else next_state = OUTPUT;
        end
        DONE:next_state = DONE;
    endcase
end

always @(posedge clk or posedge rst) begin //round
    if(rst) round <= 2'd0;
    else begin
        case(state)
            INPUT: round <= 2'd0;
            FFT: round <= round + 2'd1;
            OUTPUT: round <= round + 2'd1;
            DONE: round <= 2'd0;
        endcase
    end
end

always @(posedge clk or posedge rst) begin //data_real data_img
    case(state)
        INPUT:begin
            if(full)begin
                for(i=0;i<16;i=i+1)begin
                    data_real[i] <= {{8{bufferout[i][15]}}, bufferout[i], 8'd0};
                    data_img[i] <= 32'd0;
                end
            end
        end
        FFT:begin
            case(round)
                2'd0:begin
                    data_real[0] <= fft_a_real[0];
                    data_img[0] <= fft_a_img[0];
                    data_real[8] <= fft_b_real[0];
                    data_img[8] <= fft_b_img[0];
                    data_real[1] <= fft_a_real[1];
                    data_img[1] <= fft_a_img[1];
                    data_real[9] <= fft_b_real[1];
                    data_img[9] <= fft_b_img[1];
                    data_real[2] <= fft_a_real[2];
                    data_img[2] <= fft_a_img[2];
                    data_real[10] <= fft_b_real[2];
                    data_img[10] <= fft_b_img[2];
                    data_real[3] <= fft_a_real[3];
                    data_img[3] <= fft_a_img[3];
                    data_real[11] <= fft_b_real[3];
                    data_img[11] <= fft_b_img[3];
                    data_real[4] <= fft_a_real[4];
                    data_img[4] <= fft_a_img[4];
                    data_real[12] <= fft_b_real[4];
                    data_img[12] <= fft_b_img[4];
                    data_real[5] <= fft_a_real[5];
                    data_img[5] <= fft_a_img[5];
                    data_real[13] <= fft_b_real[5];
                    data_img[13] <= fft_b_img[5];
                    data_real[6] <= fft_a_real[6];
                    data_img[6] <= fft_a_img[6];
                    data_real[14] <= fft_b_real[6];
                    data_img[14] <= fft_b_img[6];
                    data_real[7] <= fft_a_real[7];
                    data_img[7] <= fft_a_img[7];
                    data_real[15] <= fft_b_real[7];
                    data_img[15] <= fft_b_img[7];
                end
                2'd1:begin
                    data_real[0] <= fft_a_real[0];
                    data_img[0] <= fft_a_img[0];
                    data_real[4] <= fft_b_real[0];
                    data_img[4] <= fft_b_img[0];
                    data_real[1] <= fft_a_real[1];
                    data_img[1] <= fft_a_img[1];
                    data_real[5] <= fft_b_real[1];
                    data_img[5] <= fft_b_img[1];
                    data_real[2] <= fft_a_real[2];
                    data_img[2] <= fft_a_img[2];
                    data_real[6] <= fft_b_real[2];
                    data_img[6] <= fft_b_img[2];
                    data_real[3] <= fft_a_real[3];
                    data_img[3] <= fft_a_img[3];
                    data_real[7] <= fft_b_real[3];
                    data_img[7] <= fft_b_img[3];
                    data_real[8] <= fft_a_real[4];
                    data_img[8] <= fft_a_img[4];
                    data_real[12] <= fft_b_real[4];
                    data_img[12] <= fft_b_img[4];
                    data_real[9] <= fft_a_real[5];
                    data_img[9] <= fft_a_img[5];
                    data_real[13] <= fft_b_real[5];
                    data_img[13] <= fft_b_img[5];
                    data_real[10] <= fft_a_real[6];
                    data_img[10] <= fft_a_img[6];
                    data_real[14] <= fft_b_real[6];
                    data_img[14] <= fft_b_img[6];
                    data_real[11] <= fft_a_real[7];
                    data_img[11] <= fft_a_img[7];
                    data_real[15] <= fft_b_real[7];
                    data_img[15] <= fft_b_img[7];
                end
                2'd2:begin
                    data_real[0] <= fft_a_real[0];
                    data_img[0] <= fft_a_img[0];
                    data_real[2] <= fft_b_real[0];
                    data_img[2] <= fft_b_img[0];
                    data_real[1] <= fft_a_real[1];
                    data_img[1] <= fft_a_img[1];
                    data_real[3] <= fft_b_real[1];
                    data_img[3] <= fft_b_img[1];
                    data_real[4] <= fft_a_real[2];
                    data_img[4] <= fft_a_img[2];
                    data_real[6] <= fft_b_real[2];
                    data_img[6] <= fft_b_img[2];
                    data_real[5] <= fft_a_real[3];
                    data_img[5] <= fft_a_img[3];
                    data_real[7] <= fft_b_real[3];
                    data_img[7] <= fft_b_img[3];
                    data_real[8] <= fft_a_real[4];
                    data_img[8] <= fft_a_img[4];
                    data_real[10] <= fft_b_real[4];
                    data_img[10] <= fft_b_img[4];
                    data_real[9] <= fft_a_real[5];
                    data_img[9] <= fft_a_img[5];
                    data_real[11] <= fft_b_real[5];
                    data_img[11] <= fft_b_img[5];
                    data_real[12] <= fft_a_real[6];
                    data_img[12] <= fft_a_img[6];
                    data_real[14] <= fft_b_real[6];
                    data_img[14] <= fft_b_img[6];
                    data_real[13] <= fft_a_real[7];
                    data_img[13] <= fft_a_img[7];
                    data_real[15] <= fft_b_real[7];
                    data_img[15] <= fft_b_img[7];
                end
                2'd3:begin
                    data_real[0] <= fft_a_real[0];
                    data_img[0] <= fft_a_img[0];
                    data_real[1] <= fft_b_real[0];
                    data_img[1] <= fft_b_img[0];
                    data_real[2] <= fft_a_real[1];
                    data_img[2] <= fft_a_img[1];
                    data_real[3] <= fft_b_real[1];
                    data_img[3] <= fft_b_img[1];
                    data_real[4] <= fft_a_real[2];
                    data_img[4] <= fft_a_img[2];
                    data_real[5] <= fft_b_real[2];
                    data_img[5] <= fft_b_img[2];
                    data_real[6] <= fft_a_real[3];
                    data_img[6] <= fft_a_img[3];
                    data_real[7] <= fft_b_real[3];
                    data_img[7] <= fft_b_img[3];
                    data_real[8] <= fft_a_real[4];
                    data_img[8] <= fft_a_img[4];
                    data_real[9] <= fft_b_real[4];
                    data_img[9] <= fft_b_img[4];
                    data_real[10] <= fft_a_real[5];
                    data_img[10] <= fft_a_img[5];
                    data_real[11] <= fft_b_real[5];
                    data_img[11] <= fft_b_img[5];
                    data_real[12] <= fft_a_real[6];
                    data_img[12] <= fft_a_img[6];
                    data_real[13] <= fft_b_real[6];
                    data_img[13] <= fft_b_img[6];
                    data_real[14] <= fft_a_real[7];
                    data_img[14] <= fft_a_img[7];
                    data_real[15] <= fft_b_real[7];
                    data_img[15] <= fft_b_img[7];
                end
            endcase
        end
    endcase
end

always @(posedge clk) begin
    if(state == OUTPUT)begin
        case(round)
            1'b0:begin
                fft_d0 <= data_real[0][23:8];
                fft_d1 <= data_real[8][23:8];
                fft_d2 <= data_real[4][23:8];
                fft_d3 <= data_real[12][23:8];
                fft_d4 <= data_real[2][23:8];
                fft_d5 <= data_real[10][23:8];
                fft_d6 <= data_real[6][23:8];
                fft_d7 <= data_real[14][23:8];
                fft_d8 <= data_real[1][23:8];
                fft_d9 <= data_real[9][23:8];
                fft_d10 <= data_real[5][23:8];
                fft_d11 <= data_real[13][23:8];
                fft_d12 <= data_real[3][23:8];
                fft_d13 <= data_real[11][23:8];
                fft_d14 <= data_real[7][23:8];
                fft_d15 <= data_real[15][23:8];
            end
            1'b1:begin
                fft_d0 <= data_img[0][23:8];
                fft_d1 <= data_img[8][23:8];
                fft_d2 <= data_img[4][23:8];
                fft_d3 <= data_img[12][23:8];
                fft_d4 <= data_img[2][23:8];
                fft_d5 <= data_img[10][23:8];
                fft_d6 <= data_img[6][23:8];
                fft_d7 <= data_img[14][23:8];
                fft_d8 <= data_img[1][23:8];
                fft_d9 <= data_img[9][23:8];
                fft_d10 <= data_img[5][23:8];
                fft_d11 <= data_img[13][23:8];
                fft_d12 <= data_img[3][23:8];
                fft_d13 <= data_img[11][23:8];
                fft_d14 <= data_img[7][23:8];
                fft_d15 <= data_img[15][23:8];
            end
        endcase
    end
end

always @(posedge clk or posedge rst) begin //fft_valid
    if(rst) fft_valid <= 1'b0;
    else if(state == OUTPUT) fft_valid <= 1'b1;
    else fft_valid <= 1'b0;
end

always @(posedge clk or posedge rst) begin //done
    if(rst) done <= 1'b0;
    else if(state == DONE) done <= 1'b1;
    else done <= 1'b0;
end

always @(*) begin
    case(round)
        2'd0:begin
            a[0] = data_real[0];
            b[0] = data_img[0];
            c[0] = data_real[8];
            d[0] = data_img[8];
            w_real[0] = W0_real;
            w_img[0] = W0_img;
            a[1] = data_real[1];
            b[1] = data_img[1];
            c[1] = data_real[9];
            d[1] = data_img[9];
            w_real[1] = W1_real;
            w_img[1] = W1_img;
            a[2] = data_real[2];
            b[2] = data_img[2];
            c[2] = data_real[10];
            d[2] = data_img[10];
            w_real[2] = W2_real;
            w_img[2] = W2_img;
            a[3] = data_real[3];
            b[3] = data_img[3];
            c[3] = data_real[11];
            d[3] = data_img[11];
            w_real[3] = W3_real;
            w_img[3] = W3_img;
            a[4] = data_real[4];
            b[4] = data_img[4];
            c[4] = data_real[12];
            d[4] = data_img[12];
            w_real[4] = W4_real;
            w_img[4] = W4_img;
            a[5] = data_real[5];
            b[5] = data_img[5];
            c[5] = data_real[13];
            d[5] = data_img[13];
            w_real[5] = W5_real;
            w_img[5] = W5_img;
            a[6] = data_real[6];
            b[6] = data_img[6];
            c[6] = data_real[14];
            d[6] = data_img[14];
            w_real[6] = W6_real;
            w_img[6] = W6_img;
            a[7] = data_real[7];
            b[7] = data_img[7];
            c[7] = data_real[15];
            d[7] = data_img[15];
            w_real[7] = W7_real;
            w_img[7] = W7_img;
        end
        2'd1:begin
            a[0] = data_real[0];
            b[0] = data_img[0];
            c[0] = data_real[4];
            d[0] = data_img[4];
            w_real[0] = W0_real;
            w_img[0] = W0_img;
            a[1] = data_real[1];
            b[1] = data_img[1];
            c[1] = data_real[5];
            d[1] = data_img[5];
            w_real[1] = W2_real;
            w_img[1] = W2_img;
            a[2] = data_real[2];
            b[2] = data_img[2];
            c[2] = data_real[6];
            d[2] = data_img[6];
            w_real[2] = W4_real;
            w_img[2] = W4_img;
            a[3] = data_real[3];
            b[3] = data_img[3];
            c[3] = data_real[7];
            d[3] = data_img[7];
            w_real[3] = W6_real;
            w_img[3] = W6_img;
            a[4] = data_real[8];
            b[4] = data_img[8];
            c[4] = data_real[12];
            d[4] = data_img[12];
            w_real[4] = W0_real;
            w_img[4] = W0_img;
            a[5] = data_real[9];
            b[5] = data_img[9];
            c[5] = data_real[13];
            d[5] = data_img[13];
            w_real[5] = W2_real;
            w_img[5] = W2_img;
            a[6] = data_real[10];
            b[6] = data_img[10];
            c[6] = data_real[14];
            d[6] = data_img[14];
            w_real[6] = W4_real;
            w_img[6] = W4_img;
            a[7] = data_real[11];
            b[7] = data_img[11];
            c[7] = data_real[15];
            d[7] = data_img[15];
            w_real[7] = W6_real;
            w_img[7] = W6_img;
        end
        2'd2:begin
            a[0] = data_real[0];
            b[0] = data_img[0];
            c[0] = data_real[2];
            d[0] = data_img[2];
            w_real[0] = W0_real;
            w_img[0] = W0_img;
            a[1] = data_real[1];
            b[1] = data_img[1];
            c[1] = data_real[3];
            d[1] = data_img[3];
            w_real[1] = W4_real;
            w_img[1] = W4_img;
            a[2] = data_real[4];
            b[2] = data_img[4];
            c[2] = data_real[6];
            d[2] = data_img[6];
            w_real[2] = W0_real;
            w_img[2] = W0_img;
            a[3] = data_real[5];
            b[3] = data_img[5];
            c[3] = data_real[7];
            d[3] = data_img[7];
            w_real[3] = W4_real;
            w_img[3] = W4_img;
            a[4] = data_real[8];
            b[4] = data_img[8];
            c[4] = data_real[10];
            d[4] = data_img[10];
            w_real[4] = W0_real;
            w_img[4] = W0_img;
            a[5] = data_real[9];
            b[5] = data_img[9];
            c[5] = data_real[11];
            d[5] = data_img[11];
            w_real[5] = W4_real;
            w_img[5] = W4_img;
            a[6] = data_real[12];
            b[6] = data_img[12];
            c[6] = data_real[14];
            d[6] = data_img[14];
            w_real[6] = W0_real;
            w_img[6] = W0_img;
            a[7] = data_real[13];
            b[7] = data_img[13];
            c[7] = data_real[15];
            d[7] = data_img[15];
            w_real[7] = W4_real;
            w_img[7] = W4_img;
        end
        2'd3:begin
            a[0] = data_real[0];
            b[0] = data_img[0];
            c[0] = data_real[1];
            d[0] = data_img[1];
            w_real[0] = W0_real;
            w_img[0] = W0_img;
            a[1] = data_real[2];
            b[1] = data_img[2];
            c[1] = data_real[3];
            d[1] = data_img[3];
            w_real[1] = W0_real;
            w_img[1] = W0_img;
            a[2] = data_real[4];
            b[2] = data_img[4];
            c[2] = data_real[5];
            d[2] = data_img[5];
            w_real[2] = W0_real;
            w_img[2] = W0_img;
            a[3] = data_real[6];
            b[3] = data_img[6];
            c[3] = data_real[7];
            d[3] = data_img[7];
            w_real[3] = W0_real;
            w_img[3] = W0_img;
            a[4] = data_real[8];
            b[4] = data_img[8];
            c[4] = data_real[9];
            d[4] = data_img[9];
            w_real[4] = W0_real;
            w_img[4] = W0_img;
            a[5] = data_real[10];
            b[5] = data_img[10];
            c[5] = data_real[11];
            d[5] = data_img[11];
            w_real[5] = W0_real;
            w_img[5] = W0_img;
            a[6] = data_real[12];
            b[6] = data_img[12];
            c[6] = data_real[13];
            d[6] = data_img[13];
            w_real[6] = W0_real;
            w_img[6] = W0_img;
            a[7] = data_real[14];
            b[7] = data_img[14];
            c[7] = data_real[15];
            d[7] = data_img[15];
            w_real[7] = W0_real;
            w_img[7] = W0_img;
        end
    endcase
end

endmodule