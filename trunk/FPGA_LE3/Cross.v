module Cross(Q1,Q2,Q);

input [3:0] Q1;
input [3:0] Q2;
output [7:0] Q;

assign Q[7]=Q1[0];
assign Q[6]=Q2[0];
assign Q[5]=Q1[1];
assign Q[4]=Q2[1];
assign Q[3]=Q1[2];
assign Q[2]=Q2[2];
assign Q[1]=Q1[3];
assign Q[0]=Q2[3];

endmodule
