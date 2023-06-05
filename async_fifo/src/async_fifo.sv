/*
* Asynchronous FIFO
* Used when transfer data between blocks that are in different clock domains. In this example,
* assumes that we want to transfer data from A clock domain to B clock domain.
* Author: Pedro Oliveira
* Version History
* Version | Date        | Modifications
* 1.0     | 2022/07/31  | Initial version
*/

module async_fifo #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 4,
    parameter FIFO_DEPTH = 2 * ADDR_WIDTH
) (
    input  logic                    a_clk_i,
    input  logic                    b_clk_i,
    input  logic                    aresetn_i,
    input  logic [DATA_WIDTH - 1:0] wr_data_i,
    input  logic                    wr_en_i,
    input  logic                    rd_en_i,
    output logic [DATA_WIDTH - 1:0] rd_data_o,
    output logic                    fifo_full_o,
    output logic                    fifo_empty_o
);

    logic [DATA_WIDTH - 1:0] data_q[FIFO_DEPTH - 1:0];
    logic [ADDR_WIDTH - 1:0] wr_addr, rd_addr, wr_addr_gray, rd_addr_gray;
    logic [ADDR_WIDTH - 1:0] b_wraddr_q1, b_wr_addr_q, a_wr_addr_q;
    logic [ADDR_WIDTH - 1:0] a_rd_addr_q1, a_rd_addr_q, b_rd_addr_q;
    logic [FIFO_DEPTH - 1:0] wr_en, wr_en_qual, rd_en, rd_en_qual;
    logic fifo_full_s, fifo_empty_s;

    // Convert to Gray code
    //assign wr_addr_gray = (wr_addr >> 1) ^ wr_addr;
    //assign rd_addr_gray = (rd_addr >> 1) ^ rd_addr;
    bin2gray wr_bin2gray_u(
        .bin_i(wr_addr),
        .gray_o(wr_addr_gray)
    );
    bin2gray rd_bin2gray_u(
        .bin_i(rd_addr),
        .gray_o(rd_addr_gray)
    );

    always_comb begin : GEN_WRITE_ADDRESS
        if (!fifo_full_s & wr_en_i) begin
            wr_addr = a_wraddr_q + 1'b1;
        end else begin
            wr_addr = a_wraddr_q;
        end 
    end
    
    always_ff @(posedge a_clk_i or negedge aresetn_i) begin : WRITE_ADDRESS_SYNC
        if (!aresetn_i) begin
            a_wraddr_q <= 1'b0;
        end else begin
            if (wr_en_i) begin
                a_wraddr_q <= wr_addr;
            end else begin
                a_wraddr_q <= a_wraddr_q;
            end
        end
    end

    // Sync clock to b_clk
    always_ff @(posedge b_clk_i or negedge aresetn_i) begin : B_CLK_SYNC
        if (!aresetn_i) begin
            b_wraddr_q  <= 1'b0;
            b_wraddr_q1 <= 1'b0;
        end else begin
            b_wraddr_q <= wr_addr_gray;
            b_wraddr_q1 <= b_wraddr_q;
        end       
    end

    always_comb begin
        if (!fifo_empty_s && rd_en_i) begin : GEN_READ_ADDRESS
            rd_addr = b_rdaddr_q + 1'b1;
        end else begin
            rd_addr = b_rdaddr_q;
        end
    end

    always_ff @(posedge b_clk_i or negedge aresetn_i) begin : READ_ADDRESS_SYNC
        if (!aresetn_i) begin
            b_rdaddr_q <= 1'b0;
        end else begin
            if (rd_en_i) begin
                b_rdaddr_q <= rd_addr;
            end else begin
                b_rdaddr_q <= b_rdaddr_q;
            end
        end
    end

    always_ff @(posedge a_clk_i or negedge aresetn_i) begin : A_SYNC_CLK
        if (!aresetn_i) begin
            a_rd_addr_q <= 1'b0;
            a_rd_addr_q1 <= 1'b0;
        end else begin
            a_rd_addr_q <= rd_addr_gray;
            a_rd_addr_q1 <= a_rd_addr_q;
        end
    end
    
    // Data write and read qualifiers
    assign wr_en_qual = (wr_en & !fifo_full) ? (1 << wr_addr) : FIFO_DEPTH'b0;
    assign rd_en_qual = (rd_en & !fifo_empty) ? (1 << rd_addr) : FIFO_DEPTH'b0;

    genvar i;

    generate
        for(i = 0; i < FIFO_DEPTH; i++) begin  
            always_ff @(posedge a_clk_i or negedge aresetn_i) begin
                if(wr_en_qual[i]) begin
                    data_q[i]  <= wr_data_i;
                end else begin
                    data_q[i] <= data_q[i];
                end
            end
        end
    endgenerate

    always_comb begin
        for (int j = 0; j < FIFO_DEPTH; j++) begin
            if (rd_en_qual[j]) begin
                rd_data_o = data_q[j];
            end else begin
                rd_data_o = FIFO_DEPTH'b0;
            end
        end
    end

    // Generates Full and Empty flags
    assign fifo_full_o = (wr_addr_gray[2:0] == a_rd_addr_q1[2:0]) && 
                        (wr_addr_gray[3:3] != a_rd_addr_q1[3:3]);
    assign fifo_empty_o = (b_wraddr_q1[3:0] == rd_addr_gray[3:0]);


endmodule