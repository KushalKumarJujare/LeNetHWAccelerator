
`timescale 1ns / 1ps
module FIFO #(
parameter IMAGE_PIXEL_WIDTH = 1,
parameter KERNEL_PIXEL_WIDTH = 1,
parameter FIFO_DEPTH = 1
)
(
        input clock, 
        input fifo_in, // oen 
		input rst_n,
		input done,
        input [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] data_out,
		output fifo_full
);

parameter LOG_FIFO_DEPTH = $clog2(FIFO_DEPTH);

reg [LOG_FIFO_DEPTH-1:0] wptr;
reg [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] FIFO [FIFO_DEPTH-1:0];
wire full;

 always @(posedge clock or negedge rst_n) begin
    
	if (!rst_n) 
        wptr <= 'd0;
	else if ((wptr == FIFO_DEPTH) | (done))
	  wptr <= 'd0;
	else if (fifo_in & !full)
		  wptr <= wptr + 'd1;
 end

 always @(posedge clock or negedge rst_n) begin
	if (fifo_in & !full & !done)
		FIFO[wptr] = data_out;
 end

 reg wptr_dly;

always @(posedge clock or negedge rst_n) begin
    
	if (!rst_n) 
        wptr_dly <= 'd0;
	else if (wptr == FIFO_DEPTH)
		wptr_dly <= wptr;
	else
		wptr_dly <= 'd0;
 end

 assign full = (wptr == FIFO_DEPTH) & ~ wptr_dly;

 integer full_count = 'd0;

 always @ (posedge full)
 	begin
	  full_count = full_count + 'd1;
	end

 assign fifo_full = full;

integer f,i,j;

initial begin
  f = $fopen("write_files/aug3/conv_lap55_s3_op.mem","w");

 for (j = 0; j<FIFO_DEPTH; j++) // (O*O / fifo_size(9)) times fifo gets full
  begin
   @(posedge full or posedge done);  
   #20;
   $display("kush....%t, j=%d", $time, j);
  for (i = 0; i<FIFO_DEPTH; i=i+1)
    begin
     $fwrite(f,"%d\n",FIFO[i]);
	 $display("writing file ... %t, fifo : %d", $time, FIFO[i]);
    end
  end
 
 $fclose(f);  

end

endmodule
