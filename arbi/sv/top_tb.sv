`timescale 1ns/1ps

module top_tb;
reg clk;    // Clock
reg reset;  // Asynchronous reset active low
interface_arbi arbi_signals(clk , reset);

prog_arbi prog_inst(arbi_signals);

arbi inst_arbi (.clk(clk), .reset(reset), .arbi_signals(arbi_signals));

initial begin
	clk =0;
	forever #5 clk = ~clk;
end


	covergroup cov @(posedge clk);
		coverpoint arbi_signals.req_0;
		coverpoint arbi_signals.req_1;
		coverpoint arbi_signals.data_in0 {
			bins valid[] = {[0:10]};
			ignore_bins invalid[] = {[21:1023]}; 
		}
		coverpoint arbi_signals.data_in1 {
			bins valid[] = {[0:10]};
			ignore_bins invalid[] = {[21:1023]}; 
		}
		coverpoint arbi_signals.grant_0;
		coverpoint arbi_signals.grant_1;
		coverpoint arbi_signals.arb_out {
			bins valid[] = {[0:10]};
			ignore_bins invalid[] = {[21:1023]}; 
		}
	endgroup : cov


	cov cov_inst;

initial begin
	reset =0;
	#10 
	reset =1;
	
end

initial begin
	cov_inst = new();
end

initial begin
	#1000 $display("covrage= %0.2f %% ", cov_inst.get_inst_coverage());
		  $display("time = %0t",$time);
	$finish;
end

endmodule : top_tb