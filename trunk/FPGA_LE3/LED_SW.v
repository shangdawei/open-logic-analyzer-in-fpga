module LED_SW(
in0,in1,in2,in3,in4,
in5,in6,in7,in8,in9,
ou
);
	input in0,in1,in2,in3,in4;
	input in5,in6,in7,in8,in9;
	output [9:0]ou;
	
	assign ou[0]=in0;
	assign ou[1]=in1;
	assign ou[2]=in2;
	assign ou[3]=in3;
	assign ou[4]=in4;
	assign ou[5]=in5;
	assign ou[6]=in6;
	assign ou[7]=in7;
	assign ou[8]=in8;
	assign ou[9]=in9;
	
endmodule
