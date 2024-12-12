 `timescale 1ns / 10ps

module barrel_shifter_built_case_testbench;
    logic [7:0] data;
    logic [2:0] amt;
    logic [7:0] out;

    barrel_shifter_built_case uut(.*);

    initial begin
        for (byte i = 0; i < 8; ++i)
            begin
                data = 8'b0110_1010; amt = 3'(i); #10;
            end
        $stop;
    end

endmodule