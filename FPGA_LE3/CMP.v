module CMP(In,flag);
input [9:0] In;
output reg flag;

always @(In) begin
	if(In>30)begin
		flag=1;
	end else begin
		flag=0;
	end
end

endmodule