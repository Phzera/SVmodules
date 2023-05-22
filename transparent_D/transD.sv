`timescale 1ns / 1ps
/*
* Transparent D flip flop - Latch D
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module transD(
    input  logic clk_i,
    input  logic d_i,
    output logic q_o
);

    logic q_ff;

    always @(d_i, clk_i, q_ff) begin
        if (!clk_i) begin
            q_ff <= q_ff;
            q_o <= !q_ff;
        end else begin
            q_ff <= d_i;
            q_o  <= q_ff;
        end
    end

endmodule
