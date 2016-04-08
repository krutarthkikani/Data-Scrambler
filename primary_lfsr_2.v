`timescale 1ns/10ps
module primary_lfsr_2 #(
parameter POLY_WIDTH = 285,
parameter NUM_OF_STEPS = 11
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
wire load_wrd_0 ,load_wrd_1 ,load_wrd_2 ,load_wrd_3 ,load_wrd_4 ,load_wrd_5 , load_wrd_6 , load_wrd_7 , load_wrd_8;

assign shift = (enable | enable_d) ? lfsr_reg : 'h00000000000;
assign dout = lfsr_reg;

assign load_wrd_0 =  (addr == 12'h081) & write;
assign load_wrd_1 =  (addr == 12'h082) & write;
assign load_wrd_2 =  (addr == 12'h083) & write;
assign load_wrd_3 =  (addr == 12'h084) & write;
assign load_wrd_4 =  (addr == 12'h085) & write;
assign load_wrd_5 =  (addr == 12'h086) & write;
assign load_wrd_6 =  (addr == 12'h087) & write;
assign load_wrd_7 =  (addr == 12'h088) & write;
assign load_wrd_8 =  (addr == 12'h089) & write;

assign lfsr_ld_data_c[              31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[   31:0];           
assign lfsr_ld_data_c[             63:32] =  ( load_wrd_1  ) ? lfsrdin : lfsr_reg[  63:32];           
assign lfsr_ld_data_c[             95:64] =  ( load_wrd_2  ) ? lfsrdin : lfsr_reg[  95:64];           
assign lfsr_ld_data_c[            127:96] =  ( load_wrd_3  ) ? lfsrdin : lfsr_reg[ 127:96];           
assign lfsr_ld_data_c[           159:128] =  ( load_wrd_4  ) ? lfsrdin : lfsr_reg[159:128];           
assign lfsr_ld_data_c[           191:160] =  ( load_wrd_5  ) ? lfsrdin : lfsr_reg[191:160];           
assign lfsr_ld_data_c[           223:192] =  ( load_wrd_6  ) ? lfsrdin : lfsr_reg[223:192];           
assign lfsr_ld_data_c[           255:224] =  ( load_wrd_7  ) ? lfsrdin : lfsr_reg[255:224];           
assign lfsr_ld_data_c[(POLY_WIDTH-1):256] =  ( load_wrd_8  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):256];           


assign lfsr_ld_c = ((load_wrd_0  | load_wrd_1 | load_wrd_2)
                  | (load_wrd_3  | load_wrd_4  |  load_wrd_5)
                  | (load_wrd_6  | load_wrd_7  |  load_wrd_8));



assign temp_c[0] = {shift[(POLY_WIDTH-2):269],
                    shift[(POLY_WIDTH-1)]^shift[268],
                    shift[267:255],
                    shift[(POLY_WIDTH-1)]^shift[254],
                    shift[253:222],
                    shift[(POLY_WIDTH-1)]^shift[221],
                    shift[220:188],
                    shift[(POLY_WIDTH-1)]^shift[187],
                    shift[186:129],
                    shift[(POLY_WIDTH-1)]^shift[128],
                    shift[127:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[(NUM_OF_STEPS-1)] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg;

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter
   assign temp_c[i] = {temp_c[i-1][(POLY_WIDTH-2):269],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][268],
                    temp_c[i-1][267:255],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][254],
                    temp_c[i-1][253:222],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][221],
                    temp_c[i-1][220:188],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][187],
                    temp_c[i-1][186:129],
                    temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][128],
                    temp_c[i-1][127:0],
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
