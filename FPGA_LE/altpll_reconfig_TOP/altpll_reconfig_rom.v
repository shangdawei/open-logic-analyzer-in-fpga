module altpll_reconfig_rom (

input_clock,
input_reset,
input_want_to_reconfig,
input_intended_rom,
c0,
c1,
c2,
c3,
c4,
locked,
output_current_state,
input_main_reset_rom_address,
tapout_busy,
tapout_rom_common_rden,
tapout_rom_common_address,
tapout_rom_data_in,
tapout_reconfig

);



input  input_clock;
input  input_reset;
input  input_want_to_reconfig;
input  [ 1:0] input_intended_rom;
output [2:0] output_current_state;
output c0;
output c1;
output c2;
output c3;
output c4;
output locked;
input  input_main_reset_rom_address;
output tapout_busy;
output tapout_rom_common_rden;
output [7:0] tapout_rom_common_address;
output tapout_rom_data_in;
output tapout_reconfig;

wire [1:0] mux_sel_wire;
wire [7:0] rom_common_address_wire;
wire rom_common_rden_wire;
wire rom_0_q_wire;
wire rom_1_q_wire;
wire rom_2_q_wire;
wire rom_3_q_wire;
wire rom_data_in_wire;
wire reconfig_wire;
wire write_from_rom_wire;
wire pll_areset_wire;
wire pll_configupdate_wire;
wire pll_scanclk_wire;
wire pll_scanclkena_wire;
wire pll_scandata_wire;
wire pll_scandataout_wire;
wire pll_scandone_wire;
wire busy_wire;
wire reset_rom_address_wire;

assign tapout_busy = busy_wire;
assign tapout_rom_common_rden = rom_common_rden_wire;
assign tapout_rom_common_address = rom_common_address_wire;
assign tapout_rom_data_in = rom_data_in_wire;
assign tapout_reconfig = reconfig_wire; 

 the_pll u1 (
				
				.areset(pll_areset_wire),
				.configupdate(pll_configupdate_wire),
				.inclk0(input_clock),
				.scanclk(pll_scanclk_wire),
				.scanclkena(pll_scanclkena_wire),
				.scandata(pll_scandata_wire),
				.c0(c0),
				.c1(c1),
				.c2(c2),
				.c3(c3),
				.c4(c4),
				.locked(locked),
				.scandataout(pll_scandataout_wire),
				.scandone(pll_scandone_wire));
				

pll_reconfig_circuit u2 (
				
				.clock(input_clock),
				.counter_param(3'b000),
				.counter_type(4'b0000),
				.data_in(9'b000000000),
				.pll_areset_in(1'b0),
				.pll_scandataout(pll_scandataout_wire),
				.pll_scandone(pll_scandone_wire),
				.read_param(1'b0),
				.reconfig(reconfig_wire),
				.reset(input_reset),
				.reset_rom_address(reset_rom_address_wire),
				.rom_data_in(rom_data_in_wire),
				.write_from_rom(write_from_rom_wire),
				.write_param(1'b0),
				.busy(busy_wire),
				.data_out(),
				.pll_areset(pll_areset_wire),
				.pll_configupdate(pll_configupdate_wire),
				.pll_scanclk(pll_scanclk_wire),
				.pll_scanclkena(pll_scanclkena_wire),
				.pll_scandata(pll_scandata_wire),
				.rom_address_out(rom_common_address_wire),
				.write_rom_ena(rom_common_rden_wire));


rom_muxer u3 (
	
		  .data0(rom_0_q_wire),
	      .data1(rom_1_q_wire),
		  .data2(rom_2_q_wire),
	      .data3(rom_3_q_wire),
	      .sel(mux_sel_wire),
	      .result(rom_data_in_wire));


rom_1 u4 (


	.address(rom_common_address_wire),
	.clock(input_clock),
	.rden(rom_common_rden_wire),
	.q(rom_0_q_wire));



rom_2 u5 (


	.address(rom_common_address_wire),
	.clock(input_clock),
	.rden(rom_common_rden_wire),
	.q(rom_1_q_wire));


rom_3 u6 (


	.address(rom_common_address_wire),
	.clock(input_clock),
	.rden(rom_common_rden_wire),
	.q(rom_2_q_wire));


rom_4 u7 (

	.address(rom_common_address_wire),
	.clock(input_clock),
	.rden(rom_common_rden_wire),
	.q(rom_3_q_wire));


control_sm u8 (


	.clock(input_clock),
	.reset(input_reset),
	.busy(busy_wire),
	.want_to_reconfig(input_want_to_reconfig),
	.intended_rom (input_intended_rom),
	.mux_sel(mux_sel_wire),
	.write_from_rom(write_from_rom_wire),
	.reconfig (reconfig_wire),
	.current_state(output_current_state),
	.main_reset_rom_address(input_main_reset_rom_address),
	.reset_rom_address(reset_rom_address_wire)
	
	
);


				

endmodule