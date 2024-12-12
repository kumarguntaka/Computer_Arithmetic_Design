module test_multiply;
 
  parameter A_WIDTH=16, B_WIDTH=16;
  
  reg i_clk;
  reg i_reset;
  reg i_ce;
  reg signed[(A_WIDTH-1):0] i_a;
  reg signed[(B_WIDTH-1):0] i_b;
  wire signed[(A_WIDTH+B_WIDTH-1):0]    o_p;
  wire o_valid;
  
  // Instantiate design under test
  multiply mul(.clk(i_clk), .reset(i_reset), .in_valid(i_ce), .in_A(i_a), .in_B(i_b), .out_valid(o_valid), .out_C(o_p));
          
  initial begin
    // Dump waves
    $dumpfile("test_multiply.vcd");
    $dumpvars(0, test_multiply);
    
    $display("Reset flop.");
    i_clk = 0;
    i_reset = 0;
    i_ce = 0;
    i_a = 0;
    i_b = 0;
 
  end
always #5 i_clk = !i_clk;
 
  initial begin
    
    @(posedge i_clk);
    @(posedge i_clk);
 
    i_reset = 1;
 
    @(posedge i_clk);
    @(posedge i_clk);
    
    i_reset = 0;
 
    @(posedge i_clk);
    @(posedge i_clk);
 
    i_ce = 1;
    i_a = 16'h8;
    i_b = 16'h7;
 
 
    #400 $finish;
 
  end
  
endmodule