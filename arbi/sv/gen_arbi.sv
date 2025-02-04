// `ifndef ARBI_TRANS_OFF	
// 	`define ARBI_TRANS_OFF
// 	`include "trans_arbi.sv"
// `endif

class gen_arbi;
	int num;
	mailbox gen2drv1;
	mailbox gen2drv2;
	semaphore end_of_sb;

	function new(mailbox gen2drv1,mailbox gen2drv2,semaphore end_of_sb);
		this.gen2drv1  = gen2drv1;
		this.gen2drv2  = gen2drv2;
		this.end_of_sb = end_of_sb;
		this.num      = 20;
	endfunction : new

	task run();
		repeat(num) begin
			// rand_select(1);
			// constraint_select(1);
			drv1();
			drv0();
			// rand_select(1);
			drv1();
			// constraint_select(0);
			drv01();
			drv0();
			// constraint_select(1);
			drv1();
			drv01();
			drv01();
		end
		#0 end_of_sb.get(1);
	endtask : run

	task drv0();
	 	trans_arbi trans;
	 	trans = new();
	 	// trans.req_0 = 1'b1;
	 	// trans.req_1 = 1'b0;
	 	if (trans.randomize() /*with {trans.data_in0 > 500 && trans.data_in0 < 800;}*/) begin
	 		trans.display();
	 		this.gen2drv1.put(trans);
	 		this.gen2drv2.put(trans);
	 	end else begin
	 		trans.data_in0 = trans.data_in0 +1;
	 		trans.data_in1 = 0;
	 		trans.display();
	 		this.gen2drv1.put(trans);
	 		this.gen2drv2.put(trans); 
	 		$error("Transaction randomization failed at %0t",$time);
	 	end
	endtask : drv0 

	task drv1();
	 	trans_arbi trans;
	 	trans = new();
	 	// trans.req_1 = 1'b1;
	 	// trans.req_0 = 1'b0;
	 	if (trans.randomize() /*with {trans.data_in1 > 500 && trans.data_in1 < 800;}*/) begin
	 		trans.display();
	 		this.gen2drv2.put(trans);
	 		this.gen2drv1.put(trans);
	 	end else begin
	 		trans.data_in1 = trans.data_in1 +1;
	 		trans.data_in0 = 0;
	 		trans.display();
	 		this.gen2drv1.put(trans);
	 		this.gen2drv2.put(trans); 
	 		$error("Transaction randomization failed at %0t",$time);
	 	end
	endtask : drv1 

	task drv01();
	 	trans_arbi trans;
	 	trans = new();
	 	// trans.req_0 = 1'b1;
	 	// trans.req_1 = 1'b1;
	 	if (trans.randomize() /*with {trans.data_in0 > 500 && trans.data_in0 < 800 && trans.data_in1 > 500 && trans.data_in1 < 800;}*/) begin
	 		trans.display();
	 		this.gen2drv1.put(trans);
	 		this.gen2drv2.put(trans);
	 	end else begin 
	 		trans.data_in1 = trans.data_in1 +1;
	 		trans.data_in0 = trans.data_in0 +1;
	 		trans.display();
	 		this.gen2drv1.put(trans);
	 		this.gen2drv2.put(trans);
	 		$error("Transaction randomization failed at %0t",$time);
	 	end
	endtask : drv01 

    function void display();
        $display("Calling from generator class");
    endfunction : display

    // function void constraint_select(input bit select);
	// 	trans_arbi trans;
	// 	trans = new();
	// 	if (select) begin
	// 		trans.c1.constraint_mode(1);
	// 		trans.c2.constraint_mode(0);			
	// 	end else begin
	// 		trans.c1.constraint_mode(0);
	// 		trans.c2.constraint_mode(1);			
	// 	end
	// endfunction

    // function void rand_select(input bit select);
	// 	trans_arbi trans;
	// 	trans = new();
	// 	if (select) begin
	// 		trans.rand_mode(1);			
	// 	end else begin
	// 		trans.rand_mode(0);			
	// 	end
	// endfunction


endclass : gen_arbi
