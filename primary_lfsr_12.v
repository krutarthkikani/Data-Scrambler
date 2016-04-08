`timescale 1ns/10ps
module primary_lfsr_12 #(
parameter POLY_WIDTH = 212,
parameter NUM_OF_STEPS = 12
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
wire        load_wrd_3;
wire        load_wrd_4;
wire        load_wrd_5;
wire        load_wrd_6;

assign shift = (enable | enable_d) ? lfsr_reg : 0;
assign dout = lfsr_reg;



assign load_wrd_0 =  (addr == 12'h0de) & write;  
assign load_wrd_1 =  (addr == 12'h0df) & write;
assign load_wrd_2 =  (addr == 12'h0e0) & write;  
assign load_wrd_3 =  (addr == 12'h0e1) & write;
assign load_wrd_4 =  (addr == 12'h0e2) & write;  
assign load_wrd_5 =  (addr == 12'h0e3) & write;
assign load_wrd_6 =  (addr == 12'h0e4) & write;



assign lfsr_ld_data_c[31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[31:0];
assign lfsr_ld_data_c[63:32] =  ( load_wrd_1 ) ? lfsrdin : lfsr_reg[63:32];
assign lfsr_ld_data_c[95:64] =  ( load_wrd_2 ) ? lfsrdin : lfsr_reg[95:64];
assign lfsr_ld_data_c[127:96] =  ( load_wrd_3 ) ? lfsrdin : lfsr_reg[127:96];
assign lfsr_ld_data_c[159:128] =  ( load_wrd_4 ) ? lfsrdin : lfsr_reg[159:128];
assign lfsr_ld_data_c[191:160] =  ( load_wrd_5 ) ? lfsrdin : lfsr_reg[191:160];
assign lfsr_ld_data_c[(POLY_WIDTH-1):192] =  ( load_wrd_6  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):192];           







assign lfsr_ld_c = (load_wrd_0  | load_wrd_1 |
                    load_wrd_2  | load_wrd_3 |
                    load_wrd_4  | load_wrd_5 |
                    load_wrd_6 );


assign temp_c[0] = {shift[210:181],
                    shift[(POLY_WIDTH-1)]^shift[180],
                    shift[179:158],
                    shift[(POLY_WIDTH-1)]^shift[157],
                    shift[156:127],
                    shift[(POLY_WIDTH-1)]^shift[126],
                    shift[125:92],
                    shift[(POLY_WIDTH-1)]^shift[91],
                    shift[90:83],
                    shift[(POLY_WIDTH-1)]^shift[82],
                    shift[81:0],                    
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[11] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter

   assign temp_c[i] = {temp_c[i-1][210:181],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][180],
                       temp_c[i-1][179:158],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][157],
                       temp_c[i-1][156:127],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][126],
                       temp_c[i-1][125:92],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][91],
                       temp_c[i-1][90:83],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][82],
                       temp_c[i-1][81:0],
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

