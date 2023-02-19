`timescale 1ns/1ns
module dataPath(input [4:0] inbus, input ldX, shX, clrX, ldY, ldA, shA, clrA, lde, clre, add, sub, clk, rst, input [1:0] upload_selector, output [4:0] outP, output[1:0] decision_bits);
  wire [4:0] xOutP, yOutP, aOutP, AluOutP;
  wire eOutP, AluCo;
  b5reg Yreg(inbus, ldY , clk, rst, yOutP);
  b5shiftreg Ashift(AluOutP , shA, clrA, ldA, clk, rst, aOutP);
  b5shiftregci Xreg(inbus, aOutP[0], clrX ,shX, ldX, clk, rst, xOutP);
  b1reg Ereg(xOutP[0], clre, lde, clk, rst, eOutP );
  addSub ALU(aOutP, yOutP, add, sub, AluOutP, AluCo);
  assign outP = (upload_selector == 2'b01) ?  xOutP : (upload_selector == 2'b10) ? aOutP : outP;
  assign decision_bits = {xOutP[0],eOutP}; 
endmodule
              

