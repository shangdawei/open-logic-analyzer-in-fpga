module control_sm (clock, reset, busy, want_to_reconfig,intended_rom, mux_sel, write_from_rom, reconfig, current_state,main_reset_rom_address,reset_rom_address);

	input  clock;
	input  reset;
	input  busy;
	input  want_to_reconfig;
	input  [1:0] intended_rom;
	output [1:0] mux_sel;
	output write_from_rom;
	output reconfig;
	output [2:0] current_state;
	input  main_reset_rom_address;
	output reset_rom_address;

parameter state_0 = 3'b000;
parameter state_1 = 3'b001;
parameter state_2 = 3'b010;
parameter state_3 = 3'b011;
parameter state_4 = 3'b100;
parameter state_5 = 3'b101;
parameter state_6 = 3'b110;

reg [1:0] sel_temp;
reg [2:0] state, next_state;

wire [2:0] state_temp;
assign write_from_rom = ( state_temp == state_1 )? 1'b1 :1'b0;
assign reconfig = ( state_temp == state_4 )? 1'b1 :1'b0;
assign current_state = state_temp;
wire temp_1;
assign temp1 = main_reset_rom_address;
assign reset_rom_address = temp1;

always @ (posedge clock or posedge reset)

	begin
		if (reset)
		state <= state_0;
		else
		state <= next_state;
	end


always @ (posedge clock or posedge reset)

	begin
		if (reset)
			sel_temp <= 2'b00;
		else
			if (want_to_reconfig == 1'b1)
				sel_temp <= intended_rom; 			
		    else
		         sel_temp <= sel_temp;
	end



always @ (state or busy or want_to_reconfig )

	begin
		
		
		case (state)

				state_0: begin
				
				
													
					if (want_to_reconfig == 1'b1) 
								begin
								
								next_state <= state_1;
						
								end

					else 
					
						begin
							next_state <= state_0;
							
					    end



				end

				state_1: begin

					
					next_state <= state_2 ;				

					
				end


				state_2: begin

					

					if (busy == 1'b1) 
							
								begin

									next_state <= state_3;

								end

					else 
						
								begin

									next_state <= state_2;
						
								end



						end


				state_3: begin



					if (busy == 1'b0) 
							
						begin

						next_state <= state_4;
							
						end

					else 
						
						begin

						next_state <= state_3;
						
						end



				end
			
					
				
				state_4: begin
				
				next_state <= state_5;
				
				end

						
				state_5: begin


					if (busy == 1'b1) 
							
								begin

									next_state <= state_6;

								end

					else 
						
								begin

									next_state <= state_5;
						
								end



						end

			
			
			
			state_6: 
				
				begin



					if (busy == 1'b0) 
							
						begin

						next_state <= state_0;
							
						end

					else 
						
						begin

						next_state <= state_6;
						
						end



				end
			

			default:begin
				
				next_state <= state_0;

				end

		endcase
	end


assign mux_sel = sel_temp;
assign state_temp = state;

endmodule
