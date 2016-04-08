module scrambler(
input           clk,
input           rst,
input           enable,
input    [31:0] data_plus_entr,   // Data Plus entrophy to be loaded in lfsr
input    [15:0] pad_key,
output   [31:0] dout,
output          pushout
);

wire [31:0] lfsr_reg_c;            // Used to store data of lfsr
wire [31:0] temp_c[15:0],shift;  // Used for steping lfsr in one clock
reg  [31:0] lfsr_reg;            // Used to store data of lfsr
reg          enable_d;            // One clock Delayed version of enable.
reg          enable_dd;            // One clock Delayed version of enable.

assign shift = (enable) ? data_plus_entr : 32'h00000000;
assign dout = lfsr_reg;
assign pushout = enable_d;

assign temp_c[0] = {shift[31]^shift[30],
                    shift[29:25],
                    shift[31]^shift[24],
                    shift[23],
                    shift[31]^shift[22],
                    shift[31]^shift[21],
                    shift[31]^shift[20],
                    shift[31]^shift[19],
                    shift[18],
                    shift[31]^shift[17],
                    shift[31]^shift[16],
                    shift[15:13],
                    shift[31]^shift[12],
                    shift[31]^shift[11],
                    shift[31]^shift[10],
                    shift[9],
                    shift[31]^shift[8],
                    shift[31]^shift[7],
                    shift[6],
                    shift[31]^shift[5],
                    shift[31]^shift[4],
                    shift[31]^shift[3],
                    shift[31]^shift[2],
                    shift[1:0],
                    pad_key[0]};

assign lfsr_reg_c = (enable) ? temp_c[15] : lfsr_reg;

genvar i;

generate
  for (i=1; i<=15; i=i+1) begin:shifter
   assign temp_c[i] = {temp_c[i-1][31]^temp_c[i-1][30],
                    temp_c[i-1][29:25],
                    temp_c[i-1][31]^temp_c[i-1][24],
                    temp_c[i-1][23],
                    temp_c[i-1][31]^temp_c[i-1][22],
                    temp_c[i-1][31]^temp_c[i-1][21],
                    temp_c[i-1][31]^temp_c[i-1][20],
                    temp_c[i-1][31]^temp_c[i-1][19],
                    temp_c[i-1][18],
                    temp_c[i-1][31]^temp_c[i-1][17],
                    temp_c[i-1][31]^temp_c[i-1][16],
                    temp_c[i-1][15:13],
                    temp_c[i-1][31]^temp_c[i-1][12],
                    temp_c[i-1][31]^temp_c[i-1][11],
                    temp_c[i-1][31]^temp_c[i-1][10],
                    temp_c[i-1][9],
                    temp_c[i-1][31]^temp_c[i-1][8],
                    temp_c[i-1][31]^temp_c[i-1][7],
                    temp_c[i-1][6],
                    temp_c[i-1][31]^temp_c[i-1][5],
                    temp_c[i-1][31]^temp_c[i-1][4],
                    temp_c[i-1][31]^temp_c[i-1][3],
                    temp_c[i-1][31]^temp_c[i-1][2],
                    temp_c[i-1][1:0],
                    pad_key[i]};
  end
endgenerate

always @ ( posedge clk or posedge rst )
begin
  if (rst)
  begin
    lfsr_reg     <= #1 'h00000000;
    enable_d     <= #1 1'b0;
    enable_dd    <= #1 1'b0;
  end
  else
  begin
//   if(enable_d) begin
//    $display("Step 0 = %h",temp_c[0] );
//    $display("Step 1 = %h",temp_c[1] );
//    $display("Step 2 = %h",temp_c[2] );
//    $display("Step 3 = %h",temp_c[3] );
//    $display("Step 4 = %h",temp_c[4] );
//    $display("Step 5 = %h",temp_c[5] );
//    $display("Step 6 = %h",temp_c[6] );
//    $display("Step 7 = %h",temp_c[7] );
//    $display("Step 8 = %h",temp_c[8] );
//    $display("Step 9 = %h",temp_c[9] );
//    $display("Step 10 = %h",temp_c[10] );
//    $display("Step 11 = %h",temp_c[11] );
//    $display("Step 12 = %h",temp_c[12] );
//    $display("Step 13 = %h",temp_c[13] );
//    $display("Step 14 = %h",temp_c[14] );
//    $display("Step 15 = %h",temp_c[15] );
//    end

    enable_d  <= #1 enable;
    enable_dd <= #1 enable;
    lfsr_reg  <= #1 lfsr_reg_c;

  end
end

endmodule
