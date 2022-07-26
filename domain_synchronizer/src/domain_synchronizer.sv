/*
* Clock domain synchronizer
* Pedro Oliveira, 2022
*
*/


module domain_synchronizer #(
    parameter integer DATA_WIDTH = 32
)(
    input  logic clk,
    input  logic resetn,
    input  logic [DATA_WIDTH-1:0] d_async_i,
    output logic [DATA_WIDTH-1:0] d_sync_o
);

logic [DATA_WIDTH-1:0] sync_q1;
logic [DATA_WIDTH-1:0] sync_q2;


always_ff @( posedge clk or negedge resetn ) begin : TWO_STAGE_SYNC
    if(!resetn) begin
        sync_q1 <= DATA_WIDTH'b0;
        sync_q2 <= DATA_WIDTH'b0;
    end else begin
        sync_q1 <= d_async_i;
        sync_q2 <= sync_q1;
    end    
end

assign rise_o = async_i & ~async_q;

endmodule