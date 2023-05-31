`timescale 1ns / 1ps
/*
* N-bit shift register
* Parameterized width of shift register
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*   Key features:
*   Can be enabled or disabled by driving en_i
*   Shift to left or right with dir_i
*   Active-low reset
*/

module shift_register #(
    parameter MSB = 8
) (
    input  logic           clk_i,
    input  logic           rstn_i,
    input  logic           en_i,    // shift-register on/off
    input  logic           dir_i,   // left or right shift
    input  logic           data_i,  // Input data for the first flop
    output logic [MSB-1:0] data_o   // Output read currennt value of all flops
);

    always_ff @( posedge ) begin : blockName
        if(!rstn_i) begin
            data_o <= 'b0;
        end else begin
            if(en_i) begin
                case (dir_i)
                    1'b0 : data_o <= {data_o[MSB-2:0], data_i};
                    1'b1 : data_o <= {data_i, data_o[MSB-1:1]};
                endcase
            end else begin
                data_o <= data_o;
            end
        end
    end

endmodule
