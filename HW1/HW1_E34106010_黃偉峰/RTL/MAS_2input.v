// 
// Designer: E34106010
//
module MAS_2input(
    input signed [4:0]Din1,
    input signed [4:0]Din2,
    input [1:0]Sel,
    input signed[4:0]Q,
    output reg [1:0]Tcmp,
    output reg signed [4:0]TDout,
    output reg signed [3:0]Dout
);                                                                                                  

always @(*) begin //first ALU
    case(Sel)
        2'b00: TDout = Din1 + Din2;
        2'b11: TDout = Din1 - Din2;
        default: TDout = Din1;
    endcase
end

always @(*) begin //comparator
    if(TDout >= Q) Tcmp[1] = 1;
    else Tcmp[1] = 0;
    if(TDout >= 0) Tcmp[0] = 1;
    else Tcmp[0] = 0;
end

always @(*) begin //second ALU
    case(Tcmp)
        2'b00: Dout = Q + TDout;
        2'b11: Dout = TDout - Q;
        default: Dout = TDout;
    endcase
end



endmodule