module black_cell(a,b,c,s,co,so);
input a,b,c,s;
output co,so;

assign so = ((~(a&b))^c^s);
assign co = ((~(a&b))&c)|((~(a&b))&s)|(s&c);

endmodule