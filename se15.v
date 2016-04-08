`timescale 1ns/10ps
module se15(
input           clk,
input           rst,
input           write,
input    [11:0] addr,
input    [31:0] lfsrdin,
input           pushin,
input     [7:0] datain,
input    [31:0] entrophy,
output          pushout,
output   [31:0] dataout
);

wire [95:0]  dout0;
wire [300:0] dout1;
wire [284:0] dout2;
wire [346:0] dout3;
wire [33:0]  dout4;
wire [42:0]  dout5;
wire [83:0]  dout6;
wire [341:0] dout7;
wire [527:0] dout8;
wire [126:0] dout9;
wire [85:0]  dout10;
wire [72:0]  dout11;
wire [211:0] dout12;
wire [194:0] dout13;
wire [146:0] dout14;
wire [63:0]  dout15;
wire [63:0]  dout_data_selector;
wire   [9:0] pad_bits_for_data_selector;
wire  [15:0] pad_bits_for_scrambler;
wire  [31:0] data_plus_entr;

primary_lfsr_0 primary_lfsr_0_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .bits_stream(pad_bits_for_data_selector),
                                    .dout(dout0) );

primary_lfsr_1 primary_lfsr_1_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout1) );

primary_lfsr_2 primary_lfsr_2_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout2) );

primary_lfsr_3 primary_lfsr_3_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout3) );

primary_lfsr_4 primary_lfsr_4_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout4) );

primary_lfsr_5 primary_lfsr_5_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout5) );

primary_lfsr_6 primary_lfsr_6_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout6) );

primary_lfsr_7 primary_lfsr_7_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout7) );

primary_lfsr_8 primary_lfsr_8_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout8) );

primary_lfsr_9 primary_lfsr_9_dut ( .clk(clk),
                                    .rst(rst),
                                    .enable(pushin),
                                    .write(write),
                                    .lfsrdin(lfsrdin),
                                    .addr(addr),
                                    .dout(dout9) );

primary_lfsr_10 primary_lfsr_10_dut ( .clk(clk),
                                      .rst(rst),
                                      .enable(pushin),
                                      .write(write),
                                      .lfsrdin(lfsrdin),
                                      .addr(addr),
                                      .dout(dout10) );

primary_lfsr_11 primary_lfsr_11_dut ( .clk(clk),
                                      .rst(rst),
                                      .enable(pushin),
                                      .write(write),
                                      .lfsrdin(lfsrdin),
                                      .addr(addr),
                                      .dout(dout11) );

primary_lfsr_12 primary_lfsr_12_dut ( .clk(clk),
                                      .rst(rst),
                                      .enable(pushin),
                                      .write(write),
                                      .lfsrdin(lfsrdin),
                                      .addr(addr),
                                      .dout(dout12) );

primary_lfsr_13 primary_lfsr_13_dut ( .clk(clk),
                                      .rst(rst),
                                      .enable(pushin),
                                      .write(write),
                                      .lfsrdin(lfsrdin),
                                      .addr(addr),
                                      .dout(dout13) );

primary_lfsr_14 primary_lfsr_14_dut ( .clk(clk),
                                      .rst(rst),
                                      .enable(pushin),
                                      .write(write),
                                      .lfsrdin(lfsrdin),
                                      .addr(addr),
                                      .dout(dout14) );

primary_lfsr_15 primary_lfsr_15_dut ( .clk(clk),
                                      .rst(rst),
                                      .enable(pushin),
                                      .write(write),
                                      .lfsrdin(lfsrdin),
                                      .addr(addr),
                                      .dout(dout15) );

data_selector data_selector_dut ( .clk(clk),
                                  .rst(rst),
                                  .enable(pushin),
                                  .write(write),
                                  .lfsrdin(lfsrdin),
                                  .bits_stream(pad_bits_for_data_selector),
                                  .addr(addr),
                                  .dout(dout_data_selector) );

poly_select_mux poly_select_mux_1( .p0  ( dout0),
                                   .p1  ( dout1),
                                   .p2  ( dout2),
                                   .p3  ( dout3),
                                   .p4  ( dout4),
                                   .p5  ( dout5),
                                   .p6  ( dout6),
                                   .p7  ( dout7),
                                   .p8  ( dout8),
                                   .p9  ( dout9),
                                   .p10 (dout10),
                                   .p11 (dout11),
                                   .p12 (dout12),
                                   .p13 (dout13),
                                   .p14 (dout14),
                                   .p15 (dout15),
                                   .data_sel_to_poly_mux(dout_data_selector),
                                   .data_out(pad_bits_for_scrambler));

intial_scrmbl_mux intial_scrmbl_mux_1(.data(datain),
                                      .entrophy(entrophy),
                                      .data_sel_i(dout_data_selector),
                                      .data_pls_entr_o(data_plus_entr));


scrambler scrambler_dut(.clk(clk),
                        .rst(rst),
                        .enable(pushin),
                        .data_plus_entr(data_plus_entr), 
                        .pad_key(pad_bits_for_scrambler),
                        .dout(dataout),
                        .pushout(pushout));




endmodule

