module MyUart(EN,Init,SendingCLK,Data,Tx,RdCLK);
	input EN;
	input Init;
	input SendingCLK;
	input [7:0]Data;
	
	output reg Tx;
	output reg RdCLK;
	
	reg [4:0]index;
	reg [7:0]store;
	
	initial begin
		index=0;
		store=255;
		Tx=1;
		RdCLK=0;
	end
	
	always @(negedge SendingCLK)begin
		if(index==0&&EN)begin
			//Here Tx should be 0;
			store=Data;
		end
	end

	always @(posedge SendingCLK)begin
		if(Init)begin
			index=0;
		end else if(EN || (index!=0)) begin
			case(index)
				0:Tx=1;
				1:Tx=0;
				10:Tx=1;
				11:Tx=1;
				12:Tx=1;
				13:Tx=1;
				14:Tx=1;
				15:Tx=1;
				default:Tx=store[9-index];
			endcase
			
			if(index>10)begin
				index=0;
			end else begin
				index=index+1;
			end
		end else begin
			Tx=1;
			index=0;
		end
	end
	
	always @(posedge SendingCLK) begin
		if(index>=9) begin
			RdCLK=1;
		end else begin
			RdCLK=0;
		end
	end
	
endmodule
