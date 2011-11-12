module DShift (CLK,in,out);
input CLK;
input in;
output reg[7:0]out;

always @(posedge CLK) begin
	out=out<<1;
	out[0]=in;
end

endmodule