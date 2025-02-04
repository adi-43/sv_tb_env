`timescale 1ns/1ps


module tb_arbi #(parameter DATA_WIDTH = 32);

reg 		  		  clk;   
reg         		  rst_in;
reg         		  req_0;
reg  [DATA_WIDTH-1:0] data_in0;
reg          		  req_1;
reg  [DATA_WIDTH-1:0] data_in1;
wire          		  grant_0;
wire        		  grant_1;
wire [DATA_WIDTH-1:0] arb_out;	

arbi #
(
	.DATA_WIDTH(DATA_WIDTH)
) inst_arbi 
(
	.clk      (clk),
	.rst_in   (rst_in),
	.req_0    (req_0),
	.data_in0 (data_in0),
	.req_1    (req_1),
	.data_in1 (data_in1),
	.grant_0  (grant_0),
	.grant_1  (grant_1),
	.arb_out  (arb_out)
);

initial begin
	clk = 0;
	forever #5 clk =~clk;
end

always #40 req_0    = $random();
always #40 req_1    = $random();
always #10 data_in0 = $random();
always #10 data_in1 = $random();

initial begin
	rst_in   = 0;
	req_0    = 0;
	req_1    = 0;
	data_in0 = 0;
	data_in1 = 0;

	#20 rst_in = 1;

	#200 $finish;
end

endmodule : tb_arbi
