`timescale 1ns/1ns
module b5shiftreg(input [4:0] inp, input shift, clr, ld, clk, rst, output reg [4:0] outp);
  always@(posedge clk, posedge rst) begin
    if(rst)
      outp <= 5'b00000;
    else
      if(clr)
        outp <= 5'b00000;
      else
        if(ld)
          outp <= inp;
        else
          if(shift)
            outp <= {outp[4], outp[4:1]};
  end
endmodule
