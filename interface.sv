interface sample_if;
	logic clk;
	logic vld;
	logic [31:0] data;
endinterface

interface debug_if;
	logic start_sample;
	logic vld_stg1,vld_stg2,vld_stg3,vld_stg4;
	logic [31:0] sample_data;
endinterface