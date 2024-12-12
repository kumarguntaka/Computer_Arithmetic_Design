module baugh_mult #(parameter A_WIDTH=16, B_WIDTH=16)
(clk, reset, in_valid, out_valid, in_A, in_B, out_C); // C=A*B

`ifdef FORMAL
parameter A_WIDTH = 4;
parameter B_WIDTH = 4;
`endif

input clk, reset;
input in_valid; // to signify that in_A, in_B are valid, multiplication process can start
input signed [(A_WIDTH-1):0] in_A;
input signed [(B_WIDTH-1):0] in_B;
output signed [(A_WIDTH+B_WIDTH-1):0] out_C;
output reg out_valid;

localparam SMALLER_WIDTH = (A_WIDTH <= B_WIDTH) ? A_WIDTH : B_WIDTH;
localparam LARGER_WIDTH = (A_WIDTH > B_WIDTH) ? A_WIDTH : B_WIDTH;

wire [(LARGER_WIDTH-1):0] MULTIPLICAND = (A_WIDTH > B_WIDTH) ? in_A : in_B ;
wire [(SMALLER_WIDTH-1):0] MULTIPLIPLIER = (A_WIDTH <= B_WIDTH) ? in_A : in_B ;

`ifdef FORMAL
// to keep the values of multiplicand and multiplier before the multiplication finishes 
reg [(LARGER_WIDTH-1):0] MULTIPLICAND_reg;
reg [(SMALLER_WIDTH-1):0] MULTIPLIPLIER_reg;

always @(posedge clk)
begin
    if(reset) begin
        MULTIPLICAND_reg <= 0;
        MULTIPLIPLIER_reg <= 0;
    end

    else if(in_valid) begin
        MULTIPLICAND_reg <= MULTIPLICAND;
        MULTIPLIPLIER_reg <= MULTIPLIPLIER;
    end
end
`endif

localparam NUM_OF_INTERMEDIATE_LAYERS = $clog2(SMALLER_WIDTH);

generate // duplicates the leafs of the binary tree

    genvar layer; // layer 0 means the youngest leaf, layer N means the tree trunk

    for(layer=0; layer<NUM_OF_INTERMEDIATE_LAYERS; layer=layer+1) begin: intermediate_layers

        integer pp_index; // leaf index within each layer of the tree
        integer bit_index; // index of binary string within each leaf

        always @(posedge clk)
        begin
            if(reset) 
            begin
                for(pp_index=0; pp_index<SMALLER_WIDTH ; pp_index=pp_index+1)
                    middle_layers[layer][pp_index] <= 0;
            end

            else begin

                if(layer == 0)  // all partial products rows are in first layer
                begin

                    // generation of partial products rows
                    for(pp_index=0; pp_index<SMALLER_WIDTH ; pp_index=pp_index+1)
                        middle_layers[layer][pp_index] <= 
                        (MULTIPLICAND & MULTIPLIPLIER[pp_index]);

                    // see modified baugh-wooley algorithm: [url]https://i.imgur.com/VcgbY4g.png[/url] from
                                        // page 122 of book "Ultra-Low-Voltage Design of Energy-Efficient Digital Circuits"
                    for(pp_index=0; pp_index<SMALLER_WIDTH ; pp_index=pp_index+1)
                        middle_layers[layer][pp_index][LARGER_WIDTH-1] <= 
                       !middle_layers[layer][pp_index][LARGER_WIDTH-1];

                    middle_layers[layer][SMALLER_WIDTH-1] <= !middle_layers[layer][SMALLER_WIDTH-1];
                    middle_layers[layer][0][LARGER_WIDTH] <= 1;
                    middle_layers[layer][SMALLER_WIDTH-1][LARGER_WIDTH] <= 1;
                end

                // adding the partial product rows according to row adder tree architecture
                else begin
                    for(pp_index=0; pp_index<(SMALLER_WIDTH >> layer) ; pp_index=pp_index+1)
                        middle_layers[layer][pp_index] <=
                        middle_layers[layer-1][pp_index<<1] +
                      (middle_layers[layer-1][(pp_index<<1) + 1]) << 1;

                    // bit-level additions using full adders
                    /*for(pp_index=0; pp_index<SMALLER_WIDTH ; pp_index=pp_index+1)
                        for(bit_index=0; bit_index<(LARGER_WIDTH+layer); bit_index=bit_index+1)
                            full_adder fa(.clk(clk), .reset(reset), .ain(), .bin(), .cin(), .sum(), .cout());*/
                end
            end
        end
    end

endgenerate

assign out_C = (reset)? 0 : middle_layers[NUM_OF_INTERMEDIATE_LAYERS-1][0];


/*Checking if the final multiplication result is ready or not*/

reg [($clog2(NUM_OF_INTERMEDIATE_LAYERS)-1):0] out_valid_counter; // to track the multiply stages
reg multiply_had_started;

always @(posedge clk)
begin
    if(reset) 
    begin
        multiply_had_started <= 0;
        out_valid <= 0;
        out_valid_counter <= 0;
    end

    else if(out_valid_counter == NUM_OF_INTERMEDIATE_LAYERS-1) begin
        multiply_had_started <= 0;
        out_valid <= 1;
        out_valid_counter <= 0;
    end

    else if(in_valid && !multiply_had_started) begin
        multiply_had_started <= 1;
        out_valid <= 0; // for consecutive multiplication
    end

    else begin
        out_valid <= 0;
        if(multiply_had_started) out_valid_counter <= out_valid_counter + 1;
    end
end


`ifdef FORMAL

initial assume(reset);
initial assume(in_valid == 0);

wire sign_bit = MULTIPLICAND_reg[LARGER_WIDTH-1] ^ MULTIPLIPLIER_reg[SMALLER_WIDTH-1];

always @(posedge clk)
begin
    if(reset) assert(out_C == 0);

    else if(out_valid) begin
        assert(out_C == (MULTIPLICAND_reg * MULTIPLIPLIER_reg));
        assert(out_C[A_WIDTH+B_WIDTH-1] == sign_bit);
    end
end

`endif

`ifdef FORMAL

localparam user_A = 3;
localparam user_B = 2;

always @(posedge clk)
begin
    cover(in_valid && (in_A == user_A) && (in_B == user_B));
    cover(out_valid);
end

`endif

endmodule