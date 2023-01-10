`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Pedro Oliveira
// 
// Create Date: 03.05.2022 18:00:01
// Design Name: 
// Module Name: clock_sw
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_sw(
    input clk_a_i,
    input clk_b_i,
    input clk_c_i,
    input clk_d_i,
    input arstn_i,
    input [1:0] sel_i,
    output clk_out_o
    );
 
    localparam SEL_A = 2'b00;
    localparam SEL_B = 2'b01;
    localparam SEL_C = 2'b10;
    localparam SEL_D = 2'b11;
    
    logic clk_a_q;
    logic clk_b_q;
    logic clk_c_q;
    logic clk_d_q;
      
    always_ff @(negedge clk_a_i or negedge arstn_i) begin : PROC_CLOCK_A
        if (~arstn_i) begin
            clk_a_q <= 0;
        end
        else begin
            clk_a_q <= (sel_i == SEL_A) & ~(clk_b_q | clk_c_q | clk_d_q);
        end            
    end: PROC_CLOCK_A
    
    always_ff @(negedge clk_b_i or negedge arstn_i) begin : PROC_CLOCK_B
        if (~arstn_i) begin
            clk_b_q <= 0;
        end
        else begin
            clk_b_q <= (sel_i == SEL_B) & ~(clk_a_q | clk_c_q | clk_d_q);
        end            
    end: PROC_CLOCK_B
    
     always_ff @(negedge clk_c_i or negedge arstn_i) begin : PROC_CLOCK_C
        if (~arstn_i) begin
            clk_c_q <= 0;
        end
        else begin
            clk_c_q <= (sel_i == SEL_C) & ~(clk_a_q | clk_b_q | clk_d_q);
        end            
    end: PROC_CLOCK_C
    
    always_ff @(negedge clk_d_i or negedge arstn_i) begin : PROC_CLOCK_D
        if (~arstn_i) begin
            clk_d_q <= 0;
        end
        else begin
            clk_d_q <= (sel_i == SEL_D) & ~(clk_a_q | clk_b_q | clk_c_q);
        end            
    end: PROC_CLOCK_D           
    
    assign clk_out_o = (clk_a_i & clk_a_q) | (clk_b_i & clk_b_q) |
                       (clk_c_i & clk_c_q) | (clk_d_i & clk_d_q );
    
endmodule
