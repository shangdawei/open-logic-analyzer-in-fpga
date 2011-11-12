module TrigClrDelay(CLK,ENTrig,Trigin,Trigout,delayL,delayH,setdelay);
input CLK;
input ENTrig;
input Trigin;
output reg Trigout;
reg [3:0] state;
input [7:0] delayH;
input [2:0] delayL;
wire [11:0] delay;
assign delay={delayH,delayL};
input setdelay;
reg [11:0]tdelay;
reg [11:0]delaytime;

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
			if(delaytime>10)
				delaytime=delaytime-1;
			else if(delaytime==0)begin
				if(Trigin)
					delaytime=tdelay;
				else
					;
			end
		else 
			delaytime=0;
	end
	
	always begin
		if(delaytime<=10&&delaytime>=1)
			Trigout=1;
		else 
			Trigout=0;
	end

endmodule
