`timescale 1ns/1ns
module b5shiftregci(input [4:0] inp , input ci, clr ,shift, ld, clk, rst, output reg [4:0] outp);
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
             outp <= {ci, outp[4:1]};
  end
endmodule


