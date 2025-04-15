// 
// Designer: E34106010
//

module AES(
    input clk,
    input rst,
    input [127:0] P,
    input [127:0] K,
    output reg [127:0] C,
    output reg valid
    );
    
    wire [127:0] DFF_P0_OUT, DFF_K0_OUT, AddRoundKey_0_OUT, KeyExpansion_1_OUT, SubByte_1_OUT, ShiftRows_1_OUT, MixColumn_1_OUT, AddRoundKey_1_OUT, DFF_P1_OUT_1, DFF_K1_OUT_1;
    wire [127:0] DFF_P1_OUT, DFF_K1_OUT, KeyExpansion_2_OUT, SubByte_2_OUT, ShiftRows_2_OUT, MixColumn_2_OUT, AddRoundKey_2_OUT, DFF_P2_OUT_1, DFF_K2_OUT_1;
    wire [127:0] DFF_P2_OUT, DFF_K2_OUT, KeyExpansion_3_OUT, SubByte_3_OUT, ShiftRows_3_OUT, MixColumn_3_OUT, AddRoundKey_3_OUT, DFF_P3_OUT_1, DFF_K3_OUT_1;
    wire [127:0] DFF_P3_OUT, DFF_K3_OUT, KeyExpansion_4_OUT, SubByte_4_OUT, ShiftRows_4_OUT, MixColumn_4_OUT, AddRoundKey_4_OUT, DFF_P4_OUT_1, DFF_K4_OUT_1;
    wire [127:0] DFF_P4_OUT, DFF_K4_OUT, KeyExpansion_5_OUT, SubByte_5_OUT, ShiftRows_5_OUT, MixColumn_5_OUT, AddRoundKey_5_OUT, DFF_P5_OUT_1, DFF_K5_OUT_1;
    wire [127:0] DFF_P5_OUT, DFF_K5_OUT, KeyExpansion_6_OUT, SubByte_6_OUT, ShiftRows_6_OUT, MixColumn_6_OUT, AddRoundKey_6_OUT, DFF_P6_OUT_1, DFF_K6_OUT_1;
    wire [127:0] DFF_P6_OUT, DFF_K6_OUT, KeyExpansion_7_OUT, SubByte_7_OUT, ShiftRows_7_OUT, MixColumn_7_OUT, AddRoundKey_7_OUT, DFF_P7_OUT_1, DFF_K7_OUT_1;
    wire [127:0] DFF_P7_OUT, DFF_K7_OUT, KeyExpansion_8_OUT, SubByte_8_OUT, ShiftRows_8_OUT, MixColumn_8_OUT, AddRoundKey_8_OUT, DFF_P8_OUT_1, DFF_K8_OUT_1;
    wire [127:0] DFF_P8_OUT, DFF_K8_OUT, KeyExpansion_9_OUT, SubByte_9_OUT, ShiftRows_9_OUT, MixColumn_9_OUT, AddRoundKey_9_OUT, DFF_P9_OUT_1, DFF_K9_OUT_1;
    wire [127:0] DFF_P9_OUT, DFF_K9_OUT, KeyExpansion_10_OUT, SubByte_10_OUT, ShiftRows_10_OUT, AddRoundKey_10_OUT, DFF_P10_OUT_1, DFF_K10_OUT_1;
    reg [4:0] valid_cnt;

    
    AddRoundKey AddRoundKey_0(P , K, AddRoundKey_0_OUT);
    DFF_128 DFF_128_P0(clk, rst, AddRoundKey_0_OUT, DFF_P0_OUT);
    DFF_128 DFF_128_K0(clk, rst, K, DFF_K0_OUT);
    KeyExpansion KeyExpansion_1(DFF_K0_OUT, 32'h01000000, KeyExpansion_1_OUT);
    SubByte SubByte_1(DFF_P0_OUT, SubByte_1_OUT);
    DFF_128 DFF_128_P1_1(clk, rst, SubByte_1_OUT, DFF_P1_OUT_1);
    DFF_128 DFF_128_K1_1(clk, rst, KeyExpansion_1_OUT, DFF_K1_OUT_1);
    ShiftRows ShiftRows_1(DFF_P1_OUT_1, ShiftRows_1_OUT);
    MixColumn MixColumn_1(ShiftRows_1_OUT, MixColumn_1_OUT);
    AddRoundKey AddRoundKey_1(MixColumn_1_OUT, DFF_K1_OUT_1, AddRoundKey_1_OUT);

    DFF_128 DFF_128_P1(clk, rst, AddRoundKey_1_OUT, DFF_P1_OUT);
    DFF_128 DFF_128_K1(clk, rst, DFF_K1_OUT_1, DFF_K1_OUT);
    KeyExpansion KeyExpansion_2(DFF_K1_OUT, 32'h02000000, KeyExpansion_2_OUT);
    SubByte SubByte_2(DFF_P1_OUT, SubByte_2_OUT);
    DFF_128 DFF_128_P2_1(clk, rst, SubByte_2_OUT, DFF_P2_OUT_1);
    DFF_128 DFF_128_K2_1(clk, rst, KeyExpansion_2_OUT, DFF_K2_OUT_1);
    ShiftRows ShiftRows_2(DFF_P2_OUT_1, ShiftRows_2_OUT);
    MixColumn MixColumn_2(ShiftRows_2_OUT, MixColumn_2_OUT);
    AddRoundKey AddRoundKey_2(MixColumn_2_OUT, DFF_K2_OUT_1, AddRoundKey_2_OUT);

    DFF_128 DFF_128_P2(clk, rst, AddRoundKey_2_OUT, DFF_P2_OUT);
    DFF_128 DFF_128_K2(clk, rst, DFF_K2_OUT_1, DFF_K2_OUT);
    KeyExpansion KeyExpansion_3(DFF_K2_OUT, 32'h04000000, KeyExpansion_3_OUT);
    SubByte SubByte_3(DFF_P2_OUT, SubByte_3_OUT);
    DFF_128 DFF_128_P3_1(clk, rst, SubByte_3_OUT, DFF_P3_OUT_1);
    DFF_128 DFF_128_K3_1(clk, rst, KeyExpansion_3_OUT, DFF_K3_OUT_1);
    ShiftRows ShiftRows_3(DFF_P3_OUT_1, ShiftRows_3_OUT);
    MixColumn MixColumn_3(ShiftRows_3_OUT, MixColumn_3_OUT);
    AddRoundKey AddRoundKey_3(MixColumn_3_OUT, DFF_K3_OUT_1, AddRoundKey_3_OUT);

    DFF_128 DFF_128_P3(clk, rst, AddRoundKey_3_OUT, DFF_P3_OUT);
    DFF_128 DFF_128_K3(clk, rst, DFF_K3_OUT_1, DFF_K3_OUT);
    KeyExpansion KeyExpansion_4(DFF_K3_OUT, 32'h08000000, KeyExpansion_4_OUT);
    SubByte SubByte_4(DFF_P3_OUT, SubByte_4_OUT);
    DFF_128 DFF_128_P4_1(clk, rst, SubByte_4_OUT, DFF_P4_OUT_1);
    DFF_128 DFF_128_K4_1(clk, rst, KeyExpansion_4_OUT, DFF_K4_OUT_1);
    ShiftRows ShiftRows_4(DFF_P4_OUT_1, ShiftRows_4_OUT);
    MixColumn MixColumn_4(ShiftRows_4_OUT, MixColumn_4_OUT);
    AddRoundKey AddRoundKey_4(MixColumn_4_OUT, DFF_K4_OUT_1, AddRoundKey_4_OUT);

    DFF_128 DFF_128_P4(clk, rst, AddRoundKey_4_OUT, DFF_P4_OUT);
    DFF_128 DFF_128_K4(clk, rst, DFF_K4_OUT_1, DFF_K4_OUT);
    KeyExpansion KeyExpansion_5(DFF_K4_OUT, 32'h10000000, KeyExpansion_5_OUT);
    SubByte SubByte_5(DFF_P4_OUT, SubByte_5_OUT);
    DFF_128 DFF_128_P5_1(clk, rst, SubByte_5_OUT, DFF_P5_OUT_1);
    DFF_128 DFF_128_K5_1(clk, rst, KeyExpansion_5_OUT, DFF_K5_OUT_1);
    ShiftRows ShiftRows_5(DFF_P5_OUT_1, ShiftRows_5_OUT);
    MixColumn MixColumn_5(ShiftRows_5_OUT, MixColumn_5_OUT);
    AddRoundKey AddRoundKey_5(MixColumn_5_OUT, DFF_K5_OUT_1, AddRoundKey_5_OUT);


    DFF_128 DFF_128_P5(clk, rst, AddRoundKey_5_OUT, DFF_P5_OUT);
    DFF_128 DFF_128_K5(clk, rst, DFF_K5_OUT_1, DFF_K5_OUT);
    KeyExpansion KeyExpansion_6(DFF_K5_OUT, 32'h20000000, KeyExpansion_6_OUT);
    SubByte SubByte_6(DFF_P5_OUT, SubByte_6_OUT);
    DFF_128 DFF_128_P6_1(clk, rst, SubByte_6_OUT, DFF_P6_OUT_1);
    DFF_128 DFF_128_K6_1(clk, rst, KeyExpansion_6_OUT, DFF_K6_OUT_1);
    ShiftRows ShiftRows_6(DFF_P6_OUT_1, ShiftRows_6_OUT);
    MixColumn MixColumn_6(ShiftRows_6_OUT, MixColumn_6_OUT);
    AddRoundKey AddRoundKey_6(MixColumn_6_OUT, DFF_K6_OUT_1, AddRoundKey_6_OUT);

    DFF_128 DFF_128_P6(clk, rst, AddRoundKey_6_OUT, DFF_P6_OUT);
    DFF_128 DFF_128_K6(clk, rst, DFF_K6_OUT_1, DFF_K6_OUT);
    KeyExpansion KeyExpansion_7(DFF_K6_OUT, 32'h40000000, KeyExpansion_7_OUT);
    SubByte SubByte_7(DFF_P6_OUT, SubByte_7_OUT);
    DFF_128 DFF_128_P7_1(clk, rst, SubByte_7_OUT, DFF_P7_OUT_1);
    DFF_128 DFF_128_K7_1(clk, rst, KeyExpansion_7_OUT, DFF_K7_OUT_1);
    ShiftRows ShiftRows_7(DFF_P7_OUT_1, ShiftRows_7_OUT);
    MixColumn MixColumn_7(ShiftRows_7_OUT, MixColumn_7_OUT);
    AddRoundKey AddRoundKey_7(MixColumn_7_OUT, DFF_K7_OUT_1, AddRoundKey_7_OUT);

    DFF_128 DFF_128_P7(clk, rst, AddRoundKey_7_OUT, DFF_P7_OUT);
    DFF_128 DFF_128_K7(clk, rst, DFF_K7_OUT_1, DFF_K7_OUT);
    KeyExpansion KeyExpansion_8(DFF_K7_OUT, 32'h80000000, KeyExpansion_8_OUT);
    SubByte SubByte_8(DFF_P7_OUT, SubByte_8_OUT);
    DFF_128 DFF_128_P8_1(clk, rst, SubByte_8_OUT, DFF_P8_OUT_1);
    DFF_128 DFF_128_K8_1(clk, rst, KeyExpansion_8_OUT, DFF_K8_OUT_1);
    ShiftRows ShiftRows_8(DFF_P8_OUT_1, ShiftRows_8_OUT);
    MixColumn MixColumn_8(ShiftRows_8_OUT, MixColumn_8_OUT);
    AddRoundKey AddRoundKey_8(MixColumn_8_OUT, DFF_K8_OUT_1, AddRoundKey_8_OUT);

    DFF_128 DFF_128_P8(clk, rst, AddRoundKey_8_OUT, DFF_P8_OUT);
    DFF_128 DFF_128_K8(clk, rst, DFF_K8_OUT_1, DFF_K8_OUT);
    KeyExpansion KeyExpansion_9(DFF_K8_OUT, 32'h1b000000, KeyExpansion_9_OUT);
    SubByte SubByte_9(DFF_P8_OUT, SubByte_9_OUT);
    DFF_128 DFF_128_P9_1(clk, rst, SubByte_9_OUT, DFF_P9_OUT_1);
    DFF_128 DFF_128_K9_1(clk, rst, KeyExpansion_9_OUT, DFF_K9_OUT_1);
    ShiftRows ShiftRows_9(DFF_P9_OUT_1, ShiftRows_9_OUT);
    MixColumn MixColumn_9(ShiftRows_9_OUT, MixColumn_9_OUT);
    AddRoundKey AddRoundKey_9(MixColumn_9_OUT, DFF_K9_OUT_1, AddRoundKey_9_OUT);

    DFF_128 DFF_128_P9(clk, rst, AddRoundKey_9_OUT, DFF_P9_OUT);
    DFF_128 DFF_128_K9(clk, rst, DFF_K9_OUT_1, DFF_K9_OUT);
    KeyExpansion KeyExpansion_10(DFF_K9_OUT, 32'h36000000, KeyExpansion_10_OUT);
    SubByte SubByte_10(DFF_P9_OUT, SubByte_10_OUT);
    DFF_128 DFF_128_P10_1(clk, rst, SubByte_10_OUT, DFF_P10_OUT_1);
    DFF_128 DFF_128_K10_1(clk, rst, KeyExpansion_10_OUT, DFF_K10_OUT_1);
    ShiftRows ShiftRows_10(DFF_P10_OUT_1, ShiftRows_10_OUT);
    AddRoundKey AddRoundKey_10(ShiftRows_10_OUT, DFF_K10_OUT_1, AddRoundKey_10_OUT);

    always @(posedge clk or posedge rst)begin //C
        if(rst)begin
            C <= 128'b0;
        end else begin
            C <= AddRoundKey_10_OUT;
        end
    end

    always @(posedge clk or posedge rst) begin //valid_cnt
        if(rst)begin
            valid_cnt <= 0;
        end else begin
            if(valid_cnt <= 5'd21) valid_cnt <= valid_cnt + 1;
        end
    end

    always @(posedge clk or posedge rst)begin //valid
        if(rst)begin
            valid <= 1'b0;
        end else begin
            if(valid_cnt >= 5'd21) valid <= 1'b1;
            else valid <= 1'b0;
        end
    end


endmodule