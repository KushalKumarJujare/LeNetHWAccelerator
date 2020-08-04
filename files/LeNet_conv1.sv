`timescale 1ns / 1ps

module LeNet_CONV1 #(
	parameter IMAGE_PIXEL_WIDTH = 1,
	parameter IMAGE_WIDTH = 1,
	parameter KERNEL_SIZE = 1,
	parameter KERNEL_PIXEL_WIDTH = 1,
	parameter STRIDE = 1,
	parameter PADDING = 1
)
(
	input clk,
	input re,
	input wen,
	input rst_n,
	output done
);


parameter IIM_DEPTH = IMAGE_WIDTH*IMAGE_WIDTH;
parameter WC1_DEPTH = KERNEL_SIZE*KERNEL_SIZE;
parameter OUTPUT_IMAGE_DEPTH = ((IMAGE_WIDTH-KERNEL_SIZE+2*PADDING)/STRIDE)+1;

wire [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] data_out;
wire [IMAGE_PIXEL_WIDTH-1:0] IMD [WC1_DEPTH-1:0];
wire [KERNEL_PIXEL_WIDTH-1:0] WC1D [WC1_DEPTH-1:0];
wire fifo_in;
wire start;

ROM #( 
.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
.IIM_DEPTH(IIM_DEPTH),
.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH),
.KERNEL_DEPTH(WC1_DEPTH),
.IMAGE_WIDTH(IMAGE_WIDTH),
.STRIDE(STRIDE),
.KERNEL_SIZE(KERNEL_SIZE)
)
ROM1 (
  .clock(clk),
  .rst_n(rst_n),
  .re(re),
  .load(fifo_in),
  .IMD(IMD),
  .WC1D(WC1D),
  .start(start),
  .done(done)
 );

DPU #(
.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
.KERNEL_DEPTH(WC1_DEPTH),
.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH)
) 
DPU1 ( 
  .clock(clk), 
  .we(wen),
  .done(done),
  .part_sum('d0),
  .rst_n(rst_n),
  .in1(IMD),
  .in2(WC1D),
  .data_out(data_out)
 );

CU #(.OUTPUT_IMAGE_DEPTH(OUTPUT_IMAGE_DEPTH))
CU1 (
.clk(clk),
.rst_n(rst_n),
.wen(wen),
.fifo_in(fifo_in)
);

FIFO #(
.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH),
.FIFO_DEPTH(OUTPUT_IMAGE_DEPTH)
)
 FIFO1 (
  .clock(clk), 
  .fifo_in(fifo_in),
  .rst_n(rst_n),
  .done(done),
  .data_out(data_out),
  .fifo_full(fifo_full)
 ); 

endmodule

