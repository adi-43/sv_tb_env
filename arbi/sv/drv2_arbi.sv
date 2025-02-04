
// `ifndef ARB_TRANS
// 	`include "trans_arbi.sv"
// 	`define ARB_TRANS

class drv2_arbi;
	mailbox gen2drv2;
	mailbox drv22sb;
	virtual interface_arbi vif2;

	function new(virtual interface_arbi vif2,mailbox gen2drv2,mailbox drv22sb);
		this.vif2 = vif2;
		this.gen2drv2 = gen2drv2;
		this.drv22sb = drv22sb;			
	endfunction : new

	task run();
		trans_arbi trans2;
		$display("running from driver 2");

		forever begin
			gen2drv2.get(trans2);
			this.drive2(trans2);
			drv22sb.put(trans2);
		end
	endtask : run

	task drive2(input trans_arbi trans2);
		@(vif2.cb_drv) begin
			this.vif2.cb_drv.req_1    <= trans2.req_1;
			this.vif2.cb_drv.data_in1 <= trans2.data_in1;
		end
	endtask : drive2

	function void display();
		$display("calling from driver class2");
	endfunction : display
endclass : drv2_arbi

// `endif