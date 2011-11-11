module MyRx(Rx,CLKP4,EN,DataOut,DataReady);
	input Rx;
	input CLKP4;
	input EN;
	
	output reg [7:0] DataOut;
	output reg DataReady;
	
	reg [11:0] Data;
	reg [3:0] ReadyDelay;
	reg [3:0] num;
	reg [3:0] state;
	
	always @(posedge CLKP4) begin
		if(ReadyDelay>0)begin
			DataReady=1;
			ReadyDelay=ReadyDelay-1;
		end else begin
			DataReady=0;
		end
		if(EN)begin
			case(state)
				0:begin
					if(Rx==0)begin
						state=state+1;
						num=0;
					end
				end
				1:begin
					state=state+1;
					Data[2+num]=Rx;
				end
				2:begin
					state=state+1;
				end
				3:begin
					state=state+1;
				end
				4:begin
					if(num==8)begin
						DataOut=Data>>3;
					end
					if(num>=9)begin
						ReadyDelay=10;
						state=0;
						num=0;
					end else begin
						state=1;
						num=num+1;
					end
				end
				default:begin
					state=0;
				end
			endcase 
		end else begin
			state=0;
			num=0;
		end
	end
	

endmodule
