`timescale 1ns/1ns
module b1reg (input inp, clr, ld, clk, rst, output reg outp);
  always@(posedge clk, posedge rst)begin
    if(rst)
      outp <= 1'b0;
    else
      if(clr)
        outp <= 1'b0;
      else
        if(ld)
          outp <= inp;
  end
endmodule


