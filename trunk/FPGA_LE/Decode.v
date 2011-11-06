module Decode(DataIn,CLK,Locked,CLR,Order,Data,adden,SetInit,TrigEN,SetTrigTime,SoftReload,SerPLL,stateLED);

	input [7:0] DataIn;
	input CLK;
	input Locked;
	input CLR;
	
	reg [1:0] state;
	output reg [7:0] Order;
	output reg [7:0] Data;
	output reg adden;
	output reg SetInit;
	output reg TrigEN;
	output reg SetTrigTime;
	reg SetInit_S;
	output reg SoftReload;
	output reg SerPLL;
	output reg [3:0] stateLED;
	
	//state==0
	//WaitingMode
	//Receive the Order to state 1
	
	//state==1
	//Receive the Data to state 2
	
	//state==2 
	//Do it and wait 
	
	//Receive the END Signal 0xA5 to State 1;
	
	//state==3
	//Deadend
	//Goto state 0
	
	always @(posedge CLK) begin
		if(DataIn==8'hA5)begin
			state=0;
		end else begin
			case (state)
				0:begin
					Order=DataIn;
					state=state+1;
				end
				1:begin
					Data=DataIn;
					state=state+1;
				end
				2:begin
					state=0;
				end
				3:begin
					state=0;
				end
			endcase
		end
	end

	always begin
		if(state==0)
			stateLED=1;
		else if (state==1)
			stateLED=2;
		else
			stateLED=4;
	end
	
	//
	initial begin
		TrigEN=1;
		adden=0;
		SetInit_S=0;
		SetTrigTime=0;
		SoftReload=0;
		SerPLL=0;
	end
	
	always @(negedge CLK)begin
		if(state==2)begin
			//Decode Order;
			casex(Order)
				8'b11111111:begin
					//CLR ALL
				end
				8'b1110????:begin
					//Set Trigger	
					//L4 of Order would be address
					//L4 of Data would be TriggerCMD 
					adden=1;
				end
				8'b1101????:begin
					//Init Trigger
					SetInit_S=1;
				end
				8'b1100????:begin
					//Enable the Trigger
					TrigEN=1;
					
				end
				8'b1011????:begin
					//Disable the Trigger
					TrigEN=0;
				end
				8'b1010????:begin
					
					SetTrigTime=1;
				end
				8'b1001????:begin
					SoftReload=1;
				end
				8'b1000????:begin
					SerPLL=1;
				end
			endcase
		end else begin
			adden=0;
			SetInit_S=0;
			SetTrigTime=0;
			SoftReload=0;
			SerPLL=0;
		end
	end
	
	always begin
		SetInit=SetInit_S || (!Locked);
	end
	
	
endmodule
