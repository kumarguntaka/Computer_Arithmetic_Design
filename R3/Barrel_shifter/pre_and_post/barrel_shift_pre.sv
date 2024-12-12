`timescale 1ns / 10ps
const logic ROTATE_LEFT = 1'b1;
const logic ROTATE_RIGHT = 1'b0;

// Barrel Shifter using a Rotate-right-shifter with pre- and post-reversing circuits
module barrel_shifter_multi_rev(
    input logic [7:0] data,
    input logic [2:0] amt,
    input logic dir_lr, // 1 rotate left, 0 rotate right
    output logic [7:0] out
);
    logic [7:0] out_right; // output result
    logic [7:0] reversed_outr; // reversed output rotation for right rotation
    logic [7:0] reversed_data; // reversed input data for left rotation

    // if rotate left use rotated input data
    barrel_shifter_8_right bsr(.data((dir_lr == ROTATE_LEFT) ? reversed_data:data), .amt(amt) , .out(out_right));
    // reverse input circuit
    inverter_8 input_inverter(.data(data), .out(reversed_data));
    //  reverse output circuit
    inverter_8 output_inverter(.data(out_right), .out(reversed_outr));
    
     // if rotate right use rotated output  
    assign  out = (dir_lr == ROTATE_LEFT) ? reversed_outr:out_right;

endmodule

// reverse 8-bit data
module inverter_8(
    input logic [7:0] data,
    output logic [7:0] out
);
// reverse a vector using right-to-left streaming with the default block size of 1 bit 
  assign out = {<<{data}};  
endmodule
// rotates amt bits of data to the right
module barrel_shifter_8_right(
    input logic [7:0] data,
    input logic [2:0] amt,
    output logic [7:0] out
);

    logic [7:0] s0;
    logic [7:0] s1;
    //stage 0, shift 0 or 1 bit
    assign s0 =  amt[0]? {data[0], data[7:1]} :data ;
    //stage 1, shift 0 or 2 bits
    assign s1 =  amt[1]? {s0[1:0], s0[7:2]} :s0 ;
    //stage 1, shift 0 or 4 bits
    assign out = amt[2]?{s1[3:0], s1[7:4]} :s1;
endmodule