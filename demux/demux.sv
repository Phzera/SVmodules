`timescale 1ns / 1ps
/*
* Demultiplexer
* Demux 1-32b  channel into 8-32b channel according to Sel
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module demux #(
    parameter DATA_WIDTH = 32
    )
    (
    input  logic        arstn_i,
    input  logic        clk_i,
    input  logic [2:0]  selector_i,
    input  logic [DATA_WIDTH-1:0] channel_in_i,
    output logic [DATA_WIDTH-1:0] channel_a_o,
    output logic [DATA_WIDTH-1:0] channel_b_o,
    output logic [DATA_WIDTH-1:0] channel_c_o,
    output logic [DATA_WIDTH-1:0] channel_d_o,
    output logic [DATA_WIDTH-1:0] channel_e_o,
    output logic [DATA_WIDTH-1:0] channel_f_o,
    output logic [DATA_WIDTH-1:0] channel_g_o,
    output logic [DATA_WIDTH-1:0] channel_h_o
    );
    
    logic [(8*DATA_WIDTH)-1:0] output_vector;
    
    // Output channel Demultiplexer
    always @(posedge clk_i, selector_i) begin : channelOut
        case (selector_i)
            3'b000  : output_vector <= {channel_in_i, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0};
            3'b001  : output_vector <= {32'b0, channel_in_i, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0};
            3'b010  : output_vector <= {32'b0, 32'b0, channel_in_i, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0};
            3'b011  : output_vector <= {32'b0, 32'b0, 32'b0, channel_in_i, 32'b0, 32'b0, 32'b0, 32'b0};
            3'b100  : output_vector <= {32'b0, 32'b0, 32'b0, 32'b0, channel_in_i, 32'b0, 32'b0, 32'b0};
            3'b101  : output_vector <= {32'b0, 32'b0, 32'b0, 32'b0, 32'b0, channel_in_i, 32'b0, 32'b0};
            3'b110  : output_vector <= {32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, channel_in_i, 32'b0};
            3'b111  : output_vector <= {32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, channel_in_i};
            default : $display("Invalid SEL input");
        endcase
    end
    
    assign channel_a_o = output_vector[255:224];
    assign channel_b_o = output_vector[223:192];
    assign channel_c_o = output_vector[191:160];
    assign channel_d_o = output_vector[159:128];
    assign channel_e_o = output_vector[127:96];
    assign channel_f_o = output_vector[95:64];
    assign channel_g_o = output_vector[63:32];
    assign channel_h_o = output_vector[31:0];

endmodule
