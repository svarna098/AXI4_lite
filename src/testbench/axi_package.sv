package axi_package;
	 `include "uvm_macros.svh"
  import uvm_pkg ::*;
        
	`include "axi_sequence_item.sv"
	`include "axi_config.sv"
        `include "axi_sequence.sv"
	`include "axi_driver.sv"
	`include "axi_in_mon.sv"
	`include "axi_sequencer.sv"
	`include "axi_in_agent.sv"
	`include "axi_out_mon.sv"
	`include "axi_out_agent.sv"
	`include "axi_scoreboard.sv"
        `include "axi_subscriber.sv"
	`include "axi_environment.sv"

	`include "axi_test.sv"

endpackage
