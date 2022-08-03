`timescale 1ns/100ps
/*
* TB Gray code to Binary Converter
* Pedro Oliveira, 2022
* Msb is equal for both.
* Other bits are a XOR of bit-pairs
*/
module tb_gray2bin();

parameter WIDTH = 4;

logic [WIDTH - 1:0] tb_bin;
logic [WIDTH - 1:0] tb_gray;

bin2gray #(
	.WIDTH(WIDTH)
) dut (
  .gray_i(tb_gray),
  .bin_o(tb_bin)
);
 	
	initial begin
   
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
      
  	tb_gray = 4'b0;
  	#10
  	tb_gray = 4'b0000;
  	#5
  	tb_gray = 4'b0001;
  	#5
    tb_gray = 4'b0010;
  	#5
    tb_gray = 4'b0011;
  	#5
    tb_gray = 4'b0100;
  	#5
    tb_gray = 4'b0101;
  	#5
  	tb_gray = 4'b0110;
  	#5
  	tb_gray = 4'b0111;
  	#5
    tb_gray = 4'b1000;
  	#5
  	tb_gray = 4'b1001;
  	#5
    tb_gray = 4'b1010;
  	#5
    tb_gray = 4'b1011;
  	#5
    tb_gray = 4'b1100;
  	#5
    tb_gray = 4'b1101;
  	#5
    tb_gray = 4'b1110;
  	#5  	
  	tb_gray = 4'b1111;
  	#5
    tb_gray = 4'b0;
   	#50;
	end
  
endmodule
