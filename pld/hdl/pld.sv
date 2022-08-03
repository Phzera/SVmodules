/*
Pedro Oliveira


Combination PLD with Logic Gates
Implements a basic programmable device
This module contains the basic logic gates
They implement functions described as below:

* AND : v = ab
* OR  : w = a + b + c
* NAND: x = !(cdef)
* NOR : y = !(a + b + c)
* NOT : z = !a

*/

module pld (
    
    input   logic a;
	input   logic b;
	input   logic c;
	input   logic d;
	input   logic e;
	input   logic f;

	output  logic v;
    output  logic w;
	output  logic x;
	output  logic y;
	output  logic z;
);

// Combinational logic
assign v = a & b;
assign w = a | b | c;
assign x = ~ (c & d & e & f);
assign y = ~ (a | b | c );
assign z = ~a;

end module

