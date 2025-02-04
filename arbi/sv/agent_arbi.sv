// `ifndef DRV_ARBI
// 	`include "drv1_arbi.sv"
// 	`include "drv2_arbi.sv"
// 	`include "gen_arbi.sv"
// 	`define DRV_ARBI
// `endif

class agent_arbi;
	virtual interface_arbi vif;

	drv1_arbi driver1;
	drv2_arbi driver2;
	gen_arbi  gen;
	mailbox gen2drv1;
	mailbox gen2drv2;
	mailbox drv12sb;
	mailbox drv22sb;
	semaphore end_of_sb;

	function new(virtual interface_arbi vif,mailbox gen2drv1,mailbox gen2drv2,mailbox drv12sb,mailbox drv22sb,semaphore end_of_sb);
		this.vif  = vif;
		gen2drv1  = new();
		gen2drv2  = new();
		drv12sb   = new();
		drv22sb   = new();
		end_of_sb = new(1);
		driver1   = new(vif,gen2drv1,drv12sb);
		driver2   = new(vif,gen2drv2,drv22sb);
		gen       = new(gen2drv1,gen2drv2,end_of_sb);
	endfunction : new

	task run();
		fork
		gen.display();
		gen.run();
		driver2.run();
		driver1.run();
		driver1.display();
		driver2.display();
		join
	endtask : run
  
	function void display();
	    $display("Calling from AGENT class");
	endfunction : display

endclass : agent_arbi