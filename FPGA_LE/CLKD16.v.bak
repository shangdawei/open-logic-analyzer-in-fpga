module CLKD16(CLKin,CLKout);
	input CLKin;
	output reg CLKout;
	
	reg [2:0] step;
	
	always @(posedge CLKin)begin
		step=step+1;
		if(step==0)
			CLKout=~CLKout;
	end

endmodule 