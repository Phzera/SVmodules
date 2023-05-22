`timescale 1ns / 1ps
/*
* Demultiplexer
* Demux 8 32b input channels into one 32b output
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module mux #(
    parameter DATA_WIDTH = 32
    )
    (
    input  logic        arstn_i,
    input  logic        clk_i,
    input  logic [2:0]  selector_i,
    input  logic [DATA_WIDTH-1:0] channel_in_i,
    output logic [DATA_WIDTH-1:0] channel_a_o
    output logic [DATA_WIDTH-1:0] channel_b_o,
    output logic [DATA_WIDTH-1:0] channel_c_o,
    output logic [DATA_WIDTH-1:0] channel_d_o,
    output logic [DATA_WIDTH-1:0] channel_e_o,
    output logic [DATA_WIDTH-1:0] channel_f_o,
    output logic [DATA_WIDTH-1:0] channel_g_o,
    output logic [DATA_WIDTH-1:0] channel_h_o,
    );

    // Output channel Demultiplexer
    always @(posedge clk_i or negedge arstn_i or sel_q) begin : channelOut
        case (selector_i)
            3'b000  : channel_a_o <= channel_in_i;
            3'b001  : channel_b_o <= channel_in_i;
            3'b010  : channel_c_o <= channel_in_i;
            3'b011  : channel_d_o <= channel_in_i;
            3'b100  : channel_e_o <= channel_in_i;
            3'b101  : channel_f_o <= channel_in_i;
            3'b110  : channel_g_o <= channel_in_i;
            3'b111  : channel_h_o <= channel_in_i;
            default : channel_i_o <= 32'b0;
        endcase
    end

endmodule
