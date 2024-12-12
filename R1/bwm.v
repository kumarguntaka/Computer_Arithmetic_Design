// half adder
module half_adder(a, b, s, cout);
input a, b;
output s, cout;
assign s = a^b;
assign cout = a&b;
endmodule

// full adder
module full_adder(a, b, cin, s, cout);
input a, b, cin;
output s, cout;
assign s = a^b^cin;
assign cout = (a&b) | (b&cin) | (a&cin);
endmodule

// 4-bit by 4-bit Baugh-Wooley signed multiplier
module bwm(x, y, p);
input [3:0] x, y;
output [5:0] p;
supply1 one;

wire [23:0]t;

assign p[0] = x[0]&y[0];
half_adder ha1(x[1]&y[0], x[0]&y[1], p[1], t[1]);
half_adder ha2(x[2]&y[0], x[1]&y[1], t[2], t[3]);
full_adder fa1(t[2], t[1], x[0]&y[2], p[2], t[4]);
half_adder ha3(x[3]&~y[0], x[2]&y[1], t[5], t[6]);
full_adder fa2(t[5], t[3], x[1]&y[2], t[7], t[8]);
full_adder fa3(t[7], t[4], ~x[0]&y[3], t[9], t[10]);
full_adder fa4(t[9], x[3], y[3], p[3], t[11]);
full_adder fa5(x[3]&~y[1], t[6], x[2]&y[2], t[12], t[13]);
full_adder fa6(t[12], t[8], ~x[1]&y[3], t[14], t[15]);
full_adder fa7(t[14], t[10], t[11], p[4], t[16]);
full_adder fa8(x[3]&~y[2], t[13], ~x[2]&y[3], t[17], t[18]);
full_adder fa9(t[17], t[15], t[16], p[5], t[19]);
full_adder fa10(~x[3], ~y[3], x[3]&y[3], t20, t21);
full_adder fa11(t20, t18, t19, p[6], t22);
full_adder fa12(one, t21, t22, p[7], t23);
endmodule
