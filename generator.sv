

`timescale 1ns/1ps

module gen_top(
	input clk,
	output vld,
	output [31:0] data
	);
	  reg vld;
		reg [31:0] data;
       
    
    
    //gen vld
    initial begin
            vld = 0;
	    #100ns;
	    vld <= 1;
	    #4ns;
	    vld <= 0;
    end
    
    //gen data
    initial begin
        data = 0;
	    #100ns;
	    #8ns;
	    data <= 32'h0892_9834;
	    #2ns;
	    data <= 32'h9834_3425;
	    #2ns;
	    data <= 32'h0;
    end
  
endmodule
