`timescale 1ns/10ps 
module primary_lfsr_10 #(
parameter POLY_WIDTH = 86,
parameter NUM_OF_STEPS = 14
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

wire        load_wrd_0;
wire        load_wrd_1;
wire        load_wrd_2;

assign shift = (enable | enable_d) ? lfsr_reg : 0;
assign dout = lfsr_reg;



assign load_wrd_0 =  (addr == 12'h0d4) & write;  
assign load_wrd_1 =  (addr == 12'h0d5) & write;
assign load_wrd_2 =  (addr == 12'h0d6) & write;  

assign lfsr_ld_data_c[31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[31:0];
assign lfsr_ld_data_c[63:32] =  ( load_wrd_1 ) ? lfsrdin : lfsr_reg[63:32];
assign lfsr_ld_data_c[(POLY_WIDTH-1):64] =  ( load_wrd_2  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):64];           


assign lfsr_ld_c = (load_wrd_0  | load_wrd_1 |
                    load_wrd_2 );


assign temp_c[0] = {shift[84:78],
                    shift[(POLY_WIDTH-1)]^shift[77],
                    shift[76:65],
                    shift[(POLY_WIDTH-1)]^shift[64],
                    shift[63:56],
                    shift[(POLY_WIDTH-1)]^shift[55],
                    shift[54:47],
                    shift[(POLY_WIDTH-1)]^shift[46],
                    shift[45:32],
                    shift[(POLY_WIDTH-1)]^shift[31],
                    shift[30:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[13] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter

   assign temp_c[i] = {temp_c[i-1][84:78],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][77],
                       temp_c[i-1][76:65],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][64],
                       temp_c[i-1][63:56],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][55],
                       temp_c[i-1][54:47],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][46],
                       temp_c[i-1][45:32],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][31],
                       temp_c[i-1][30:0],
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

