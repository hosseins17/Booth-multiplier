`timescale 1ns/1ns
module counter(input clk,rst,InitZcnt,cnt,output cnt_done);
    logic [2:0] flag;
    logic finish;
    always@(posedge clk,posedge rst) begin
        if(rst) flag <= 3'b0;
        else begin
             if (InitZcnt) flag <= 3'b0;
             else if(cnt) flag <= flag + 1;
             else flag <= flag;
        end
    end
    always@(posedge clk,posedge rst) begin
      if (flag == 3'b100 )  finish = 1'b1 ;
      else finish = 1'b0;
              
    end
    assign cnt_done = finish;
endmodule
