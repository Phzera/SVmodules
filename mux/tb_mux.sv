`timescale 1ns / 1ps
/*
* Multiplexer Testbech
* Mux 8 32b  channels into one 32b 
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/05/22  | Initial version
*/

module tb_mux();
        
    parameter DATA_WIDTH = 32;
    logic        tb_arstn;
    logic        tb_clk;
    logic [2:0]  tb_sel;
    logic [DATA_WIDTH-1:0] tb_ch_a;
    logic [DATA_WIDTH-1:0] tb_ch_b;
    logic [DATA_WIDTH-1:0] tb_ch_c;
    logic [DATA_WIDTH-1:0] tb_ch_d;
    logic [DATA_WIDTH-1:0] tb_ch_e;
    logic [DATA_WIDTH-1:0] tb_ch_f;
    logic [DATA_WIDTH-1:0] tb_ch_g;
    logic [DATA_WIDTH-1:0] tb_ch_h;
    logic [DATA_WIDTH-1:0] tb_ch_out_o;  // Declare wire signal to collect DUT output
    integer i;

    mux dut(
        .arstn_i(tb_arstn),
        .clk_i(tb_clk),
        .selector_i(tb_sel),
        .channel_a_i(tb_ch_a),
        .channel_b_i(tb_ch_b),
        .channel_c_i(tb_ch_c),
        .channel_d_i(tb_ch_d),
        .channel_e_i(tb_ch_e),
        .channel_f_i(tb_ch_f),
        .channel_g_i(tb_ch_g),
        .channel_h_i(tb_ch_h),
        .channel_out_o(tb_ch_out_o)
    );

    // Create clock
    always #10 tb_clk = ~tb_clk;

    initial begin
         // Dump waves
        $dumpfile("dump_tb_mux.vcd");
        $dumpvars(1);
        tb_clk = 1'b0;
        tb_arstn = 1'b1;
        #10;
        tb_arstn = 1'b0;
        #10;
        tb_arstn = 1'b1;
        // Launch monitor in background to display values to log whenever changes
        $monitor("[%0t] SEL=0x%0h CH_A=0x%0h CH_B=0x%0h CH_C=0x%0h CH_D=0x%0h", $time, tb_sel, tb_ch_a, tb_ch_b, tb_ch_c, tb_ch_d);
        $monitor("[%0t] CH_E=0x%0h CH_F=0x%0h CH_G=0x%0h CH_H=0x%0h", $time, tb_ch_e, tb_ch_f, tb_ch_g, tb_ch_h);

        // 1. At time 0,random values to a/b/c/d/ and keep sel = 0
        tb_sel  <= 3'b0;
        tb_ch_a <= $random;
        tb_ch_b <= $random;
        tb_ch_c <= $random;
        tb_ch_d <= $random;
        tb_ch_e <= $random;
        tb_ch_f <= $random;
        tb_ch_g <= $random;
        tb_ch_h <= $random;

        // 2. Change the value of sel every 15 ns
        for (i = 1; i < 8; i = i + 1) begin
            #15 tb_sel <= i; 
        end

        // 3. After step 2 is over,wait 10 ns annd finish the simulation
        #10 $finish;
    end

endmodule