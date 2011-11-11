module fp2(CLKin,CLKin2,CLKout,CLKout2,sel);
	input CLKin,CLKin2;
	input sel;
	reg tCLK,tCLK2;
	output reg CLKout,CLKout2;
	
	always @(posedge CLKin)begin
		tCLK=~tCLK;
	end
	
	always @(posedge CLKin2)begin
		tCLK2=~tCLK2;
	end
	
	always @(sel) begin
		if(sel)begin
			CLKout=tCLK;
			CLKout=tCLK2;
		end else begin
			CLKout=CLKin;
			CLKout2=CLKin2;
		end
	end

endmodule
