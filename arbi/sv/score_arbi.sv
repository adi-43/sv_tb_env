class score_arbi;
	mailbox mon2sb, drv12sb, drv22sb;
	semaphore end_of_sb;
	int packets_proc, correct_match, incorrect_match;
	int no_of_packets;

	function new(mailbox mon2sb,mailbox drv12sb,mailbox drv22sb, semaphore end_of_sb);
		// this.mon2sb          = new();
		// this.drv12sb         = new();
		// this.drv22sb         = new();
		// this.end_of_sb       = new(1);
		this.end_of_sb 		 = end_of_sb;
		this.mon2sb    		 = mon2sb;
		this.drv12sb   		 = drv12sb;
		this.drv22sb   		 = drv22sb;
			 packets_proc    = 0;
			 correct_match   = 0;
			 incorrect_match = 0;
			 no_of_packets   = 20;
	endfunction : new

	function bit compare(trans_arbi drv1_trans, trans_arbi drv2_trans, mem_trans mon_trans);
		if (mon_trans.grant_0) begin
			if (mon_trans.arb_out != drv1_trans.arb_out) begin
				return 0;
			end
			if (mon_trans.grant_0 != drv1_trans.grant_0) begin
				return 0;
			end
			return 1;		
		end
		if (mon_trans.grant_1) begin
			if (mon_trans.arb_out != drv2_trans.arb_out) begin
				return 0;
			end
			if (mon_trans.grant_1 != drv2_trans.grant_1) begin
				return 0;
			end
			return 1;		
		end
	endfunction : compare

	task run();
		trans_arbi drv1_trans;
		trans_arbi drv2_trans;
		mem_trans  mon_trans;
		forever begin
			end_of_sb.get(1);
			drv12sb.get(drv1_trans);
			drv22sb.get(drv2_trans);
			mon2sb.get(mon_trans);
			packets_proc++;
			if (this.compare(drv1_trans, drv2_trans, mon_trans)) begin
				correct_match++;
				$display("[%t]Packets Correctly Matched", $time);
				drv1_trans.display();
				drv2_trans.display();
			end else begin
				incorrect_match++;
				$display("[%t]Packets Incorrectly Matched", $time);
				drv1_trans.display();
				drv2_trans.display();
				mon_trans.display();
			end
			if (packets_proc == no_of_packets) begin
				#0 end_of_sb.put(1);
			end
		end
		// this.report();
		// $finish;
	endtask : run

	function void dispaly();
		$display("Runing from score");
	endfunction : dispaly

	function void report();
		$display("Total Packets Processed: %0d", packets_proc);
		$display("Total Correct Matches: %0d",   correct_match);
		$display("Total Incorrect Matches: %0d", incorrect_match);
	endfunction : report


endclass : score_arbi