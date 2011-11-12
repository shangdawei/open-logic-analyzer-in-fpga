module trig(Xin,CLK,EN,wCMD,wEN,SetInit,ResTri);


//EN means if enable the hole Tri.

//CMD[3:0]
//CMD[3] En / DisN
//1 Enable this Trig
//0 Disable this Trig

//CMD[2:0]
//1XX means XinReg==XX
// 00 Low 11 High
// 01 Pos 10 Nege

input Xin;
input CLK;
input EN;
input [3:0] wCMD;
input wEN;
input SetInit;

reg [3:0] CMD;
reg [1:0] XinReg;
output reg ResTri;

always @(posedge CLK)begin
	if(wEN)begin
		CMD=wCMD;
	end
	else if(SetInit) begin
		CMD=4'h0;
	end
end

always @(negedge CLK)begin
	XinReg=(XinReg<<1)|Xin;
end

always begin
	if(EN==0)begin
		ResTri=0;
		//WARNING
		//How the EN works
	end else if((CMD[3]==1))begin
		if((CMD[1]==XinReg[1])&&(CMD[0]==XinReg[0]))begin
			ResTri=1;
		end else begin
			ResTri=0;
		end
	end
	else begin //EN==1 but CMD[3]==0
		ResTri=1;
	end
end

endmodule 