`timescale 1ns / 1ps
/*
* Testbench Clock Divier
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module tb_clock_divider();

    logic tb_clk;
    logic tb_rstn;
    logic tb_enable;
    logic tb_clk_o;
    logic [3:0] en_counter;

    clock_divider dut (
        .clk_i(tb_clk),
        .rstn_i(tb_rstn),
        .enable_i(tb_enable),
        .clk_out_o(tb_clk_o)
    );

    // Create clock
    always #10 tb_clk = ~tb_clk;

    initial begin
        // Dump waves
        $dumpfile("dump_tb_clk_divider.vcd");
        $dumpvars(1);
        tb_clk = 1'b0;
        tb_rstn = 1'b1;
        tb_enable = 1'b0;
        #10

        always_ff @(posedge clk_i) begin : enableCounter
            if (~rstn_i) begin
                en_counter <= 4'b0;
            end else if (en_counter == 4'hFFFF) begin
                tb_enable <= 1'b1;
                en_counter <= 4'b0;
            end else begin
                en_counter <= en_counter + 4'b1;
            end
        end
    end

endmodule
