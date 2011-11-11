module core(FinishRD,almostfull,Trig,CLK,locked,Reload,ENWFIFO,ENTrig,ENOUT,ClrFIFO,state);
/*
状态：
（预读数，不能触发），（正常读数，允许触发），（触发，回传数据），清空内存，            
1.读入FIFO使能，触发模块不使能，触发模块输出1
almostfull=1
2.读入FIFO使能，触发模块使能，触发模块输出1
触发时输出0
3.读入FIFO不使能，触发模块不使能，
Wrusedw0<5
4.清空FIFO
达到下一个时钟周期
*/
	input FinishRD;
	input almostfull;
	input Trig;
	input CLK;
	input locked;
	input Reload;
	
	reg tTrig;
	
	output reg ENWFIFO;
	output reg ENTrig;
	output reg ENOUT;
	output reg ClrFIFO;
	
	output reg [3:0] state;
	reg [3:0] timecalc;
	initial begin
		state=0;
	end
	
	always @(posedge CLK,negedge locked)begin
		if(!locked)begin
			state=8;
		end else begin
			casex(state)
				4'b000?:
					if(almostfull)begin
						state=2;
						timecalc=0;
					end
				4'b001?:
					if(Trig)begin
						state=state<<1;
						timecalc=0;
					end
				4'b01??:
					if(FinishRD)begin
						state=state<<1;
						timecalc=0;
					end
				4'b1???:
					begin
						if(Reload)begin
							timecalc=timecalc+1;
						end
						if(timecalc>4'hA)begin
							state=0;
						end
					end
			endcase
		end
	end
	
	always @(posedge CLK)begin
		if(state[3]==1 || state[2]==1 || locked==0)begin
			ENWFIFO=0;
		end else begin
			ENWFIFO=1;
		end
	end
	
	always @(posedge CLK)begin
		if(state[1]==1 && state[2]!=1 && state[3]!=1 && locked==1)begin
			ENTrig=1;
		end else begin
			ENTrig=0;
		end
	end
	
	always @(posedge CLK)begin
		if(state[2]==1 && locked==1)begin
			ENOUT=1;
		end else begin
			ENOUT=0;
		end
	end
	
	always @(posedge CLK)begin
		if(state[3]==1 && locked==1)begin
			ClrFIFO=1;
		end else begin
			ClrFIFO=0;
		end
	end
	
endmodule
