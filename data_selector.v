`timescale 1ns/10ps
module data_selector(
input           clk,
input           rst,
input           enable,
input           write,
input    [11:0] addr,
input    [31:0] lfsrdin,
input     [9:0] bits_stream,
output   [63:0] dout
);

wire [63:0] lfsr_ld_data_c;
wire         lfsr_ld_c;
wire [63:0] lfsr_reg_c;            // Used to store data of lfsr
wire [63:0] temp_c[9:0],shift;  // Used for steping lfsr in one clock
reg  [63:0] lfsr_reg;            // Used to store data of lfsr
reg          enable_d;            // One clock Delayed version of enable.

assign shift = (enable | enable_d) ? lfsr_reg : 64'h00000000;
assign dout = lfsr_reg;

assign load_wrd_0 =  (addr == 12'h068) & write;
assign load_wrd_1 =  (addr == 12'h069) & write;

assign lfsr_ld_data_c[   31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[   31:0];           
assign lfsr_ld_data_c[  63:32] =  ( load_wrd_1  ) ? lfsrdin : lfsr_reg[  63:32];           

assign lfsr_ld_c = ((load_wrd_0  | load_wrd_1));

assign temp_c[0] = {shift[62],
                    shift[63]^shift[61],
                    shift[60:57],
                    shift[63]^shift[56],
                    shift[55],
                    shift[63]^shift[54],
                    shift[63]^shift[53],
                    shift[63]^shift[52],
                    shift[63]^shift[51],
                    shift[50:47],
                    shift[63]^shift[46],
                    shift[63]^shift[45],
                    shift[63]^shift[44],
                    shift[43:40],
                    shift[63]^shift[39],
                    shift[63]^shift[38],
                    shift[63]^shift[37],
                    shift[63]^shift[36],
                    shift[35],
                    shift[63]^shift[34],
                    shift[33],
                    shift[63]^shift[32],
                    shift[63]^shift[31],
                    shift[63]^shift[30],
                    shift[29],
                    shift[63]^shift[28],
                    shift[27],
                    shift[63]^shift[26],
                    shift[25:24],
                    shift[63]^shift[23],
                    shift[63]^shift[22],
                    shift[63]^shift[21],
                    shift[63]^shift[20],
                    shift[19],
                    shift[63]^shift[18],
                    shift[17],
                    shift[63]^shift[16],
                    shift[15:13],
                    shift[63]^shift[12],
                    shift[63]^shift[11],
                    shift[10],
                    shift[63]^shift[9],
                    shift[63]^shift[8],
                    shift[7],
                    shift[63]^shift[6],
                    shift[5:4],
                    shift[63]^shift[3],
                    shift[2:1],
                    shift[63]^shift[0],
                    shift[63]^bits_stream[0]};

assign lfsr_reg_c = (enable) ? temp_c[9] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg;

genvar i;

generate
  for (i=1; i<=9; i=i+1) begin:shifter
   assign temp_c[i] = {temp_c[i-1][62],
                        temp_c[i-1][63]^temp_c[i-1][61],
                        temp_c[i-1][60:57],
                        temp_c[i-1][63]^temp_c[i-1][56],
                        temp_c[i-1][55],
                        temp_c[i-1][63]^temp_c[i-1][54],
                        temp_c[i-1][63]^temp_c[i-1][53],
                        temp_c[i-1][63]^temp_c[i-1][52],
                        temp_c[i-1][63]^temp_c[i-1][51],
                        temp_c[i-1][50:47],
                        temp_c[i-1][63]^temp_c[i-1][46],
                        temp_c[i-1][63]^temp_c[i-1][45],
                        temp_c[i-1][63]^temp_c[i-1][44],
                        temp_c[i-1][43:40],
                        temp_c[i-1][63]^temp_c[i-1][39],
                        temp_c[i-1][63]^temp_c[i-1][38],
                        temp_c[i-1][63]^temp_c[i-1][37],
                        temp_c[i-1][63]^temp_c[i-1][36],
                        temp_c[i-1][35],
                        temp_c[i-1][63]^temp_c[i-1][34],
                        temp_c[i-1][33],
                        temp_c[i-1][63]^temp_c[i-1][32],
                        temp_c[i-1][63]^temp_c[i-1][31],
                        temp_c[i-1][63]^temp_c[i-1][30],
                        temp_c[i-1][29],
                        temp_c[i-1][63]^temp_c[i-1][28],
                        temp_c[i-1][27],
                        temp_c[i-1][63]^temp_c[i-1][26],
                        temp_c[i-1][25:24],
                        temp_c[i-1][63]^temp_c[i-1][23],
                        temp_c[i-1][63]^temp_c[i-1][22],
                        temp_c[i-1][63]^temp_c[i-1][21],
                        temp_c[i-1][63]^temp_c[i-1][20],
                        temp_c[i-1][19],
                        temp_c[i-1][63]^temp_c[i-1][18],
                        temp_c[i-1][17],
                        temp_c[i-1][63]^temp_c[i-1][16],
                        temp_c[i-1][15:13],
                        temp_c[i-1][63]^temp_c[i-1][12],
                        temp_c[i-1][63]^temp_c[i-1][11],
                        temp_c[i-1][10],
                        temp_c[i-1][63]^temp_c[i-1][9],
                        temp_c[i-1][63]^temp_c[i-1][8],
                        temp_c[i-1][7],
                        temp_c[i-1][63]^temp_c[i-1][6],
                        temp_c[i-1][5:4],
                        temp_c[i-1][63]^temp_c[i-1][3],
                        temp_c[i-1][2:1],
                        temp_c[i-1][63]^temp_c[i-1][0],
                        temp_c[i-1][63]^bits_stream[i]};
  end
endgenerate

always @ ( posedge clk or posedge rst )
begin
  if (rst)
  begin
    lfsr_reg     <= #1 63'h0000000000;
    enable_d     <= #1 1'b0;
  end
  else
  begin
    enable_d     <= #1 enable;
    lfsr_reg     <= #1 lfsr_reg_c;
  end
end

endmodule
