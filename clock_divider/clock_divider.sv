`timescale 1ns / 1ps
/*
* Clock Divider
* Divides the main clock to get a slower clock according to enable frequency
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module clock_divider #(
    parameter WIDTH = 32
    )(
        input  logic clk_i,
        input  logic rstn_i,
        input  logic enable_i,
        output logic [(WIDTH-1):0] clk_out_o = 'b0
    );

    always_ff @(posedge clk_i) begin : clkDivider
        if (~rstn_i) begin
            clk_out_o <= 'b0;
        end else if (enable_i) begin
            clk_out_o <= clk_out_o + 1'b1;
    end

endmodule