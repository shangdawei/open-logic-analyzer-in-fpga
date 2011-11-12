/*
CLKDIV16 CopyRight By WenX(c) 2011
Wenxiao1992@gmail.com
edited at 2011-11-4 at Southeast University

This is part of the Open Logic Analyzer in FPGA project
it is a open project of Logic Analyzer in Google Project Hosting
see <http://code.google.com/p/open-logic-analyzer-in-fpga/>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License at <http://www.gnu.org/licenses/>
for more details.
*/

module CLKD16(CLKin,CLKout);
	input CLKin;
	output reg CLKout;
	
	reg [2:0] step;
	
	always @(posedge CLKin)begin
		step=step+1;
		if(step==0)
			CLKout=~CLKout;
	end

endmodule 