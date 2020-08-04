`timescale 1ns / 1ps

module tb_LeNet_TOP;
 // Inputs
 reg clk;
 reg wen; // start conv1
 reg re; // load img and all weights ROM values into regs.
 reg rst_n;
 reg [20:0]clk_counter;
 
  LeNet_TOP LeNet_TOP_inst(
  .clk(clk), 
  .re(re),
  .wen(wen),
  .rst_n(rst_n)
 );
 
 initial begin
 clk = 0;
 forever #5 clk = ~clk;
 end 

 initial 
 begin
  #2;
  rst_n = 0;
  #10;
  rst_n = 1;
  wen = 0;
  re = 0;
  #10;
  // conv1 start
  wen = 1;
  re = 1;
  #260126;
  $finish;
 end


always @ (posedge clk or negedge rst_n)
 begin
  if(!rst_n)
   clk_counter <= 'd0;
  else
   clk_counter <= clk_counter + 'd1;
 end

endmodule
