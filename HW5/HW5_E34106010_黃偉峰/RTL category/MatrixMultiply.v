module MatrixMultiply(x2, x3, x1_0, x1_1, data_out);
    input [7:0] x2, x3, x1_0, x1_1;
    output [7:0] data_out;

    assign data_out[0] = x2[7] ^ x3[0] ^ x3[7] ^ x1_0[0] ^ x1_1[0];
    assign data_out[1] = x2[0] ^ x2[7] ^ x3[0] ^ x3[1] ^ x3[7] ^ x1_0[1] ^ x1_1[1];
    assign data_out[2] = x2[1] ^ x3[1] ^ x3[2] ^ x1_1[2] ^ x1_0[2];
    assign data_out[3] = x2[2] ^ x2[7] ^ x3[2] ^ x3[3] ^ x3[7] ^ x1_0[3] ^ x1_1[3];
    assign data_out[4] = x2[3] ^ x2[7] ^ x3[3] ^ x3[4] ^ x3[7] ^ x1_0[4] ^ x1_1[4];
    assign data_out[5] = x2[4] ^ x3[4] ^ x3[5] ^ x1_1[5] ^ x1_0[5];
    assign data_out[6] = x2[5] ^ x3[5] ^ x3[6] ^ x1_1[6] ^ x1_0[6];
    assign data_out[7] = x2[6] ^ x3[6] ^ x3[7] ^ x1_1[7] ^ x1_0[7];

endmodule