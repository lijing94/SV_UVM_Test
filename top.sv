import uvm_pkg::*;
`include "generator.sv"
`include "interface.sv"
`include "monitor.sv"

module test_tb_top;	
	reg clk;
  wire vld;
	wire [31:0] data;
	sample_if vif();
    
  logic vld_stg1,vld_stg2,vld_stg3,vld_stg4;
  logic [31:0] sample_data;
  debug_if dbg_if();
    
    assign vld_stg1 = dbg_if.vld_stg1;
    assign vld_stg2 = dbg_if.vld_stg2;
    assign vld_stg3 = dbg_if.vld_stg3;
    assign vld_stg4 = dbg_if.vld_stg4;
    assign sample_data = dbg_if.sample_data;
	  assign vif.clk = clk;
	  //assign vif.vld = vld;
	  //assign vif.data = data;
    
	gen_top m_gen_top (
		.clk(clk),
		.vld(vif.vld),
		.data(vif.data)
        );
    
	initial begin
    monitor mon;
    mon = new("mon",null);
  	uvm_config_db#(virtual sample_if)::set(null,"uvm_test_top","vif",vif);
		uvm_config_db#(virtual debug_if)::set(null,"uvm_test_top","dbg_if",dbg_if);
    mon.vif = vif;
    mon.dbg_if = dbg_if;
    mon.main_phase(null);
	end 
	
	initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars("+all");
	end
	//clk 
    initial begin
        clk = 1;
        //vld=0;
        //data = 32'h0;
        forever #1ns clk = ~clk;
    end
  initial begin
      #100000ns;
      $finish;
  end
		
endmodule


