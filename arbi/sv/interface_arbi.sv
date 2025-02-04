`timescale 1ns/1ps
interface interface_arbi(input logic clk, logic reset);
    // Parameters
    parameter DATA_WIDTH = 32;

    // Signals
	logic         		    req_0;
	logic  [DATA_WIDTH-1:0] data_in0;
	logic          		    req_1;
	logic  [DATA_WIDTH-1:0] data_in1;
	logic          		    grant_0;
	logic        		    grant_1;
	logic [DATA_WIDTH-1:0] arb_out;	

    clocking cb_drv@(posedge clk);
        default input #1ns output #1ns;
        output req_0;
        output req_1;
        output data_in0;
        output data_in1;
        input  grant_0;
        input  grant_1;
        input  arb_out;
    endclocking

    // Modports
    modport Master_0 (
        input grant_0, arb_out,
        output req_0, data_in0
    );

    modport Master_1 (
        input grant_1, arb_out,
        output req_1, data_in1   
    );

    modport Slave (
        input req_0,req_1,data_in0,data_in1,
        output grant_0,grant_1,arb_out
    );

endinterface