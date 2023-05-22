`timescale 1ns / 1ps
/*
* Multiplexer
* Mux 8 32b input channels into one 32b output
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/02/06  | Initial 
*/

module mux #(
    parameter DATA_WIDTH = 32
    )
    (
    input  logic        arstn_i,
    input  logic        clk_i,
    input  logic [2:0]  selector_i,
    input  logic [DATA_WIDTH-1:0] channel_a_i,
    input  logic [DATA_WIDTH-1:0] channel_b_i,
    input  logic [DATA_WIDTH-1:0] channel_c_i,
    input  logic [DATA_WIDTH-1:0] channel_d_i,
    input  logic [DATA_WIDTH-1:0] channel_e_i,
    input  logic [DATA_WIDTH-1:0] channel_f_i,
    input  logic [DATA_WIDTH-1:0] channel_g_i,
    input  logic [DATA_WIDTH-1:0] channel_h_i,
    output logic [DATA_WIDTH-1:0] channel_out_o
    );

    logic [2:0]  sel_q1, sel_q2;
    logic [DATA_WIDTH-1:0] channel_out_q1;


    // Sync selector input
    always_ff @(posedge clk_i or negedge arstn_i) begin : muxSelector
        if (~arstn_i) begin
            sel_q1 <= 3'b0;
            sel_q2 <= 3'b0;
        end else begin
            sel_q1 <= selector_i;
            sel_q2 <= sel_q1;
        end
    end

    // Output channel multiplexer
    always_ff @(posedge clk_i or negedge arstn_i or sel_q2) begin : blockName
        if (arstn_i) begin
            channel_out_q1 <= 32'b0;
        end else begin
            case (sel_q2)
                3'b000  : channel_out_q1 <= channel_a_i;
                3'b001  : channel_out_q1 <= channel_b_i;
                3'b010  : channel_out_q1 <= channel_c_i;
                3'b011  : channel_out_q1 <= channel_d_i;
                3'b100  : channel_out_q1 <= channel_e_i;
                3'b101  : channel_out_q1 <= channel_f_i;
                3'b110  : channel_out_q1 <= channel_g_i;
                3'b111  : channel_out_q1 <= channel_h_i;
            default : channel_out_q1 <= 32'b0;
            endcase
        end
    end

endmodule
