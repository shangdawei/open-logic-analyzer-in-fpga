module OutClkCtrl(
CLKin1,
CLKin2,
CLKout,
cmd,
wcmd,
PLLin
);

input CLKin1;
input CLKin2;
wire CLKin;
assign CLKin = (subsel)?CLKin1:CLKin2;
input [7:0]cmd;
input wcmd;
output [2:0]CLKout;
input [2:0]PLLin;

reg subsel;
reg sel;
reg [2:0] CLKin_ex3;
reg [2:0] state;


assign CLKout[0]=(sel)?(CLKin_ex3[0]):(PLLin[0]);
assign CLKout[1]=(sel)?(CLKin_ex3[1]):(PLLin[1]);
assign CLKout[2]=(sel)?(CLKin_ex3[2]):(PLLin[2]);

	initial begin
		sel=0;
		subsel=0;
	end

	always @(posedge wcmd)begin
		sel=cmd[0];
		subsel=cmd[1];
	end

	always @(negedge CLKin)begin
		state=state+1;
	end

	always @(posedge CLKin)begin
		CLKin_ex3[0]=state[0];
		CLKin_ex3[1]=~state[0];
		CLKin_ex3[2]=state[2];
	end

	
endmodule
