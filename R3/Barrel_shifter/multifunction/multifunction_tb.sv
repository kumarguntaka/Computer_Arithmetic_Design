`timescale 1ns / 1ps

module barrel_shifter_N_tb;

const logic ROTATE_LEFT = 1'b1;
const logic ROTATE_RIGHT = 1'b0;
    localparam N = 8;
    localparam WIDTH = 2**N;
    
    logic [WIDTH-1:0] data;
    logic [N-1:0] amt;
    logic [WIDTH-1:0] out;
    logic dir_lr;

    barrel_shifter_N #(.N(N)) dut(.*);

    initial begin
        for (int i = 0; i < WIDTH; ++i)
            begin
                data = 16; 
				amt = i; 
				dir_lr = ROTATE_LEFT; 
				#10;
            end
        for (int i = 0; i < WIDTH; ++i)
            begin
                data = 16; 
				amt =i; 
				dir_lr = ROTATE_RIGHT;  
				#10;
            end
        $stop;
    end

endmodule