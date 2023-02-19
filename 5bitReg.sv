`timescale 1ns/1ns
module b5reg(input [4:0] inp, input ld , clk, rst, output reg [4:0] outp);
  always@(posedge clk, posedge rst) begin
    if(rst)
      outp <= 5'b00000;
    else
      if(ld)
        outp <= inp;
  end
endmodule


