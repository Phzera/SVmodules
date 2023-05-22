`timescale 1ns / 1ps
/*
* Testbench Latch D
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module tb_transD();

    logic tb_clk;
    logic tb_data_in;
    logic tb_data_out;

    transD dut (
        .clk_i(tb_clk),
        .d_i(tb_data_in),
        .q_o(tb_data_out)
    );

    // Create clock
    always #10 tb_clk = ~tb_clk;

    initial begin
        // Dump waves
        $dumpfile("dump_tb_transD.vcd");
        $dumpvars(1);
        tb_clk = 1'b0;
        tb_data_in = 1'b0;
        #10
        tb_data_in = 1'b1;
        #5
        tb_data_in = 1'b0;
        #5
        tb_data_in = 1'b1;
        #5
        tb_data_in = 1'b0;
        #5
        tb_data_in = 1'b1;
        #5
        tb_data_in = 1'b0;
        #5
        tb_data_in = 1'b1;
        #5
        tb_data_in = 1'b0;
        #50;
    end
endmodule
