`timescale 1ns / 10ps

module barrel_shifter_built_case(
    input logic [7:0] data,
    input logic [2:0] amt,
    output logic [7:0] out
);

    always_comb
    begin
        case (amt)
            3'o0: out = data;
            3'o1: out = {data[0], data[7:1]};
            3'o2: out = {data[1:0], data[7:2]};
            3'o3: out = {data[2:0], data[7:3]};
            3'o4: out = {data[3:0], data[7:4]};
            3'o5: out = {data[4:0], data[7:5]};
            3'o6: out = {data[5:0], data[7:6]};
            default  out = {data[6:0], data[7]};
        endcase
    end
endmodule