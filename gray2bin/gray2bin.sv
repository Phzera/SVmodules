/*
* Gray code to Binary Converter
* Pedro Oliveira, 2022
* Msb is equal for both.
* Other bits are a XOR of them
*/
module gray2bin #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH - 1:0] gray_i,
    output logic [WIDTH - 1:0] bin_o
);
    generate
        for(int i = 0; i < WIDTH; i = i++)
             bin_o[i] = ^ (gray >> i);        
    endgenerate

endmodule