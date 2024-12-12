module bwm_n_tb();
reg [3:0] a, b; 
integer a_value, b_value;
wire [7:0] p; 
integer p_value; 
integer check; 
integer i, j; 
integer num_correct; 
integer num_wrong; 

bwm_n DUT(a, b, p);

initial begin

num_correct = 0; num_wrong = 0;

for (i = 0; i < 16; i = i + 1)
begin
a = i;
a_value = -a[3]*8 + a[2:0];
for (j = 0; j < 16; j = j + 1)
begin
b = j;
b_value = -b[3]*8 + b[2:0];
check = a_value * b_value;
#10 p_value = -p[7]*128 + p[6:0];
if (p_value == check)
num_correct = num_correct + 1;
else
num_wrong = num_wrong + 1;
$display(" %d * %d = %d", a_value, b_value, check);
end
end

$display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
end
endmodule