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

// Instantiates de DUT
    debouncer DUT(
        .clock       (clock),
        .resetn      (resetn),
        .bounced_i   (button_i),
        .debounced_o (db_button_o)
    );

    // Generates Clock @50 MHz (20 ns period)
    always #10 clock = ~clock;

    initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1);
      
      $display ("[%t] << Starting simulation >> ", $time);
        clock = 1'b0;
        #10;
        resetn = 1'b0;
      $display ("[%t] << Applying reset >> ", $time);
        #100;
        resetn = 1'b1;
        button_i = 1'b0;
    
    // Oscilates button_i without any period match
        #100 button_i = 1'b1;
        #200 button_i = 1'b0;
        #100 button_i = 1'b1;
        #200 button_i = 1'b0;
        #300 button_i = 1'b1;
        #150 button_i = 1'b0;
        #120 button_i = 1'b1;
        #210 button_i = 1'b0;
        #330 button_i = 1'b1;
        #450 button_i = 1'b0;
        #270 button_i = 1'b1;
        #50  button_i = 1'b0;
        #100 button_i = 1'b1;
        #75  button_i = 1'b0;
        #855 button_i = 1'b1;
        #900 button_i = 1'b0;
        #100 button_i = 1'b1;
        #200 button_i = 1'b0;
        #1000
      $display("[%t] << Terminates simulation >> ", $time);
        $finish;
    end

endmodule