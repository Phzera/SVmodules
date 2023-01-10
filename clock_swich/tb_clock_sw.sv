`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2022 18:20:07
// Design Name: 
// Module Name: tb_clock_sw
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


module tb_clock_sw;

    logic       tb_clk_a;
    logic       tb_clk_b;
    logic       tb_clk_c;
    logic       tb_clk_d;
    logic [1:0] tb_sel;
    logic       tb_rst;
    
    clock_sw dut (
    .clk_a_i   (tb_clk_a),
    .clk_b_i   (tb_clk_b),
    .clk_c_i   (tb_clk_c),
    .clk_d_i   (tb_clk_d),
    .sel_i     (tb_sel),
    .arstn_i   (tb_rst),
    .clk_out_o (tb_clk_out)
    );
    
   // Create clock A
   always #10 tb_clk_a = ~tb_clk_a;
   // Create clock B
   always #100 tb_clk_b = ~tb_clk_b;  
      // Create clock C
   always #200 tb_clk_c = ~tb_clk_c;   
      // Create clock D
   always #500 tb_clk_d = ~tb_clk_d;
   
   initial begin
         #10
         tb_clk_a <= 0;
         tb_clk_b <= 0;
         tb_clk_c <= 0;
         tb_clk_d <= 0; 
         tb_rst <= 0;
         tb_sel <= 2'b0;
         #10
         tb_rst <= 1;
         #3000
         tb_sel <= 2'b01;
         #3000
         tb_sel <= 2'b10;
         #3000
         tb_sel <= 2'b11;
         #6000
         tb_sel<=2'b00;
     end
    
endmodule
