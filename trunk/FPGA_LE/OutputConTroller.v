
	
	
module OutputController(DataIn,NumIn,OutCLK,Init,DataOut,RD,FinishRD,tIndex,tDataIn);
	input [127:0] DataIn;
	output reg [127:0] tDataIn;
	input OutCLK;
	input Init;
	input [10:0] NumIn;
	
	output reg [7:0] DataOut;
	output reg RD;
	output reg FinishRD;

	//output reg [3:0]tIndex;
	output reg [4:0] tIndex;//Tmp:Use only one channel;;
	//from 0 to 15 means which byte is Transporting.
	
	initial begin
		tIndex=5'h1F;
	end
	
	always @(posedge OutCLK,posedge Init) begin
		if(Init) begin
			tIndex=4'h1;
			//Important:Init should be set to 1 and the posedge of OutCLK;
			//Then Negedge OutCLK and Init;
		end else if(!FinishRD)begin
			casex(tIndex)
				5'b0????:
				begin
				DataOut=tDataIn>>(tIndex*8);
				tIndex=tIndex+1;
				end
				5'b1????:
				begin
				DataOut=8'hA5;
				tIndex=0;
				end
			endcase
		end
		
	end
	
	always @(negedge OutCLK) begin
		if(!FinishRD&&tIndex[4]==1)begin
			RD=1;
		end else begin
			RD=0;//Prepare for further RD
		end
	end
	
	always @(negedge OutCLK or posedge Init) begin
		if(Init)begin
			tDataIn=128'h5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B5B;
		end else begin 
			if((!FinishRD) && tIndex==0 && (NumIn>2))begin
				tDataIn=DataIn;
			end else if((!FinishRD) && tIndex==0 && (NumIn==2))begin
				tDataIn=128'h59595959595959595959595959595959;
			end
		end
	end
	
	always begin
		if(NumIn<2)begin
			FinishRD=1;
		end else begin
			FinishRD=0;
		end
	end
	
endmodule