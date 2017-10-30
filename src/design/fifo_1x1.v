module fifo_1x1 ( wr_data, wr_clk, wr_en,           // write port
                  rd_data, rd_clk, rd_en, rd_valid, // read port
                  full, empty,                      // debug ports
                  reset );

    /* Parameters */
    
    parameter DATA_WIDTH = 1;
    parameter FIFO_DEPTH = 8;
    
    localparam COUNTER_WIDTH = clog2(FIFO_DEPTH);
    
    /* Ports */
    
    input wire [DATA_WIDTH - 1 : 0] wr_data;
    input wire wr_clk, wr_en;
    
    output wire [DATA_WIDTH - 1 : 0] rd_data;
    input  wire rd_clk, rd_en; 
    output wire rd_valid; 
    
    output wire full, empty; 
     
    input wire reset;
    
    /* Variables */
    
    wire [COUNTER_WIDTH - 1 : 0] wr_addr, rd_addr;
    
    wire [FIFO_DEPTH - 1 : 0] remapping_memory; 
    
    /* Functions */
    
    function integer clog2;
        input integer value;
    begin
        value = value-1;
        for (clog2=0; value>0; clog2=clog2+1)
            value = value>>1;
    end
    endfunction      

    /* Behavioral */
    
    // Write Address Generation
    counter #( .COUNTER_WIDTH(COUNTER_WIDTH) )
    wr_counter (
        .clk(wr_clk),
        .en(wr_en),
        .reset(reset),
        .addr(wr_addr)
    );
    
    // Read Address Generation
    counter #( .COUNTER_WIDTH(COUNTER_WIDTH) )
    rd_counter (
        .clk(rd_clk),
        .en(rd_en),
        .reset(reset),
        .addr(rd_addr)
    );    
    
    // Full Signal Generation
    signal_gen #( 
        .NUM_WIDTH(COUNTER_WIDTH),
        .NUM_VALUE(FIFO_DEPTH - 1)
    ) full_gen (
        .num(wr_addr),
        .signal(full)
    );
    
    // Empty Signal Generation
    signal_gen #( 
        .NUM_WIDTH(COUNTER_WIDTH),
        .NUM_VALUE(0)
    ) empty_gen (
        .num(rd_addr),
        .signal(empty)
    );    
    
    // Memory for Write Data
    wr_memory #(
        .WR_DATA_WIDTH(DATA_WIDTH),
        .WR_ADDR_WIDTH(COUNTER_WIDTH),
        .MEM_DEPTH(FIFO_DEPTH)
    ) wr_memory (
        .wr_data(wr_data),
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .remapping_memory(remapping_memory),
        .full(full),
        .reset(reset)
    );
    
    // Memory for Read Data
    rd_memory #(
        .RD_DATA_WIDTH(DATA_WIDTH),
        .RD_ADDR_WIDTH(COUNTER_WIDTH),
        .MEM_DEPTH(FIFO_DEPTH)
    ) rd_memory (
        .remapping_memory({wr_data, remapping_memory[FIFO_DEPTH - 2 : 0]}),
        .full(full),
        .rd_data(rd_data),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rd_addr(rd_addr),
        .reset(reset | full)
    );   
    
    // Read Valid Generation
    rd_valid_gen #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .COUNTER_WIDTH(COUNTER_WIDTH)
    ) rd_valid_gen (
        .full(full),
        .rd_clk(rd_clk),
        .reset(reset),
        .rd_valid(rd_valid)
    );

endmodule