
`timescale 1ns / 1ps
module PE #(
parameter IMAGE_PIXEL_WIDTH = 1,
parameter KERNEL_PIXEL_WIDTH = 1
)
(
        input clock, 
        input en, 
        input [IMAGE_PIXEL_WIDTH-1:0] in1,
        input [KERNEL_PIXEL_WIDTH-1:0] in2,
		input [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] part_sum,
		input rst_n,
        output [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH-1:0] data_out 
);

reg [IMAGE_PIXEL_WIDTH+KERNEL_PIXEL_WIDTH:0] temp_data;

always @(posedge clock or negedge rst_n) begin
    // Save data to RAM
    if (!rst_n) begin
        temp_data <= 'd0;
    end
	else if (en)
		temp_data <= in1*in2 + part_sum;
 end

 assign data_out = temp_data;
         
endmodule

/* temorary
//MAC UNIT:
module MAC_UNIT(clk,rst, a,b, z);
input clk,rst;
input [2:0] a,b;
output [5:0] z;
wire [5:0] w;
multiplier U1(.a(a),.b(b),.p(w));
pipo U2(.RIN(w), .clk(clk),.rst(rst),.ROUT(z));
endmodule

//MULTIPLIER:
module multiplier(a,b, p);
input [2:0] a,b;
output [5:0] p;
wire [7:0]u;
wire [1:0]su;
wire [8:0]i;
and (p[0],a[0],b[0]);
and (u[0],a[1],b[0]);
and (u[1],a[2],b[0]);
and (u[2],a[0],b[1]);
and (u[3],a[1],b[1]);
and (u[4],a[2],b[1]);
and (u[5],a[0],b[2]);
and (u[6],a[1],b[2]);
and (u[7],a[2],b[2]);
hadd h1(.l(u[0]),.m(u[2]),.sum(p[1]),.cry(i[0]));
hadd h2(.l(i[0]),.m(u[1]),.sum(su[0]),.cry(i[1]));
hadd h3(.l(u[3]),.m(u[5]),.sum(su[1]),.cry(i[2]));

hadd h4(.l(su[0]),.m(su[1]),.sum(p[2]),.cry(i[4]));
hadd h5(.l(i[1]),.m(i[2]),.sum(i[5]),.cry(i[6]));
or (i[7],i[5],i[4]);
fadd f3(.d(i[7]),.e(u[4]),.cin(u[6]),.s(p[3]),.cout(i[8]));
fadd f4(.d(i[8]),.e(i[6]),.cin(u[7]),.s(p[4]),.cout(p[5]));
endmodule

//PARALLEL IN PARALLEL OUT:
module pipo(RIN, clk,rst, ROUT);

input [5:0] RIN;
input clk,rst;
output [5:0] ROUT;
reg [5:0] ROUT;

always @(posedge clk or negedge rst)
 begin
	if(!rst)
	  ROUT <= 6'b000000;
	else
	  ROUT <= RIN;
 end

endmodule

//FULL ADDER:
module fadd(s,cout,d,e,cin);

input d,e,cin;
output s,cout;

assign s = (d ^ e ^ cin);
assign cout = ((d&e) | (e&cin) | (d&cin));

endmodule

//HALF ADDER:
module hadd(sum,cry,l,m);
input l,m;
output sum,cry;

wire sum,cry;

assign sum = (l^m);
assign cry = (l&m);

endmodule
*/
