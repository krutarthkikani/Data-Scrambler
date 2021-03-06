`timescale 1ns/10ps
module poly_select_mux(
input   [95:0] p0,
input  [300:0] p1,
input  [284:0] p2,
input  [346:0] p3,
input   [33:0] p4,
input   [42:0] p5,
input   [83:0] p6,
input  [341:0] p7,
input  [527:0] p8,
input  [126:0] p9,
input   [85:0] p10,
input   [72:0] p11,
input  [211:0] p12,
input  [194:0] p13,
input  [146:0] p14,
input   [63:0] p15,
input   [63:0] data_sel_to_poly_mux,
output  [15:0] data_out
);


wire  [4:0] slction_code;
reg  [15:0] poly_sel;

assign slction_code = { data_sel_to_poly_mux[19],
                        data_sel_to_poly_mux[59],
                        data_sel_to_poly_mux[13],
                        data_sel_to_poly_mux[24],
                        data_sel_to_poly_mux[49] };

assign data_out = poly_sel;

always @ (*)
begin
 case (slction_code)
  0 : poly_sel = {p8[0],p2[36],p4[16],p11[13],p5[8],p1[200],p10[58],p3[61],p13[51],p14[96],p9[111],p7[101],p15[12],p6[71],p12[122],p0[58]};
  1 : poly_sel = {p11[61],p6[82],p3[87],p0[14],p5[30],p1[3],p4[20],p13[171],p7[93],p9[15],p8[148],p12[12],p14[75],p2[178],p10[57],p15[38]};
  2 : poly_sel = {p6[36],p5[9],p14[93],p0[48],p4[5],p2[107],p7[118],p1[146],p11[51],p15[30],p10[26],p3[184],p12[182],p13[29],p8[461],p9[92]};
  3 : poly_sel = {p8[456],p13[92],p2[37],p1[88],p12[35],p9[27],p10[17],p15[51],p0[16],p7[121],p5[22],p6[60],p3[239],p14[145],p4[23],p11[27]};
  4 : poly_sel = {p4[26],p9[77],p11[16],p0[65],p5[17],p12[63],p7[298],p8[62],p10[7],p2[184],p14[35],p3[13],p1[252],p6[46],p15[60],p13[145]};
  5 : poly_sel = {p7[9],p2[269],p4[4],p14[64],p1[61],p9[14],p8[375],p15[45],p0[7],p6[30],p10[20],p3[110],p5[26],p11[26],p13[113],p12[16]};
  6 : poly_sel = {p13[67],p10[51],p0[74],p9[1],p5[3],p11[59],p1[147],p12[211],p14[47],p4[17],p3[20],p6[3],p2[202],p15[32],p8[495],p7[274]};
  7 : poly_sel = {p2[95],p9[6],p11[49],p10[40],p4[10],p5[29],p14[95],p0[63],p1[16],p8[319],p15[33],p12[198],p6[83],p7[256],p13[8],p3[66]};
  8 : poly_sel = {p10[31],p1[239],p15[7],p7[56],p12[206],p2[222],p5[41],p9[49],p8[31],p4[21],p6[48],p3[117],p14[74],p11[53],p13[188],p0[50]};
  9 : poly_sel = {p2[231],p15[50],p6[44],p3[55],p7[164],p13[46],p0[44],p14[6],p8[106],p12[104],p11[22],p4[3],p10[9],p9[48],p1[167],p5[10]};
  10: poly_sel = {p9[107],p12[164],p4[12],p0[94],p6[9],p15[54],p14[113],p3[219],p5[11],p1[170],p2[129],p8[76],p7[52],p11[24],p13[87],p10[68]};
  11: poly_sel = {p10[35],p0[82],p2[128],p4[6],p9[31],p11[32],p1[199],p8[513],p12[105],p15[49],p14[126],p3[253],p6[5],p7[193],p13[43],p5[36]};
  12: poly_sel = {p14[25],p15[46],p8[358],p4[28],p1[130],p6[41],p5[18],p13[186],p0[33],p12[201],p9[9],p11[28],p10[30],p7[334],p3[275],p2[116]};
  13: poly_sel = {p7[8],p4[13],p13[70],p1[185],p3[212],p0[54],p6[47],p11[43],p15[19],p8[80],p9[36],p14[73],p10[59],p12[36],p2[181],p5[2]};
  14: poly_sel = {p3[272],p11[52],p10[0],p14[85],p5[1],p12[183],p15[16],p1[194],p2[40],p7[74],p6[37],p8[341],p0[91],p4[11],p9[33],p13[105]};
  15: poly_sel = {p6[14],p14[84],p13[175],p1[293],p3[102],p7[322],p4[15],p9[24],p5[13],p11[47],p12[94],p8[489],p10[70],p2[67],p15[44],p0[51]};
  16: poly_sel = {p5[6],p13[47],p10[66],p3[7],p6[31],p14[140],p7[191],p11[8],p0[40],p15[35],p4[32],p9[53],p1[122],p2[194],p12[24],p8[500]};
  17: poly_sel = {p1[255],p11[10],p13[54],p9[20],p6[16],p2[16],p3[271],p8[175],p7[168],p12[98],p14[112],p0[86],p4[1],p15[29],p10[3],p5[42]};
  18: poly_sel = {p4[25],p9[99],p8[139],p2[0],p15[24],p11[0],p3[151],p5[0],p6[54],p10[65],p1[219],p14[101],p12[142],p0[42],p13[63],p7[126]};
  19: poly_sel = {p3[18],p2[19],p14[9],p1[183],p15[28],p11[9],p6[51],p13[97],p5[14],p4[2],p12[93],p8[301],p9[68],p0[83],p7[317],p10[15]};
  20: poly_sel = {p8[277],p6[0],p13[39],p15[11],p2[154],p12[185],p4[30],p10[82],p0[10],p3[105],p1[139],p11[57],p14[133],p9[79],p5[35],p7[21]};
  21: poly_sel = {p6[53],p11[54],p13[28],p1[220],p15[1],p0[88],p5[37],p3[277],p14[15],p12[0],p10[69],p7[303],p8[369],p2[104],p9[61],p4[31]};
  22: poly_sel = {p3[285],p11[46],p8[120],p10[8],p2[47],p4[27],p15[40],p5[38],p0[90],p9[30],p6[29],p13[5],p12[178],p1[73],p7[100],p14[16]};
  23: poly_sel = {p7[231],p2[244],p4[8],p15[25],p0[34],p1[263],p5[25],p11[31],p12[168],p9[45],p3[335],p8[210],p6[62],p14[12],p10[83],p13[149]};
  24: poly_sel = {p8[110],p9[110],p5[21],p0[57],p1[291],p15[23],p2[103],p13[96],p10[67],p11[3],p6[35],p3[278],p14[8],p12[167],p7[297],p4[14]};
  25: poly_sel = {p3[257],p13[122],p8[131],p2[234],p14[60],p10[4],p1[94],p9[26],p15[61],p5[34],p6[2],p4[33],p0[81],p12[174],p7[300],p11[33]};
  26: poly_sel = {p5[5],p6[58],p13[34],p11[14],p4[18],p9[80],p14[51],p8[404],p12[121],p1[85],p15[0],p3[127],p10[76],p2[199],p7[229],p0[52]};
  27: poly_sel = {p13[111],p12[106],p8[458],p0[66],p1[300],p15[63],p2[211],p11[30],p6[56],p7[210],p4[19],p14[0],p10[53],p3[162],p5[24],p9[104]};
  28: poly_sel = {p0[6],p7[299],p8[484],p11[69],p1[22],p15[53],p12[146],p14[103],p4[7],p13[89],p2[180],p5[28],p9[43],p6[7],p3[136],p10[22]};
  29: poly_sel = {p7[160],p8[520],p3[143],p10[12],p11[67],p9[91],p12[64],p4[0],p13[187],p2[52],p15[13],p6[23],p1[251],p14[131],p0[3],p5[40]};
  30: poly_sel = {p12[43],p9[112],p10[73],p15[34],p0[5],p8[22],p5[31],p14[78],p3[317],p11[19],p4[24],p2[263],p7[166],p13[74],p1[210],p6[13]};
  31: poly_sel = {p6[15],p2[100],p13[117],p11[55],p12[4],p14[118],p9[120],p10[56],p7[331],p4[22],p15[6],p8[256],p5[12],p3[224],p1[187],p0[38]};
 endcase
end

endmodule
