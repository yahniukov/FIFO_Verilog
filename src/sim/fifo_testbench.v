module fifo_testbench (  );

    /* Parameters */
    
    parameter DATA_WIDTH = 1;
    parameter FIFO_DEPTH = 8;
    
    /* Variables */
    
    reg [DATA_WIDTH - 1 : 0] wr_data = 0;
    reg wr_clk = 0, wr_en = 1;
    
    wire [DATA_WIDTH - 1 : 0] rd_data;
    reg rd_clk = 0, rd_en = 1;
    wire rd_valid;
    
    wire full, empty;
    
    reg reset = 0;
    
    /* Behavioral */
    
    // FIFO module instance
    
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH)
    ) fifo (
        .wr_data(wr_data),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .rd_data(rd_data),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rd_valid(rd_valid),
        .full(full),
        .empty(empty),
        .reset(reset)
    );
    
    // Write Clock Generation
    
    always
        #5 wr_clk = !wr_clk;
        
    // Write Data Generation
    
    always
        #10 wr_data = !wr_data;
            
    // Read Clock Generation   
    
    always
        #3 rd_clk = !rd_clk & !full;
        
    // Reset Generation
    
    initial begin
        #2 reset = 1;
        #2 reset = 0;
    end 


endmodule