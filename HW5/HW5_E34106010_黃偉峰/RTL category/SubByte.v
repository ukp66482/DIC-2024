module SubByte(data_in, data_out);
    input [127:0] data_in;
    output [127:0] data_out;
    
    S_BOX u_S_BOX0_0(data_in[127:120], data_out[127:120]);
    S_BOX u_S_BOX0_1(data_in[119:112], data_out[119:112]);
    S_BOX u_S_BOX0_2(data_in[111:104], data_out[111:104]);
    S_BOX u_S_BOX0_3(data_in[103:96], data_out[103:96]);

    S_BOX u_S_BOX1_0(data_in[95:88], data_out[95:88]);
    S_BOX u_S_BOX1_1(data_in[87:80], data_out[87:80]);
    S_BOX u_S_BOX1_2(data_in[79:72], data_out[79:72]);
    S_BOX u_S_BOX1_3(data_in[71:64], data_out[71:64]);
    
    S_BOX u_S_BOX2_0(data_in[63:56], data_out[63:56]);
    S_BOX u_S_BOX2_1(data_in[55:48], data_out[55:48]);
    S_BOX u_S_BOX2_2(data_in[47:40], data_out[47:40]);
    S_BOX u_S_BOX2_3(data_in[39:32], data_out[39:32]);
    
    S_BOX u_S_BOX3_0(data_in[31:24], data_out[31:24]);
    S_BOX u_S_BOX3_1(data_in[23:16], data_out[23:16]);
    S_BOX u_S_BOX3_2(data_in[15:8], data_out[15:8]);
    S_BOX u_S_BOX3_3(data_in[7:0], data_out[7:0]);

endmodule