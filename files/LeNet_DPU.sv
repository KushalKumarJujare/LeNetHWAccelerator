`timescale 1ns / 1ps

module DPU #(
parameter IMAGE_PIXEL_WIDTH = 1,
parameter KERNEL_DEPTH = 1,
parameter KERNEL_PIXEL_WIDTH = 1
)
(
        input clock, 
        input we,
		input done,
        input [IMAGE_PIXEL_WIDTH-1:0] in1 [KERNEL_DEPTH-1:0],
        input [KERNEL_PIXEL_WIDTH-1:0] in2 [KERNEL_DEPTH-1:0],
		input [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] part_sum,
		input rst_n,
        output [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] data_out 
);

reg [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] sum_p [KERNEL_DEPTH-2:0];

wire en;

assign en = we & !done;

PE #(
	.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
	.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH)
) 
PE_0(.clock(clock),.en(en),.in1(in1[0]),.in2(in2[0]), .rst_n(rst_n),.part_sum(part_sum),.data_out(sum_p[0]));

genvar pe;
generate 
  for (pe=1; pe<KERNEL_DEPTH-1; pe=pe+1) 
   begin 
    PE #(
		.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
		.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH)
    ) 
	PE(.clock(clock),.en(en),.in1(in1[pe]),.in2(in2[pe]), .rst_n(rst_n),.part_sum(sum_p[pe-1]),.data_out(sum_p[pe]));
   end
endgenerate 

PE #(
	.IMAGE_PIXEL_WIDTH(IMAGE_PIXEL_WIDTH),
	.KERNEL_PIXEL_WIDTH(KERNEL_PIXEL_WIDTH)
)  
PE_N(.clock(clock),.en(en),.in1(in1[8]),.in2(in2[8]), .rst_n(rst_n),.part_sum(sum_p[7]),.data_out(data_out));

endmodule
