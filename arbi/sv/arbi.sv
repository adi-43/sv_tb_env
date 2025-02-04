`timescale 1ns/1ps


module arbi  
(
	input wire clk,   
	input wire reset,
	interface_arbi arbi_signals
);

always_ff @(posedge clk or negedge reset) begin 
	if(~reset) begin
		arbi_signals.arb_out <= 0;
		arbi_signals.grant_0 <= 1'b0;
		arbi_signals.grant_1 <= 1'b0;
	end else begin
		if (arbi_signals.req_0) begin
			arbi_signals.grant_0 <= 1'b1;
			arbi_signals.grant_1 <= 1'b0;
			arbi_signals.arb_out <= arbi_signals.data_in0;
		end else if (arbi_signals.req_1) begin
			arbi_signals.grant_1 <= 1'b1;
			arbi_signals.grant_0 <= 1'b0;
			arbi_signals.arb_out <= arbi_signals.data_in1;
		end
	end
end
endmodule : arbi
