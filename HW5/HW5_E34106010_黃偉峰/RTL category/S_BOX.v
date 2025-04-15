module S_BOX(data_in, data_out);
    input [7:0] data_in;
    output [7:0] data_out;

    wire [7:0] multiplicative_exponential_offset;
    wire [9:0] multiplicative_inverse;

    //TMenc
    TMenc u_TMenc(data_in, multiplicative_exponential_offset);

    //Inverse
    Inverse u_Inverse(multiplicative_exponential_offset, multiplicative_inverse);

    //BMenc
    BMenc u_BMenc(multiplicative_inverse, data_out);

endmodule