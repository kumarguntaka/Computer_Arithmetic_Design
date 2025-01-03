module bwm_n(a,b,p);
input [3:0] a, b;
output [7:0] p;

wire [28:0]t;

white_cell w0(a[1],b[0],1'b0,1'b0,t[28],p[0]); //p0
white_cell w1(a[1],b[0],1'b0,1'b0,t[0],t[1]);
white_cell w2(a[0],b[1],t[28],t[1],t[3],p[1]);//p1
white_cell w3(a[2],b[0],1'b0,1'b0,t[4],t[5]);
white_cell w4(a[1],b[1],t[0],t[5],t[6],t[7]);
white_cell w5(a[0],b[2],t[3],t[7],t[8],p[2]);//p2
black_cell b1(a[3],b[0],1'b0,1'b0,t[9],t[10]);
white_cell w6(a[2],b[1],t[4],t[10],t[11],t[12]);
white_cell w7(a[1],b[2],t[6],t[12],t[13],t[14]);
black_cell b2(a[0],b[3],t[8],t[14],t[15],p[3]);//p3
black_cell b3(a[3],b[1],t[9],1'b0,t[16],t[17]);
white_cell w8(a[2],b[2],t[11],t[17],t[18],t[19]);
black_cell b4(a[1],b[3],t[13],t[19],t[20],t[21]);
fulladder  fa1(1'b1,t[15],t[21],p[4]);  //p4
black_cell b5(a[3],b[2],t[16],1'b0,t[22],t[23]);
black_cell b6(a[2],b[3],t[18],t[23],t[24],t[25]);
fulladder fa2(1'b1,t[20],t[25],p[5]); //p5
white_cell w9(a[3],b[3],t[22],1'b0,t[26],t[27]);
fulladder fa3(1'b1,t[24],t[27],p[6]); //p6
fulladder fa4(1'b1,t[26],1'b1,p[7]); //p7

endmodule