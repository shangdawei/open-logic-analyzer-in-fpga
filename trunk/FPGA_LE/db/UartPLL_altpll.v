//altpll bandwidth_type="AUTO" CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" clk0_divide_by=3125 clk0_duty_cycle=50 clk0_multiply_by=16 clk0_phase_shift="0" clk1_divide_by=3125 clk1_duty_cycle=50 clk1_multiply_by=64 clk1_phase_shift="0" compensate_clock="CLK0" device_family="Stratix II" inclk0_input_frequency=20000 intended_device_family="Cyclone III" operation_mode="normal" pll_type="AUTO" port_clk0="PORT_USED" port_clk1="PORT_USED" port_clk2="PORT_UNUSED" port_clk3="PORT_UNUSED" port_clk4="PORT_UNUSED" port_clk5="PORT_UNUSED" port_extclk0="PORT_UNUSED" port_extclk1="PORT_UNUSED" port_extclk2="PORT_UNUSED" port_extclk3="PORT_UNUSED" port_inclk1="PORT_UNUSED" port_phasecounterselect="PORT_UNUSED" port_phasedone="PORT_UNUSED" port_scandata="PORT_UNUSED" port_scandataout="PORT_UNUSED" self_reset_on_loss_lock="ON" width_clock=5 clk inclk locked
//VERSION_BEGIN 9.1 cbx_altpll 2009:10:21:21:22:16:SJ cbx_cycloneii 2009:10:21:21:22:16:SJ cbx_mgl 2009:10:21:21:37:49:SJ cbx_stratixii 2009:10:21:21:22:16:SJ cbx_util_mgl 2009:10:21:21:22:16:SJ  VERSION_END
//CBXI_INSTANCE_NAME="Block1_UartPLL_inst19_altpll_altpll_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2009 Altera Corporation
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, Altera MegaCore Function License 
//  Agreement, or other applicable license agreement, including, 
//  without limitation, that your use is for the sole purpose of 
//  programming logic devices manufactured by Altera and sold by 
//  Altera or its authorized distributors.  Please refer to the 
//  applicable agreement for further details.



//synthesis_resources = stratixii_pll 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  UartPLL_altpll
	( 
	clk,
	inclk,
	locked) /* synthesis synthesis_clearbox=1 */;
	output   [4:0]  clk;
	input   [1:0]  inclk;
	output   locked;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [1:0]  inclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [5:0]   wire_pll1_clk;
	wire  wire_pll1_locked;

	stratixii_pll   pll1
	( 
	.activeclock(),
	.clk(wire_pll1_clk),
	.clkbad(),
	.clkloss(),
	.enable0(),
	.enable1(),
	.inclk(inclk),
	.locked(wire_pll1_locked),
	.scandataout(),
	.scandone(),
	.sclkout(),
	.testdownout(),
	.testupout()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clkswitch(1'b0),
	.ena(1'b1),
	.fbin(1'b0),
	.pfdena(1'b1),
	.scanclk(1'b0),
	.scandata(1'b0),
	.scanread(1'b0),
	.scanwrite(1'b0),
	.testin({4{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		pll1.bandwidth_type = "auto",
		pll1.clk0_divide_by = 3125,
		pll1.clk0_duty_cycle = 50,
		pll1.clk0_multiply_by = 16,
		pll1.clk0_phase_shift = "0",
		pll1.clk1_divide_by = 3125,
		pll1.clk1_duty_cycle = 50,
		pll1.clk1_multiply_by = 64,
		pll1.clk1_phase_shift = "0",
		pll1.compensate_clock = "clk0",
		pll1.inclk0_input_frequency = 20000,
		pll1.operation_mode = "normal",
		pll1.pll_type = "auto",
		pll1.lpm_type = "stratixii_pll";
	assign
		clk = {0{wire_pll1_clk}},
		locked = wire_pll1_locked;
	initial/*synthesis enable_verilog_initial_construct*/
 	begin
		$display("Error: MGL_INTERNAL_ERROR: Port object altpll|clk of width  5 is being assigned the port altpll|stratixii_pll inst pll1|clk of width 6 which is illegal, as port widths dont match nor are multiples. CAUSE : The port widths are mismatched in the mentioned assignment. The port widths of the connected ports should match or the LHS port width should be a multiple of the RHS port width. ACTION : Check the port widths of the connected ports. Logical operation results in a port width equal to the larger of the two ports and concatenation results in a port width equal to the sum of the individual port widths. Double check for such cases.");
	end
endmodule //UartPLL_altpll
//ERROR FILE
