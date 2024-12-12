module black_cell(a,b,c,s,co,so);
input a,b,c,s;
output co,so;
wire w,w1,w2,w3;

nand (w,a,b);
xor (so,w,a,b);
and (w1,w,s);
and (w2,s,c);
and (w3,c,w1);
or (co,w1,w2,w3);

endmodule