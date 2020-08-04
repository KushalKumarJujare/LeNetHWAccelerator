`timescale 1ns / 1ps

module LeNet_TOP #(
	parameter IMAGE_PIXEL_WIDTH = 8,
	parameter KERNEL_PIXEL_WIDTH = 5,
	// CONV1
	parameter WC1_IMAGE_WIDTH = 32,
	parameter WC1_KERNEL = 5,
	parameter WC1_STRIDE = 3,
	parameter WC1_PADDING = 0
)
(
	input clk,
	input re,
	input wen,
	input rst_n
);

wire done_conv1;

LeNet_CONV1 #(
.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH),
.IMAGE_WIDTH(WC1_IMAGE_WIDTH),
.KERNEL_SIZE(WC1_KERNEL),
.STRIDE(WC1_STRIDE),
.PADDING(WC1_PADDING)
)
CONV1(.clk(clk), .rst_n(rst_n), .re(re), .wen(wen), .done(done_conv1));
//LeNet_MAX1 max1
//LeNet_CONV2 conv2
//LeNet_MAX2 max2
//LeNet_CONV3 conv3
//LeNet_FC1 fc1()
//LeNet_FC2 out()

endmodule
