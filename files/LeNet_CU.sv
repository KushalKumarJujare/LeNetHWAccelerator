
`timescale 1ns / 1ps
module CU #( 
parameter OUTPUT_IMAGE_DEPTH = 1
)
(
	input clk,
	input rst_n,
	input wen,
	output reg fifo_in	
);

parameter LOG_OUTPUT_IMAGE_DEPTH = $clog2(OUTPUT_IMAGE_DEPTH)+1;

reg [LOG_OUTPUT_IMAGE_DEPTH-1:0] counter;

always @ (posedge clk or negedge rst_n) begin
  if (!rst_n)
    counter <= 'd0;
  else if (wen)
    begin
      if (counter < OUTPUT_IMAGE_DEPTH)
	    counter <= counter + 'd1;
	  else
	    counter <= 'd0;
	end
 end

always @ (posedge clk or negedge rst_n) begin
  if (!rst_n)
	fifo_in <= 1'b0;
  else
    begin
      if (counter == OUTPUT_IMAGE_DEPTH)
	    fifo_in <= 1'b1;
	  else
	    fifo_in <= 1'b0;
    end
end

endmodule
