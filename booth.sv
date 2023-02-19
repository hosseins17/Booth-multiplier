`timescale 1ns/1ns
module bothmult(input [4:0] inbus, input start, clk, rst, output [4:0] outbus, output done);
  wire [1:0] decision_bits ;
  wire ldX, ldY, lde, ldA, shA, shX, clrA, clrX, clre, add, sub;
  wire [1:0] upload_selector;
  logic finished;
  controller cnrl(clk, rst, start, decision_bits,ldX, ldY, lde, ldA, shA, shX, clrA, clrX, clre, add, sub ,finished, upload_selector);
  dataPath DATAPATH(inbus, ldX, shX, clrX , ldY, ldA, shA, clrA, lde, clre, add, sub, clk, rst, upload_selector, outbus, decision_bits);
  assign done = finished;
endmodule


