/*
* Fall edge detector
* Pedro Oliveira, 2022
*
*/


module faller (
    input  logic clk,
    input  logic resetn,
    input  logic async_i,
    output logic fall_o 
);

logic async_q;

always_ff @( posedge clk or negedge resetn ) begin : Fall
    if(!resetn) begin
        async_q <= 1'b0;
    end else begin
        async_q <= async_i;
    end    
end

assign rise_o = ~async_i & async_q;

endmodule