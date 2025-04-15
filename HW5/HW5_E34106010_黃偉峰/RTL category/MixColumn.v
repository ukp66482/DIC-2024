module MixColumn(data_in, data_out);
    input [127:0] data_in;
    output [127:0] data_out;

    wire [7:0] S0_0, S0_1, S0_2, S0_3, S1_0, S1_1, S1_2, S1_3, S2_0, S2_1, S2_2, S2_3, S3_0, S3_1, S3_2, S3_3;

    assign S0_0 = data_in[127:120];
    assign S1_0 = data_in[119:112];
    assign S2_0 = data_in[111:104];
    assign S3_0 = data_in[103:96];
    assign S0_1 = data_in[95:88];
    assign S1_1 = data_in[87:80];
    assign S2_1 = data_in[79:72];
    assign S3_1 = data_in[71:64];
    assign S0_2 = data_in[63:56];
    assign S1_2 = data_in[55:48];
    assign S2_2 = data_in[47:40];
    assign S3_2 = data_in[39:32];
    assign S0_3 = data_in[31:24];
    assign S1_3 = data_in[23:16];
    assign S2_3 = data_in[15:8];
    assign S3_3 = data_in[7:0];

    MatrixMultiply M0_0(S0_0, S1_0, S2_0, S3_0, data_out[127:120]);
    MatrixMultiply M1_0(S1_0, S2_0, S3_0, S0_0, data_out[119:112]);
    MatrixMultiply M2_0(S2_0, S3_0, S0_0, S1_0, data_out[111:104]);
    MatrixMultiply M3_0(S3_0, S0_0, S1_0, S2_0, data_out[103:96]);

    MatrixMultiply M0_1(S0_1, S1_1, S2_1, S3_1, data_out[95:88]);
    MatrixMultiply M1_1(S1_1, S2_1, S3_1, S0_1, data_out[87:80]);
    MatrixMultiply M2_1(S2_1, S3_1, S0_1, S1_1, data_out[79:72]);
    MatrixMultiply M3_1(S3_1, S0_1, S1_1, S2_1, data_out[71:64]);

    MatrixMultiply M0_2(S0_2, S1_2, S2_2, S3_2, data_out[63:56]);
    MatrixMultiply M1_2(S1_2, S2_2, S3_2, S0_2, data_out[55:48]);
    MatrixMultiply M2_2(S2_2, S3_2, S0_2, S1_2, data_out[47:40]);
    MatrixMultiply M3_2(S3_2, S0_2, S1_2, S2_2, data_out[39:32]);

    MatrixMultiply M0_3(S0_3, S1_3, S2_3, S3_3, data_out[31:24]);
    MatrixMultiply M1_3(S1_3, S2_3, S3_3, S0_3, data_out[23:16]);
    MatrixMultiply M2_3(S2_3, S3_3, S0_3, S1_3, data_out[15:8]);
    MatrixMultiply M3_3(S3_3, S0_3, S1_3, S2_3, data_out[7:0]);

endmodule