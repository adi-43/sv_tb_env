class trans_arbi;

	rand logic        req_0;
	rand logic [31:0] data_in0;
	rand logic        req_1;
	rand logic [31:0] data_in1;	
		 logic        grant_0;
		 logic        grant_1;
		 logic        arb_out;


	constraint c1 {
		data_in0 inside {[0:23]};
		data_in1 inside {[0:23]};
	}

	// constraint c2 {
	// 	data_in0 > 1023;
	// 	data_in1 > 1023;
	// }

    function void display();
    	$display("Arbi _ transcations");
    	$display("req_0    : %0d",this.req_0);
    	$display("data_in0 : %0h",this.data_in0);
    	$display("req_1    : %0d",this.req_1);
    	$display("data_in1 : %0h",this.data_in1);
    	$display("grant_0  : %0h",this.grant_0);
    	$display("grant_1  : %0h",this.grant_1);
    	$display("arb_out  : %0h",this.arb_out);
    endfunction : display


endclass : trans_arbi
