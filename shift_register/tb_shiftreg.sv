`timescale 1ns / 1ps
/*
* N-bit shift register testbench
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module tb_shiftreg;
   parameter MSB;
   logic           tb_clk;
   logic           tb_rstn;
   logic           tb_en;    // shift-register on/off
   logic           tb_dir;   // left or right shift
   logic           tb_data;  // Input data for the first flop
   logic [MSB-1:0] out;   // Output read currennt value of all flops
        
    // Instatiate design
   shift_register #(
       .MSB(MSB)
   ) shift_reg_u (
       .clk_i  (tb_clk),
       .rstn_i (tb_rstn),
       .en_i   (tb_en),  
       .dir_i  (tb_dir), 
       .data_i (tb_data),
       .data_o (out)
   );

   // Generate clock @50 MHz
   always #10 tb_clk = ~tb_clk;

   // Initialize variables with default value
    initial begin
        tb_clk  <= 'b0;
        tb_rstn <= 'b1;
        tb_en   <= 'b0;
        tb_dir  <= 'b0;
        tb_data <= 'b1;
    end

    // Drive stimulus to desing
    initial begin
        // Apply reset
        tb_rstn <= 'b0;
        #20
        tb_rstn <= 'b1;
        tb_en <= 'b1;
        
        // Monitor variables and print for debug
        $monitor("rstn=%0b, data=%0b, en=%0b, dir=%0b, out=%b", tb_rstn, tb_data, tb_en, tb_dir, out);
        
        // Drive alternate values to data pin for 8 clock cycles
        repeat(8) @ (posedge tb_clk)
            tb_data <= ~tb_data;
        
        // Shift direction and drive alternate values
        #20
        tb_dir <= 'b1;
        repeat(8) @ (posedge tb_clk)
            tb_data <= ~tb_data;
        
        // Drive nothing for 5 clock cycles
        repeat (5) @ (posedge tb_clk)
        $finish;
    end

endmodule
