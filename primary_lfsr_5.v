`timescale 1ns/10ps
module primary_lfsr_5 #(
parameter POLY_WIDTH = 43,
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
wire load_wrd_0 ,load_wrd_1;

assign shift = (enable | enable_d) ? lfsr_reg : 'h00000000000;
assign dout = lfsr_reg;

assign load_wrd_0 =  (addr == 12'h0a4) & write;  
assign load_wrd_1 =  (addr == 12'h0a5) & write;

assign lfsr_ld_data_c[   31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[   31:0];           
assign lfsr_ld_data_c[(POLY_WIDTH-1):32] =  ( load_wrd_1  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):32];           

assign lfsr_ld_c = ((load_wrd_0  | load_wrd_1 ));   


assign temp_c[0] = {shift[41:35],
                    shift[(POLY_WIDTH-1)]^shift[34],
                    shift[33:32],
                    shift[(POLY_WIDTH-1)]^shift[31],
                    shift[30],
                    shift[(POLY_WIDTH-1)]^shift[29],
                    shift[28:25],
                    shift[(POLY_WIDTH-1)]^shift[24],
                    shift[23:8],
                    shift[(POLY_WIDTH-1)]^shift[7],
                    shift[6:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[14] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter
   assign temp_c[i] = {temp_c[i-1][41:35],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][34],
                       temp_c[i-1][33:32],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][31],
                       temp_c[i-1][30],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][29],
                       temp_c[i-1][28:25],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][24],
                       temp_c[i-1][23:8],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][7],
                       temp_c[i-1][6:0],
                       temp_c[i-1][(POLY_WIDTH-1)]};
  end
endgenerate

always @ ( posedge clk or posedge rst )
begin
  if (rst) 
  begin
    lfsr_reg     <= #1 43'h0000000000; 
    enable_d     <= #1 1'b0;
  end
  else
  begin
    enable_d <= #1 enable;
    lfsr_reg <= #1 lfsr_reg_c;
  end
end

endmodule
