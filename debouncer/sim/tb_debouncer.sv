`timescale 1ns/100ps
/*
* Debouncer logic Testbench
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/01/19  | Initial 
*/

module tb_debouncer();

// Inputs
    logic clock;
    logic resetn;
    logic button_i;

// Outputs
    logic db_button_o;

// Intantiates de DUT
    debouncer DUT(
        .clock       (clock),
        .resetn      (resetn),
        .bounced_i   (button_i),
        .debounced_o (db_button_o)
    );

    // Generates Clock @50 MHz (20 ns period)
    always #10 clock = ~clock;

    initial begin
        $display ("[$time] << Starting simulation >> ");
        clk = 1'b0;
        #10;
        resetn = 1'b0;
        $display ("[$time] << Applying reset >> ");
        #100;
        resetn = 1'b1;
        button_i = 1'b0;
    
    // Oscilates button_i without any period match
        #100  button_i = 1'b1;
        #200  button_i = 1'b0;
        #1000 button_i = 1'b1;
        #2000 button_i = 1'b0;
        #3000 button_i = 1'b1;
        #1500 button_i = 1'b0;
        #1200 button_i = 1'b1;
        #2100 button_i = 1'b0;
        #3300 button_i = 1'b1;
        #4500 button_i = 1'b0;
        #2700 button_i = 1'b1;
        #50   button_i = 1'b0;
        #100  button_i = 1'b1;
        #75   button_i = 1'b0;
        #855  button_i = 1'b1;
        #9000 button_i = 1'b0;
        #1000 button_i = 1'b1;
        #2000 button_i = 1'b0;
    end

endmodule