// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Nov 27 22:41:05 2018
// Host        : DESKTOP-LA5JQEG running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/yhj/project_39/project_39.sim/sim_1/synth/func/xsim/mux_tb_func_synth.v
// Design      : mux
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module mux
   (i0,
    i1,
    i2,
    i3,
    s1,
    s2,
    out);
  input i0;
  input i1;
  input i2;
  input i3;
  input s1;
  input s2;
  output out;

  wire i0;
  wire i0_IBUF;
  wire i1;
  wire i1_IBUF;
  wire i2;
  wire i2_IBUF;
  wire i3;
  wire i3_IBUF;
  wire out;
  wire out_OBUF;
  wire s1;
  wire s1_IBUF;
  wire s2;
  wire s2_IBUF;

  IBUF i0_IBUF_inst
       (.I(i0),
        .O(i0_IBUF));
  IBUF i1_IBUF_inst
       (.I(i1),
        .O(i1_IBUF));
  IBUF i2_IBUF_inst
       (.I(i2),
        .O(i2_IBUF));
  IBUF i3_IBUF_inst
       (.I(i3),
        .O(i3_IBUF));
  OBUF out_OBUF_inst
       (.I(out_OBUF),
        .O(out));
  LUT6 #(
    .INIT(64'hAAF0FFCCAAF000CC)) 
    out_OBUF_inst_i_1
       (.I0(i3_IBUF),
        .I1(i0_IBUF),
        .I2(i1_IBUF),
        .I3(s1_IBUF),
        .I4(s2_IBUF),
        .I5(i2_IBUF),
        .O(out_OBUF));
  IBUF s1_IBUF_inst
       (.I(s1),
        .O(s1_IBUF));
  IBUF s2_IBUF_inst
       (.I(s2),
        .O(s2_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
