`timescale 1ns / 1ps
const logic ROTATE_LEFT = 1'b1;
const logic ROTATE_RIGHT = 1'b0;
// The width of input will be 2^N  ie N=5 width 32
module barrel_shifter_N #(parameter N=4) (
    input logic [2**N-1:0] data,
    input logic [N-1:0] amt,
    input logic dir_lr, // 1 rotate left, 0 rotate right
    output logic [2**N-1:0] out
);
    localparam WIDTH = 2**N;
    logic [WIDTH-1:0] out_right;
    logic [WIDTH-1:0] reversed_outr;
    logic [WIDTH-1:0] reversed_data;

    barrel_shifter_N_right #(.N(N)) bsr(.data((dir_lr == ROTATE_LEFT) ? reversed_data:data), .amt(amt) , .out(out_right));

    // reverse input circuit
    inverter_width #(.WIDTH(WIDTH)) input_inverter(.data(data), .out(reversed_data));
    //  reverse output circuit
    inverter_width #(.WIDTH(WIDTH))output_inverter(.data(out_right), .out(reversed_outr));

    // if rotate right use rotated output  
    assign  out = (dir_lr == ROTATE_LEFT) ? reversed_outr:out_right;

endmodule

// rotates amt bits of data to the right staged implementation
//
module barrel_shifter_N_right #(parameter N = 4)(
    input logic [2**N-1:0] data,
    input logic [N-1:0] amt,
    output logic [2**N-1:0] out
);

    localparam WIDTH = 2**N;
    logic  [N-1:0][WIDTH-1:0] stage_out;

    generate
        genvar  stage ;
        assign stage_out[0] = amt[0] ? { data[0], data[WIDTH-1:1]} : data;
        for (stage = 1; stage < N ; ++stage)
        begin
            assign stage_out[stage] = amt[stage] ?
                {stage_out[stage-1][stage**2:0], stage_out[stage-1][WIDTH-1:2**stage]}
                : stage_out[stage -1];
        end
        assign out = stage_out[N-1];
    endgenerate

endmodule

// reverse 32-bit data
module inverter_width #(parameter WIDTH=32) (
    input logic [WIDTH-1:0] data,
    output logic [WIDTH-1:0] out
);
    // reverse a vector using right-to-left streaming with the default block size of 1 bit 
    assign out = {<<{data}};
endmodule

