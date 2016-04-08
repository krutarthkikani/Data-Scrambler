`timescale 1ns/10ps
module primary_lfsr_6 #(
parameter POLY_WIDTH = 84,
parameter NUM_OF_STEPS = 14
) 
(
input                       clk,
input                       rst,
input                       enable,
input                       write,
input                [11:0] addr,
input                [31:0] lfsrdin,
output   [(POLY_WIDTH-1):0] dout 
);

wire                    lfsr_ld_c;
wire [(POLY_WIDTH-1):0] lfsr_ld_data_c;      
wire [(POLY_WIDTH-1):0] lfsr_reg_c;            
wire [(POLY_WIDTH-1):0] temp_c[(NUM_OF_STEPS-1):0],shift;  
reg  [(POLY_WIDTH-1):0] lfsr_reg;            
reg                      enable_d;            
wire load_wrd_0 ,load_wrd_1 ,load_wrd_2;

assign shift = (enable | enable_d) ? lfsr_reg : 'h00000000000;
assign dout = lfsr_reg;

assign load_wrd_0 =  (addr == 12'h0a9) & write;
assign load_wrd_1 =  (addr == 12'h0aa) & write;
assign load_wrd_2 =  (addr == 12'h0ab) & write;

assign lfsr_ld_data_c[             31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[             31:0];           
assign lfsr_ld_data_c[            63:32] =  ( load_wrd_1  ) ? lfsrdin : lfsr_reg[            63:32];           
assign lfsr_ld_data_c[(POLY_WIDTH-1):64] =  ( load_wrd_2  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):64];           

assign lfsr_ld_c = ((load_wrd_0  | load_wrd_1 | load_wrd_2));   

assign temp_c[0] = {shift[(POLY_WIDTH-2):82],
                    shift[(POLY_WIDTH-1)]^shift[81],
                    shift[80:62],
                    shift[(POLY_WIDTH-1)]^shift[61],
                    shift[60:49],
                    shift[(POLY_WIDTH-1)]^shift[48],
                    shift[47:30],
                    shift[(POLY_WIDTH-1)]^shift[29],
                    shift[28:15],
                    shift[(POLY_WIDTH-1)]^shift[14],
                    shift[13:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[(NUM_OF_STEPS-1)] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg;

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter
   assign temp_c[i] = {temp_c[i-1][(POLY_WIDTH-2):82],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][81],
                       temp_c[i-1][80:62],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][61],
                       temp_c[i-1][60:49],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][48],
                       temp_c[i-1][47:30],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][29],
                       temp_c[i-1][28:15],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][14],
                       temp_c[i-1][13:0],
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
