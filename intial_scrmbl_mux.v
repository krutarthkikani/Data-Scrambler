`timescale 1ns/10ps
module intial_scrmbl_mux(
input [7:0]   data,
input [31:0]  entrophy,
input  [63:0] data_sel_i,
output [31:0] data_pls_entr_o
);

wire  [4:0] slction_code;
reg  [31:0] data_pls_entr;
wire [31:0] e;

assign slction_code = { data_sel_i[55],
                        data_sel_i[33],
                        data_sel_i[54],
                        data_sel_i[35],
                        data_sel_i[45] };

assign e = entrophy;

assign data_pls_entr_o = data_pls_entr;

always @ (*)
begin
 case (slction_code)
  0  : data_pls_entr = {e[17],e[13],e[21],e[26],data[2],e[14],e[11],e[20],e[27],e[25],e[19],e[28],e[1],data[1],e[7],e[18],data[4],data[3],e[22],e[29],e[30],e[15],data[0],e[16],e[3],e[23],data[5],e[31],data[6],e[12],data[7],e[8]};
  1  : data_pls_entr = {e[3],e[1],e[26],e[17],data[4],e[8],data[5],e[14],data[3],e[20],e[27],data[1],data[0],e[12],data[2],e[0],e[18],e[13],e[23],e[4],e[9],e[6],data[6],e[16],e[7],e[15],data[7],e[28],e[22],e[24],e[5],e[31]};
  2  : data_pls_entr = {e[13],e[10],e[11],data[3],data[2],e[23],e[18],e[17],e[15],e[6],data[4],data[6],e[19],e[20],e[5],e[4],e[30],e[28],data[5],e[22],e[9],e[7],e[25],e[2],e[31],data[7],e[24],data[1],data[0],e[8],e[21],e[29]};
  3  : data_pls_entr = {e[23],e[19],e[26],e[16],e[18],e[12],data[6],e[5],data[2],e[29],e[24],data[5],e[3],e[20],e[30],e[28],e[0],e[21],e[9],e[27],data[0],data[3],data[1],data[7],e[14],data[4],e[6],e[22],e[15],e[10],e[11],e[2]};
  4  : data_pls_entr = {e[11],e[20],data[4],e[15],e[0],data[0],e[8],e[7],e[23],data[6],e[17],data[7],data[2],e[24],e[28],e[3],data[5],e[16],e[25],e[21],e[22],e[1],data[1],e[4],e[30],data[3],e[19],e[10],e[26],e[27],e[31],e[6]};
  5  : data_pls_entr = {data[4],data[3],data[0],data[2],e[12],e[5],e[1],e[10],data[6],e[3],e[23],e[18],e[22],e[0],data[1],e[21],e[2],data[7],e[25],e[8],e[24],e[30],e[6],e[27],e[9],e[7],data[5],e[20],e[26],e[11],e[15],e[16]};
  6  : data_pls_entr = {e[15],data[6],data[4],e[4],e[1],e[3],e[30],data[5],data[3],e[7],e[19],e[27],e[16],data[0],data[7],e[25],e[28],e[24],e[26],e[6],e[11],data[2],e[20],e[5],e[17],e[0],e[18],e[31],data[1],e[23],e[14],e[8]};
  7  : data_pls_entr = {e[7],e[28],e[19],e[8],e[29],e[6],e[11],e[21],e[15],e[27],e[2],data[3],e[9],e[16],data[4],e[26],e[17],data[1],data[7],data[6],data[2],e[10],data[5],e[12],e[24],e[14],e[5],e[23],e[3],e[30],data[0],e[25]};
  8  : data_pls_entr = {e[4],e[22],e[15],e[31],e[25],e[27],e[18],e[1],data[7],e[13],data[6],e[21],e[11],data[2],e[0],e[2],e[19],e[12],e[17],e[28],data[0],data[1],e[9],e[24],data[4],e[30],e[26],data[3],e[3],data[5],e[23],e[8]};
  9  : data_pls_entr = {e[7],e[19],data[1],e[14],e[15],e[24],data[0],data[6],data[2],e[9],e[16],e[27],data[5],data[7],e[10],e[20],e[17],e[2],e[12],e[25],e[28],e[13],e[8],e[21],e[31],data[4],e[1],e[6],e[18],data[3],e[3],e[30]};
  10 : data_pls_entr = {e[4],data[0],e[31],e[10],e[24],e[15],data[4],e[0],data[6],e[23],e[11],data[7],e[22],e[9],e[20],e[28],e[21],data[1],data[2],e[12],e[19],data[5],e[5],data[3],e[2],e[1],e[7],e[30],e[3],e[26],e[17],e[14]};
  11 : data_pls_entr = {e[11],e[18],e[0],e[9],data[6],e[6],data[3],data[4],e[5],e[26],e[12],e[17],e[1],e[20],e[22],e[4],e[21],e[7],e[28],data[7],e[31],e[15],data[2],e[8],e[10],e[30],data[1],data[0],data[5],e[27],e[16],e[2]};
  12 : data_pls_entr = {e[18],e[19],data[3],e[12],e[1],e[13],e[8],e[10],e[30],e[5],e[9],data[4],e[6],e[4],e[0],e[31],e[11],data[1],e[24],data[2],e[27],data[7],e[20],e[29],data[6],e[3],data[5],e[21],e[15],data[0],e[28],e[17]};
  13 : data_pls_entr = {e[25],e[9],e[26],data[5],data[6],e[5],e[16],e[24],e[1],e[31],e[8],e[15],data[7],data[0],e[14],e[13],e[10],e[29],e[17],data[2],e[20],e[2],data[4],e[18],data[1],e[11],data[3],e[12],e[28],e[21],e[7],e[19]};
  14 : data_pls_entr = {e[28],e[1],e[19],e[14],data[6],e[24],data[1],e[3],e[11],e[6],e[22],e[10],e[18],data[0],e[16],e[31],e[25],e[9],e[20],e[8],data[2],e[12],data[5],e[29],e[21],e[15],data[7],data[3],e[27],e[26],data[4],e[30]};
  15 : data_pls_entr = {e[2],e[16],e[31],e[8],e[25],e[23],data[1],e[19],data[3],data[6],e[5],e[28],e[7],e[12],e[17],e[10],data[7],e[9],e[24],data[5],e[1],e[30],e[13],e[21],data[2],e[22],data[4],e[26],e[11],data[0],e[6],e[20]};
  16 : data_pls_entr = {data[7],e[15],e[19],e[31],e[12],data[0],e[23],e[17],e[29],e[26],e[20],e[1],e[10],data[1],e[14],e[8],data[6],data[4],e[18],e[22],e[13],data[2],e[3],e[4],e[11],e[27],data[5],data[3],e[9],e[30],e[2],e[5]};
  17 : data_pls_entr = {e[14],e[10],e[13],e[8],e[7],e[27],e[16],e[25],e[3],data[0],data[2],e[1],e[11],e[20],e[24],data[6],e[19],e[28],e[5],data[4],data[7],e[12],e[15],e[4],data[1],e[31],e[30],data[3],e[17],e[22],data[5],e[18]};
  18 : data_pls_entr = {e[30],e[9],data[5],data[7],e[12],e[1],e[22],data[1],e[20],e[3],e[29],data[4],data[6],e[2],data[2],e[10],e[15],data[0],e[25],e[7],e[14],e[18],e[17],e[11],e[6],data[3],e[31],e[24],e[13],e[26],e[27],e[16]};
  19 : data_pls_entr = {data[6],e[22],e[7],data[0],e[11],data[4],data[5],data[7],data[2],e[2],e[21],e[17],e[26],e[19],e[18],e[8],e[0],e[4],e[28],e[14],e[12],data[3],e[24],e[15],e[27],data[1],e[30],e[25],e[1],e[31],e[5],e[20]};
  20 : data_pls_entr = {e[2],e[17],e[27],e[14],data[6],data[7],e[12],e[21],data[2],e[13],e[29],e[10],e[4],e[5],e[7],e[22],e[3],e[24],e[9],e[11],data[0],data[3],data[5],e[8],e[25],data[1],e[28],data[4],e[19],e[1],e[16],e[26]};
  21 : data_pls_entr = {e[28],e[21],data[2],e[10],e[3],e[27],e[17],data[0],e[0],data[3],e[7],data[1],e[5],e[18],data[7],e[31],e[6],e[29],e[24],e[16],data[6],e[22],e[26],e[19],data[5],data[4],e[14],e[12],e[25],e[1],e[15],e[8]};
  22 : data_pls_entr = {e[23],e[22],e[2],data[3],e[13],e[12],e[19],e[15],e[4],e[7],e[27],e[16],data[7],e[24],e[0],e[1],e[5],e[20],e[31],data[4],e[6],data[1],e[21],data[5],data[6],e[25],data[0],e[3],data[2],e[28],e[10],e[29]};
  23 : data_pls_entr = {e[21],e[13],data[3],e[6],data[2],e[26],e[4],e[7],e[19],e[8],data[5],e[14],e[20],e[2],data[1],e[27],e[12],e[3],data[4],e[25],data[7],data[0],e[15],e[10],e[30],e[24],data[6],e[5],e[22],e[17],e[18],e[11]};
  24 : data_pls_entr = {e[19],e[25],e[6],e[3],e[26],e[21],data[6],e[17],e[30],data[5],e[7],e[11],e[8],data[7],e[23],data[2],data[4],e[5],e[24],e[29],e[31],e[4],e[22],data[1],e[14],e[12],e[2],e[13],data[0],e[28],e[1],data[3]};
  25 : data_pls_entr = {data[4],e[7],e[19],data[3],data[2],e[14],e[22],e[12],e[30],e[23],e[3],e[15],e[18],e[8],e[29],e[2],e[6],e[20],data[6],e[11],e[0],data[1],e[5],e[26],data[5],e[25],data[0],e[27],e[31],e[16],e[9],data[7]};
  26 : data_pls_entr = {data[1],e[23],e[24],e[19],data[7],e[18],e[3],e[4],e[15],data[3],e[1],e[13],e[31],e[6],e[11],e[20],e[5],data[0],data[2],e[22],e[25],data[6],e[14],e[16],data[5],e[28],e[26],e[10],e[21],e[30],data[4],e[2]};
  27 : data_pls_entr = {e[8],e[5],data[1],data[7],e[21],e[19],e[25],e[10],e[15],data[0],data[5],e[31],e[4],e[17],e[24],e[6],e[30],e[12],data[3],data[2],e[7],data[6],e[14],e[11],e[0],data[4],e[13],e[29],e[28],e[9],e[22],e[3]};
  28 : data_pls_entr = {e[14],e[20],e[28],e[26],data[3],e[27],e[19],e[9],e[25],e[17],e[12],data[0],e[0],e[8],e[13],e[2],data[6],data[1],e[31],e[5],e[16],e[22],e[3],e[18],data[4],data[5],data[2],data[7],e[21],e[29],e[1],e[30]};
  29 : data_pls_entr = {e[24],e[9],e[1],e[26],data[5],data[3],e[29],e[5],e[6],e[31],e[30],data[1],e[28],e[3],e[11],e[21],data[7],e[0],e[20],e[4],e[27],data[0],e[22],e[7],e[25],data[6],e[15],data[2],e[8],e[2],e[18],data[4]};
  30 : data_pls_entr = {e[22],e[4],e[12],e[17],data[0],e[20],data[2],e[13],e[11],e[7],e[5],e[18],e[3],data[1],e[16],data[6],data[4],e[25],data[3],e[2],data[7],e[28],e[24],e[15],e[26],e[19],data[5],e[1],e[27],e[10],e[8],e[29]};
  31 : data_pls_entr = {e[30],e[3],e[24],e[0],e[8],e[6],e[4],e[1],data[4],e[5],e[7],e[11],e[31],data[2],e[22],e[10],e[28],e[9],e[25],e[26],e[23],data[7],data[3],e[29],data[5],e[2],data[0],data[6],data[1],e[18],e[13],e[27] };

endcase
end

endmodule
