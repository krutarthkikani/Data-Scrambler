`timescale 1ns/10ps
module primary_lfsr_15 #(
parameter POLY_WIDTH = 64,
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

assign shift = (enable | enable_d) ? lfsr_reg : 0;
assign dout = lfsr_reg;



assign load_wrd_0 =  (addr == 12'h0f6) & write;  
assign load_wrd_1 =  (addr == 12'h0f7) & write;


assign lfsr_ld_data_c[31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[31:0];
assign lfsr_ld_data_c[(POLY_WIDTH-1):32] =  ( load_wrd_1  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):32];           



assign lfsr_ld_c = (load_wrd_0  | load_wrd_1 );


assign temp_c[0] = {shift[62:61],
                    shift[(POLY_WIDTH-1)]^shift[60],
                    shift[59:34],
                    shift[(POLY_WIDTH-1)]^shift[33],
                    shift[32:9],
                    shift[(POLY_WIDTH-1)]^shift[8],
                    shift[7:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[13] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter

   assign temp_c[i] = {temp_c[i-1][62:61],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][60],
                       temp_c[i-1][59:34],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][33],
                       temp_c[i-1][32:9],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][8],
                       temp_c[i-1][7:0],
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

