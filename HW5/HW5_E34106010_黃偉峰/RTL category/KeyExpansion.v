module KeyExpansion(key, Rconstant, new_key);
    input [127:0] key;
    input [31:0] Rconstant;
    output [127:0] new_key;

    wire [7:0] rotated_w_0, rotated_w_1, rotated_w_2, rotated_w_3;
    wire [7:0] after_sub_0, after_sub_1, after_sub_2, after_sub_3;
    
    //RotWord
    assign rotated_w_0 = key[23:16];
    assign rotated_w_1 = key[15:8];
    assign rotated_w_2 = key[7:0];
    assign rotated_w_3 = key[31:24];

    //SubWord
    S_BOX u_S_BOX0(rotated_w_0, after_sub_0);
    S_BOX u_S_BOX1(rotated_w_1, after_sub_1);
    S_BOX u_S_BOX2(rotated_w_2, after_sub_2);
    S_BOX u_S_BOX3(rotated_w_3, after_sub_3);

    //Rcon
    assign new_key[127:96] = {after_sub_0, after_sub_1, after_sub_2, after_sub_3} ^ Rconstant ^ key[127:96];
    assign new_key[95:64] = new_key[127:96] ^ key[95:64];
    assign new_key[63:32] = new_key[95:64] ^ key[63:32];
    assign new_key[31:0] = new_key[63:32] ^ key[31:0];

endmodule