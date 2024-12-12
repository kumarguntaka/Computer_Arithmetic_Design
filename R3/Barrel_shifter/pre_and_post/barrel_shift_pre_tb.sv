`timescale 1ns / 10ps

module barrel_shifter_multi_rev_testbench;
    logic [7:0] data;
    logic [2:0] amt;
    logic [7:0] out;
    logic dir_lr;

    barrel_shifter_multi_rev uut(.*);

    initial begin
        assign dir_lr = ROTATE_LEFT;
        for (byte i = 0; i < 8; ++i)
            begin
                data = 8'b0000_0001; amt = 3'(i); #10;
            end
        assign dir_lr = ROTATE_RIGHT;
        for (byte i = 0; i < 8; ++i)
            begin
                data = 8'b0000_0001; amt = 3'(i); #10;
            end
        $stop;
    end

endmodule