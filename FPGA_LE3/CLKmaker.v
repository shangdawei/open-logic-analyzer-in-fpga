module CLKmaker(CLKin,CLKout,start);

	input start,CLKin;
	output reg [3:0]CLKout;
	reg [1:0] step;
	
	initial begin
		step=2'b0;
	end
	
	
	always@(posedge CLKin) begin
		if(!start) begin
			step=2'h0;
			CLKout=4'h0;
		end		
		else begin
			//00->01->11->10
			case (step)
				2'b01:  begin
					step=2'd3;CLKout=4'h2;
				end
				2'b10:	begin
					step=2'd0;CLKout=4'h8;
				end
				2'b11:	begin
					step=2'd2;CLKout=4'h4;
				end
				default: begin
					step=2'd1;CLKout=4'h1;
				end
			endcase
		end
	end
endmodule