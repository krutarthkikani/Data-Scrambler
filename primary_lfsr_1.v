`timescale 1ns/10ps
module primary_lfsr_1 #(
parameter POLY_WIDTH = 301,
parameter NUM_OF_STEPS = 15
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
wire load_wrd_0 ,load_wrd_1 ,load_wrd_2 ,load_wrd_3 ,load_wrd_4 ,load_wrd_5 , load_wrd_6 , load_wrd_7 , load_wrd_8 , load_wrd_9;

assign shift = (enable | enable_d) ? lfsr_reg : 'h00000000000;
assign dout = lfsr_reg;

assign load_wrd_0 =  (addr == 12'h071) & write;
assign load_wrd_1 =  (addr == 12'h072) & write;
assign load_wrd_2 =  (addr == 12'h073) & write;
assign load_wrd_3 =  (addr == 12'h074) & write;
assign load_wrd_4 =  (addr == 12'h075) & write;
assign load_wrd_5 =  (addr == 12'h076) & write;
assign load_wrd_6 =  (addr == 12'h077) & write;
assign load_wrd_7 =  (addr == 12'h078) & write;
assign load_wrd_8 =  (addr == 12'h079) & write;
assign load_wrd_9 =  (addr == 12'h07a) & write;

assign lfsr_ld_data_c[              31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[   31:0];           
assign lfsr_ld_data_c[             63:32] =  ( load_wrd_1  ) ? lfsrdin : lfsr_reg[  63:32];           
assign lfsr_ld_data_c[             95:64] =  ( load_wrd_2  ) ? lfsrdin : lfsr_reg[  95:64];           
assign lfsr_ld_data_c[            127:96] =  ( load_wrd_3  ) ? lfsrdin : lfsr_reg[ 127:96];           
assign lfsr_ld_data_c[           159:128] =  ( load_wrd_4  ) ? lfsrdin : lfsr_reg[159:128];           
assign lfsr_ld_data_c[           191:160] =  ( load_wrd_5  ) ? lfsrdin : lfsr_reg[191:160];           
assign lfsr_ld_data_c[           223:192] =  ( load_wrd_6  ) ? lfsrdin : lfsr_reg[223:192];           
assign lfsr_ld_data_c[           255:224] =  ( load_wrd_7  ) ? lfsrdin : lfsr_reg[255:224];           
assign lfsr_ld_data_c[           287:256] =  ( load_wrd_8  ) ? lfsrdin : lfsr_reg[287:256];           
assign lfsr_ld_data_c[(POLY_WIDTH-1):288] =  ( load_wrd_9  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):288];           


assign lfsr_ld_c = ((load_wrd_0  | load_wrd_1 | load_wrd_2)
                  | (load_wrd_3  | load_wrd_4  |  load_wrd_5)
                  | (load_wrd_6  | load_wrd_7  |  load_wrd_8 | load_wrd_9 ));



assign temp_c[0] = {shift[(POLY_WIDTH-2):215],
                    shift[(POLY_WIDTH-1)]^shift[214],
                    shift[213:209],
                    shift[(POLY_WIDTH-1)]^shift[208],
                    shift[207:181],
                    shift[(POLY_WIDTH-1)]^shift[180],
                    shift[179:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[(NUM_OF_STEPS-1)] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg;

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter
   assign temp_c[i] = {temp_c[i-1][(POLY_WIDTH-2):215],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][214],
                    temp_c[i-1][213:209],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][208],
                    temp_c[i-1][207:181],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][180],
                    temp_c[i-1][179:0],
                    temp_c[i-1][(POLY_WIDTH-1)]};
  end
endgenerate

always @ ( posedge clk or posedge rst )
begin
  if (rst) 
  begin
    lfsr_reg     <= #1 'h0000000000;
    enable_d     <= #1 1'b0;
  end
  else
  begin
    enable_d <= #1 enable;
    lfsr_reg <= #1 lfsr_reg_c;
  end
end

endmodule
