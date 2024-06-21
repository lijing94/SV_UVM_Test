class monitor extends uvm_monitor;
	virtual sample_if vif;
	virtual debug_if dbg_if;
	`uvm_component_utils(monitor);
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		 if (!uvm_config_db#(virtual sample_if)::get(this,"","vif", vif)) begin
            `uvm_fatal("AGT/NOVIF", "No virtual interface specified for this agent instance ")
		 end
		 if (!uvm_config_db#(virtual debug_if)::get(this,"","dbg_if", dbg_if)) begin
            `uvm_fatal("AGT/NOVIF", "No virtual interface specified for this agent instance ")
		 end
		 
	endfunction
	
task main_phase(uvm_phase phase);		
		`uvm_info("MON", "Sample start!", UVM_LOW);
	fork
		while(1) begin
				@(posedge vif.clk);
			  dbg_if.vld_stg4 = dbg_if.vld_stg3;
		    dbg_if.vld_stg3 = dbg_if.vld_stg2;
			  dbg_if.vld_stg2 = dbg_if.vld_stg1;
				dbg_if.vld_stg1 = vif.vld;
		end 
		forever begin
			@(posedge vif.clk);
			if(dbg_if.vld_stg4) begin
					#0.2ns;
					`uvm_info("MON", $sformatf("Sample sucess! data %8h",vif.data), UVM_LOW);
					dbg_if.sample_data = vif.data;
			end 
		end
		join
endtask
endclass