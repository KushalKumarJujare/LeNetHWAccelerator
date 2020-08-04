
`timescale 1ns / 1ps
module ROM #(
parameter IMAGE_PIXEL_WIDTH = 1,
parameter IIM_DEPTH = 1,
parameter KERNEL_PIXEL_WIDTH = 1,
parameter KERNEL_DEPTH = 1,
parameter IMAGE_WIDTH = 1, 
parameter STRIDE = 1,
parameter KERNEL_SIZE = 1

 )
(
        input clock, 
		input rst_n,
        input re,
		input load,
        output [IMAGE_PIXEL_WIDTH-1:0] IMD [KERNEL_DEPTH-1:0],
		output [KERNEL_PIXEL_WIDTH-1:0] WC1D [KERNEL_DEPTH-1:0],
		output start,
		output done
);

parameter LAST_SET = IMAGE_WIDTH - KERNEL_SIZE;
parameter LOG_LAST_SET = $clog2(LAST_SET);

reg [LOG_LAST_SET-1:0] row_dec; // (81/3)*27
reg [LOG_LAST_SET-1:0] col_dec;

reg [KERNEL_PIXEL_WIDTH-1 : 0] WC1 [KERNEL_DEPTH-1 : 0];
reg [IMAGE_PIXEL_WIDTH-1 : 0] IIM [IIM_DEPTH-1 : 0];

initial
 begin
	$display("Loading ROMs.");
	$readmemh("write_files/aug3/resized_verilog.mem", IIM);
	//$readmemh("write_files/aug3/conv1_op.mem", IIM);
	//$readmemh("write_files/aug3/laplacian_verilog.mem", WC1);
	$readmemh("write_files/aug3/laplacian_verilog55.mem", WC1);
	//$readmemh("write_files/aug3/sobelX_verilog44.mem", WC1);
	//$readmemh("wc2.mem", WC2);
	//$readmemh("wc3.mem", WC3);
	//$readmemh("wfc1.mem", WFC);
	//$readmemh("wout.mem", WOUT);
	$display("ROMs loaded!!");
 end

 always @ (posedge clock) begin
  if (!rst_n)
      row_dec <= 'd0;
  else if (load)
    begin
      if((row_dec + STRIDE) > LAST_SET)
        row_dec <= 'd0;
	  else
	    row_dec <= row_dec + STRIDE;
    end
 end

always @ (posedge clock) begin
  if (!rst_n)
      col_dec <= 'd0;
  else if (load)
    begin
      if (((col_dec + STRIDE) > LAST_SET) & ((row_dec + STRIDE) > LAST_SET))
        col_dec <= 'd0;
	  else if ((row_dec + STRIDE) > LAST_SET)
	    col_dec <= col_dec + STRIDE;
	  else
	    col_dec <= col_dec;
    end
  end

reg re_dly;
wire startt; 
reg stopp;

always @(posedge clock or negedge rst_n)
if(!rst_n)
 re_dly <= 1'b0;
else
 re_dly <= re;

always @(posedge clock or negedge rst_n)
if(!rst_n)
 stopp <= 1'b0;
else if (((col_dec + STRIDE) > LAST_SET) & ((row_dec + STRIDE) > LAST_SET) & load)
 stopp <= 1'b1;

assign done = stopp;

assign startt = re& ~re_dly;
assign start = startt;

always @(posedge clock) begin
    if (re)
	  begin
	  	for (int i=0; i<KERNEL_SIZE; i++)
		  begin
			for (int j=0; j<KERNEL_SIZE; j++)
			  begin
      			IMD[i*KERNEL_SIZE+j] <= IIM[(col_dec+i)*IMAGE_WIDTH+(row_dec+j)];
			  end
		  end
	  end
  end

always @(posedge clock) begin
    if (startt)
	  begin
	    for (int i=0; i<(KERNEL_SIZE*KERNEL_SIZE); i++)
		  begin
		    WC1D[i] <= WC1[i];
		  end
      end
  end
endmodule
