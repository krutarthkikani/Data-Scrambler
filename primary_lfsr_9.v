`timescale 1ns/10ps
module primary_lfsr_9 #(
parameter POLY_WIDTH = 127,
parameter NUM_OF_STEPS = 16
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

assign shift = (enable | enable_d) ? lfsr_reg : 0;
assign dout = lfsr_reg;


assign load_wrd_0 =  (addr == 12'h0cc) & write;  
assign load_wrd_1 =  (addr == 12'h0cd) & write;
assign load_wrd_2 =  (addr == 12'h0ce) & write;  
assign load_wrd_3 =  (addr == 12'h0cf) & write;


assign lfsr_ld_data_c[31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[31:0];
assign lfsr_ld_data_c[63:32] =  ( load_wrd_1 ) ? lfsrdin : lfsr_reg[63:32];
assign lfsr_ld_data_c[95:64] =  ( load_wrd_2 ) ? lfsrdin : lfsr_reg[95:64];
assign lfsr_ld_data_c[(POLY_WIDTH-1):96] =  ( load_wrd_3  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):96];           







assign lfsr_ld_c = (load_wrd_0  | load_wrd_1 |
                    load_wrd_2  | load_wrd_3 );
                    


assign temp_c[0] = {shift[125:54],
                    shift[(POLY_WIDTH-1)]^shift[53],
                    shift[52:45],
                    shift[(POLY_WIDTH-1)]^shift[44],
                    shift[43:13],
                    shift[(POLY_WIDTH-1)]^shift[12],
                    shift[11:0],
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[15] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter

   assign temp_c[i] = {temp_c[i-1][125:54],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][53],
                       temp_c[i-1][52:45],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][44],
                       temp_c[i-1][43:13],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][12],
                       temp_c[i-1][11:0],
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

