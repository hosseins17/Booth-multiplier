`timescale 1ns/1ns
module controller(input clk, rst, start, input [1:0] decision_bits,output logic ldX, ldY, lde, ldA, shA, shX, clrA, clrX, clre, add, sub,finished, output logic [1:0] upload_selector);
    parameter Idle = 4'b0000,
    init = 4'b0001,
    loadX = 4'b0010, 
    loadY = 4'b0011, 
    decision = 4'b0100,
    add_sub = 4'b0101, 
    loadALU = 4'b0111, 
    shift = 4'b1000, 
    counter = 4'b1001,
    loop = 4'b1010,
    uploadX = 4'b1011, 
    uploadA = 4'b1100, 
    done =  4'b1101;
  
    reg [3:0] pre, next;
    reg cnt, initZcnt, cnt_done;

    always@(posedge clk,posedge rst ,posedge start) begin
        next = Idle;
        {ldX, ldY, lde, ldA, cnt, shA, shX, clrA, clrX, clre,add, sub, finished, initZcnt} = 14'b0;
        upload_selector = 2'b00;
        case(pre)
            Idle : begin 
            next = start ? init : Idle;
        end
        init : begin
            clrX = 1;
            clrA = 1;
            clre = 1;
            initZcnt = 1;
            next = start ? init : loadX;
        end
        loadX : begin
          ldX = 1;
          next = loadY;
        end
        loadY : begin
          ldY = 1;
          next = decision;
        end
        decision : begin
            next =  (decision_bits[1] ^ decision_bits[0]) ? add_sub : shift;
        end
        add_sub : begin
            add = decision_bits[0] & ~decision_bits[1];
            sub = ~decision_bits[0] & decision_bits[1];
            next = loadALU;
        end
        loadALU : begin 
          ldA = 1;
          next = shift;
        end
        shift : begin
            shA = 1;
            shX = 1;
            lde = 1;
            next = counter;
        end
        counter : begin
            cnt = 1;
            next = loop;
        end
        loop : begin
            next = cnt_done ? uploadX : decision;
        end
        uploadX : begin 
            upload_selector = 2'b01;
            next = uploadA;
        end
        uploadA : begin 
            upload_selector = 2'b10;
            next = done;
        end
        done : begin 
            finished = 1;
            next = Idle;
        end
        default : next = Idle;
        endcase
    end
    always@(posedge clk, posedge rst) begin
      if(rst) pre = Idle ;
      else pre = next ;
    end
    counter cnt11(clk,rst,initZcnt,cnt,cnt_done);
endmodule

