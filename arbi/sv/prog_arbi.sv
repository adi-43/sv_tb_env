// `timescale 1ns/1ps

// import sim_file_pkg::*;

// program prog_arbi (interface_arbi arbi_signals);

// 	arbi_env env;
// 	score_arbi score;

// 	initial begin
// 		env = new(arbi_signals);
// 		score = new(arbi_signals,drv12sb,drv22sb,end_of_sb);
// 		env.reset();

// 		#10;
// 		env.build();	
// 		env.run();
// 		score.run();
// 		score.report();
// 		// env.display();
// 	end

// 	initial begin
// 		#500 $stop;
// 	end


// endprogram : prog_arbi

`timescale 1ns/1ps


program prog_arbi (interface_arbi.cb_drv arbi_signals);

import sim_file_pkg::*;
    arbi_env env;

    initial begin 
    	env=new(arbi_signals);
        env.build();
        env.reset();
        #10;
        env.run();
        // env.report();
        #1000 $stop;
    end

endprogram : prog_arbi
