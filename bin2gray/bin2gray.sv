/*
* Binary to Gray Code Converter
* Pedro Oliveira, 2022
* Msb is equal for both.
* Other bits are a XOR of bit-pairs
*/

module bin2gray #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH - 1:0] bin_i,
    output logic [WIDTH - 1:0] gray_o
);
  
    assign gray_o = (bin_i >> 1) ^ bin_i;

endmodule