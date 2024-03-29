module TrigClrDelay(CLK,ENTrig,Trigin,Trigout,delayL,delayH,setdelay);
input CLK;
input ENTrig;
input Trigin;
output reg Trigout;
reg [3:0] state;
input [7:0] delayL;
input [1:0] delayH;
wire [9:0] delay;
assign delay={delayL,delayH};
input setdelay;
reg [9:0]tdelay;
reg [1023:0] TmpTrig;


	initial begin
		tdelay=100;
	end

	always @(posedge setdelay) begin
		tdelay=delay;
	end
	
	always @(posedge CLK) begin
		if(ENTrig)begin
			if(state==0)begin
				;
			end else begin
				state=state-1;
			end
		end else begin
			state=4'hF;
		end
	end
	
	always @(posedge CLK)begin
		if(state==0)
			TmpTrig={TmpTrig,Trigin};
		else 
			TmpTrig=0;
		Trigout=TmpTrig[tdelay];
	end

endmodule
