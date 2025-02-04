
class arbi_env;

	virtual interface_arbi vif;
	agent_arbi agent;
  score_arbi score;
  arbi_monitor mon;
	mailbox gen2drv1;
	mailbox gen2drv2;
	mailbox drv12sb;
	mailbox drv22sb;
  mailbox mon2sb;
  semaphore end_of_sb;

  // Constructor
  function new(virtual interface_arbi vif);
    this.vif       = vif;
    this.gen2drv1  = new();
    this.gen2drv2  = new();
    this.drv12sb   = new();
    this.drv22sb   = new();
    this.mon2sb    = new();
    this.end_of_sb = new(1);
  endfunction : new

  task run();
    fork
  	agent.gen.run();
  	agent.driver2.run();
  	agent.driver1.run();
    mon.run();
    score.run();
    agent.gen.display();
    mon.display();
    score.dispaly();
    // score.report();
    join
  endtask : run

  // build

  task build();
  	this.agent = new(vif,gen2drv1,gen2drv2,drv12sb,drv22sb,end_of_sb);
    this.mon   = new(vif,mon2sb);
    this.score = new(mon2sb,drv12sb,drv22sb,end_of_sb);
  endtask : build

  // reset

  task reset();
  	@(vif.cb_drv)
  	vif.cb_drv.req_0 	  <= 0;
  	vif.cb_drv.req_1 	  <= 0;
  	vif.cb_drv.data_in0 <= 0;	
  	vif.cb_drv.data_in1 <= 0;
  endtask : reset

  // function void report();
  //   this.score.report();
  // endfunction : report


endclass
