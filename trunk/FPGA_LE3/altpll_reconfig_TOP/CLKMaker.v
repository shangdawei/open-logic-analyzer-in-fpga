/*module CLKMaker(CLKin,CLKout,cmd,CLK_w_cmd);
	input CLKin;
	input [2:0]cmd;
	input CLK_w_cmd;
	output CLKout;
	reg [10:0] calc0;
	reg [10:0] calc1;
	reg [10:0] calc2;
	reg [10:0] calc3;
	reg tCLKout0;
	reg tCLKout1;
	reg tCLKout2;
	reg tCLKout3;
	reg sel;

	always @(posedge CLKin)begin
		if(calc>500)begin
			calc=0;
			tCLKout=~tCLKout;
		end else begin
			calc=calc+1;
		end
	end

	always @(posedge CLK_w_cmd)begin
		if(cmd[2]==1)begin
			sel=1;
		end else begin
			sel=0;
		end
	end

	assign CLKout=sel?tCLKout:CLKin;

endmodule
*/