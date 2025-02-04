
// `ifndef ARB_TRANS_OFF
// 	`include "trans_arbi.sv"
// 	`define ARB_TRANS_OFF

class drv1_arbi;
	mailbox gen2drv1;
	mailbox drv12sb;
	virtual interface_arbi vif1;

	function new(virtual interface_arbi vif1,mailbox gen2drv1,mailbox drv12sb);
		this.vif1 = vif1;
		this.gen2drv1 = gen2drv1;		
		this.drv12sb = drv12sb;		
	endfunction : new

	task run();
		trans_arbi trans1;
		$display("running from driver 1");

		forever begin
			gen2drv1.get(trans1);
			this.drive1(trans1);
			drv12sb.put(trans1);
		end
	endtask : run

	task drive1(input trans_arbi trans1);
		@(vif1.cb_drv) begin
			this.vif1.cb_drv.req_0    <= trans1.req_0;
			this.vif1.cb_drv.data_in0 <= trans1.data_in0;
		end
	endtask : drive1

	function void display();
		$display("calling from driver class1");
	endfunction : display
endclass : drv1_arbi

// `endif
