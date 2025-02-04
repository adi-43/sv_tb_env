class arbi_monitor;
	virtual interface_arbi vif;
	mailbox mon2sb;


	function new(virtual interface_arbi vif,mailbox mon2sb);
		this.mon2sb = mon2sb;
		this.vif = vif;
	endfunction : new

	task run();
		fork
			
		mem_trans mem_pkt;

		forever begin
			mem_pkt = new();
			@(vif.cb_drv)
			mem_pkt.req_0    = vif.req_0;
			mem_pkt.req_1    = vif.req_1;
			mem_pkt.data_in0 = vif.data_in0;
			mem_pkt.data_in1 = vif.data_in1;
			mem_pkt.grant_0  = vif.cb_drv.grant_0;
			mem_pkt.grant_1  = vif.cb_drv.grant_1;
			mem_pkt.arb_out  = vif.cb_drv.arb_out;
			mon2sb.put(mem_pkt);
			mem_pkt.display();
		end
		join
	endtask : run

	function void display();
		$display("Running from monitor");
	endfunction : display


endclass : arbi_monitor