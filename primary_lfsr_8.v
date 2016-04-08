`timescale 1ns/10ps
module primary_lfsr_8 #(
parameter POLY_WIDTH = 528,
parameter NUM_OF_STEPS = 17
) 
(
input           clk,
input           rst,
input           enable,
input           write,
input    [11:0] addr,
input    [31:0] lfsrdin,
output   [(POLY_WIDTH-1):0] dout  
);

wire [(POLY_WIDTH-1):0] lfsr_ld_data_c;   
wire         lfsr_ld_c;
wire [(POLY_WIDTH-1):0] lfsr_reg_c;            
wire [(POLY_WIDTH-1):0] temp_c[(NUM_OF_STEPS-1):0],shift;  
reg  [(POLY_WIDTH-1):0] lfsr_reg;           
reg          enable_d;            

wire load_wrd_0 ;
wire load_wrd_1 ;
wire load_wrd_2 ;
wire load_wrd_3 ;
wire load_wrd_4 ;
wire load_wrd_5 ;
wire load_wrd_6 ;
wire load_wrd_7 ;
wire load_wrd_8 ;
wire load_wrd_9 ;
wire load_wrd_10;
wire load_wrd_11;
wire load_wrd_12;
wire load_wrd_13;
wire load_wrd_14;
wire load_wrd_15;
wire load_wrd_16;


assign shift = (enable | enable_d) ? lfsr_reg : 0;
assign dout = lfsr_reg;



assign load_wrd_0 =  (addr == 12'h0ba) & write;  
assign load_wrd_1 =  (addr == 12'h0bb) & write;
assign load_wrd_2 =  (addr == 12'h0bc) & write;  
assign load_wrd_3 =  (addr == 12'h0bd) & write;
assign load_wrd_4 =  (addr == 12'h0be) & write;  
assign load_wrd_5 =  (addr == 12'h0bf) & write;
assign load_wrd_6 =  (addr == 12'h0c0) & write;  
assign load_wrd_7 =  (addr == 12'h0c1) & write;
assign load_wrd_8 =  (addr == 12'h0c2) & write;  
assign load_wrd_9 =  (addr == 12'h0c3) & write;
assign load_wrd_10 =  (addr == 12'h0c4) & write;  
assign load_wrd_11 =  (addr == 12'h0c5) & write;
assign load_wrd_12 =  (addr == 12'h0c6) & write;  
assign load_wrd_13 =  (addr == 12'h0c7) & write;
assign load_wrd_14 =  (addr == 12'h0c8) & write;  
assign load_wrd_15 =  (addr == 12'h0c9) & write;
assign load_wrd_16 =  (addr == 12'h0ca) & write;  



assign lfsr_ld_data_c[31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[31:0];
assign lfsr_ld_data_c[63:32] =  ( load_wrd_1 ) ? lfsrdin : lfsr_reg[63:32];
assign lfsr_ld_data_c[95:64] =  ( load_wrd_2 ) ? lfsrdin : lfsr_reg[95:64];
assign lfsr_ld_data_c[127:96] =  ( load_wrd_3 ) ? lfsrdin : lfsr_reg[127:96];
assign lfsr_ld_data_c[159:128] =  ( load_wrd_4 ) ? lfsrdin : lfsr_reg[159:128];
assign lfsr_ld_data_c[191:160] =  ( load_wrd_5 ) ? lfsrdin : lfsr_reg[191:160];
assign lfsr_ld_data_c[223:192] =  ( load_wrd_6 ) ? lfsrdin : lfsr_reg[223:192];
assign lfsr_ld_data_c[255:224] =  ( load_wrd_7 ) ? lfsrdin : lfsr_reg[255:224];
assign lfsr_ld_data_c[287:256] =  ( load_wrd_8 ) ? lfsrdin : lfsr_reg[287:256];
assign lfsr_ld_data_c[319:288] =  ( load_wrd_9 ) ? lfsrdin : lfsr_reg[319:288];
assign lfsr_ld_data_c[351:320] =  ( load_wrd_10 ) ? lfsrdin : lfsr_reg[351:320];
assign lfsr_ld_data_c[383:352] =  ( load_wrd_11 ) ? lfsrdin : lfsr_reg[383:352];
assign lfsr_ld_data_c[415:384] =  ( load_wrd_12 ) ? lfsrdin : lfsr_reg[415:384];
assign lfsr_ld_data_c[447:416] =  ( load_wrd_13 ) ? lfsrdin : lfsr_reg[447:416];
assign lfsr_ld_data_c[479:448] =  ( load_wrd_14 ) ? lfsrdin : lfsr_reg[479:448];
assign lfsr_ld_data_c[511:480] =  ( load_wrd_15 ) ? lfsrdin : lfsr_reg[511:480];
assign lfsr_ld_data_c[(POLY_WIDTH-1):512] =  ( load_wrd_16  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):512];           







assign lfsr_ld_c = (load_wrd_0  | load_wrd_1 |
                    load_wrd_2  | load_wrd_3 |
                    load_wrd_4  | load_wrd_5 |
                    load_wrd_6  | load_wrd_7 |
                    load_wrd_8  | load_wrd_9 |
                    load_wrd_10  | load_wrd_11 | 
                    load_wrd_12  | load_wrd_13 |
                    load_wrd_14  | load_wrd_15 |
                    load_wrd_16);


assign temp_c[0] = {shift[526:401],
                    shift[(POLY_WIDTH-1)]^shift[400],
                    shift[399:283],
                    shift[(POLY_WIDTH-1)]^shift[282],
                    shift[281:169],
                    shift[(POLY_WIDTH-1)]^shift[168],
                    shift[167:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[16] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter

   assign temp_c[i] = {temp_c[i-1][526:401],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][400],
                       temp_c[i-1][399:283],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][282],
                       temp_c[i-1][281:169],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][168],
                       temp_c[i-1][167:0],
                       temp_c[i-1][(POLY_WIDTH-1)]};
                       
  end
endgenerate

always @ ( posedge clk or posedge rst )
begin
  if (rst) 
  begin
    lfsr_reg     <= #1 1'b0; 
    enable_d     <= #1 1'b0;
  end
  else
  begin
    enable_d <= #1 enable;
    lfsr_reg <= #1 lfsr_reg_c;
  end
end

endmodule

