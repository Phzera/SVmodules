/*
* Asynchronous FIFO
* Used when transfer data between blocks that are in different clock domains
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/07/31  | Initial version
*/

module async_fifo #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 4,
    parameter FIFO_DEPTH = 8
) (
    input  logic                    src_clk_i,
    input  logic                    dest_clk_i,
    input  logic                    aresetn_i,
    input  logic [DATA_WIDTH - 1:0] data_i,
    input  logic                    wr_en_i,
    input  logic                    rd_en_i,
    output logic [DATA_WIDTH - 1:0] data_o,
    output logic                    fifo_full_o,
    output logic                    fifo_empty_o
);

    logic [DATA_WIDTH - 1:0] data_q[FIFO_DEPTH - 1:0];
    logic [ADDR_WIDTH - 1:0] wraddr, wraddr_gray, rdaddr, rdaddr_gray;
    logic [ADDR_WIDTH - 1:0] wraddr_b1ff,wraddr_bff, wraddr_aff;
    logic [ADDR_WIDTH - 1:0] rdaddr_a1ff, rdaddr_aff, rdaddr_bff;
    logic [FIFO_DEPTH - 1:0] wren, wren_qual, rden, rden_qual;
    
endmodule