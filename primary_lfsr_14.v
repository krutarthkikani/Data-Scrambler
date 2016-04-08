`timescale 1ns/10ps
module primary_lfsr_14 #(
parameter POLY_WIDTH = 147,
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

assign shift = (enable | enable_d) ? lfsr_reg : 0;
assign dout = lfsr_reg;



assign load_wrd_0 =  (addr == 12'h0f0) & write;  
assign load_wrd_1 =  (addr == 12'h0f1) & write;
assign load_wrd_2 =  (addr == 12'h0f2) & write;  
assign load_wrd_3 =  (addr == 12'h0f3) & write;
assign load_wrd_4 =  (addr == 12'h0f4) & write;  



assign lfsr_ld_data_c[31:0] =  ( load_wrd_0  ) ? lfsrdin : lfsr_reg[31:0];
assign lfsr_ld_data_c[63:32] =  ( load_wrd_1 ) ? lfsrdin : lfsr_reg[63:32];
assign lfsr_ld_data_c[95:64] =  ( load_wrd_2 ) ? lfsrdin : lfsr_reg[95:64];
assign lfsr_ld_data_c[127:96] =  ( load_wrd_3 ) ? lfsrdin : lfsr_reg[127:96];
assign lfsr_ld_data_c[(POLY_WIDTH-1):128] =  ( load_wrd_4  ) ? lfsrdin : lfsr_reg[(POLY_WIDTH-1):128];           







assign lfsr_ld_c = (load_wrd_0  | load_wrd_1 |
                    load_wrd_2  | load_wrd_3 |
                    load_wrd_4);


assign temp_c[0] = {shift[145:110],
                    shift[(POLY_WIDTH-1)]^shift[109],
                    shift[108:89],
                    shift[(POLY_WIDTH-1)]^shift[88],
                    shift[87:43],
                    shift[(POLY_WIDTH-1)]^shift[42],
                    shift[41:0],                    
                    shift[(POLY_WIDTH-1)]};

assign lfsr_reg_c = (enable) ? temp_c[11] : (lfsr_ld_c) ? lfsr_ld_data_c : lfsr_reg; 

genvar i;

generate
  for (i=1; i<=(NUM_OF_STEPS-1); i=i+1) begin:shifter

   assign temp_c[i] = {temp_c[i-1][145:110],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][109],
                       temp_c[i-1][108:89],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][88],
                       temp_c[i-1][87:43],
                       temp_c[i-1][(POLY_WIDTH-1)]^temp_c[i-1][42],
                       temp_c[i-1][41:0],
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

