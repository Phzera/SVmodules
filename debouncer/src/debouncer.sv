/*
* Debouncer logic circuit
* The bounced input can be an button, switch or any signal that may oscillate during state change
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/01/19  | Initial 
*/
`timescale 1ns/100ps

module debouncer 
(
    input  logic clock,
    input  logic resetn,
    input  logic bounced_i,
    output logic debounced_o
);

// Constants and parameters
parameter N = 12; // Counter resolution

// Internal signals
logic [N-1:0] cnt_s; // Two-stage counter
logic [N-1:0] cnt_next_s;
logic dff_q1;
logic dff_q2;
logic add_en_s;
logic clear_s;

// Continuous assignments
assign clear    = dff_q1 ^ dff_q2; // XOR input FF to look for input state change to clear counter
assign add_en_s = ~cnt_s[N-1];     // Add to counter only if cnt_s MSB is equal to 0

// cnt_next_s manager
always @(clear, add_en_s, cnt_s) begin : next_value_manager
        case ({clear_s, add_en_s})
            2'b00   : cnt_next_s <= cnt_s;
            2'b01   : cnt_next_s <= cnt_s + 1'b1;
            default : cnt_next_s <= { N {1'b0} }; 
        endcase
end

// Flip flop inputs
always_ff @(posedge clock or negedge resetn) begin : flip_flop_inputs
    if (~resetn) begin
        dff_q1 <= 1'b0;
        dff_q2 <= 1'b0;
        cnt_s  <= 'b0;
    end
    else begin
        dff_q1 <= bounced_i;
        dff_q2 <= dff_q1;
        cnt_s  <= cnt_next_s;
    end
end

// Registered output
always_ff @(posedge clock or negedge resetn ) begin : debounced_output
    if (~resetn) begin
        debounced_o <= 1'b0;
    end
    else begin
        if (cnt_s[N-1] == 1'b1) begin
            debounced_o <= dff_q2
        end
        else begin
            debounced_o <= debounced_o;
        end

    end
end

endmodule
