`timescale 1ns/1ns
module addSub(input [4:0] a, b, input add, sub, output reg [4:0] sum, output reg co);
assign {co,sum} = (add) ? a+b : (sub) ? a-b : {co,sum} ;
endmodule
