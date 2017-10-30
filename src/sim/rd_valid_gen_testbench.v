module rd_valid_gen_testbench ( );

    /* Parameters */
    
    parameter FIFO_DEPTH = 8;
    parameter COUNTER_WIDTH = 3;
    
    /* Variables */
    
    reg full = 0;
    reg rd_clk = 0;
    reg reset = 0;
    
    wire rd_valid;
    
    /* Behavioral */
    
    // Read Valid Generator Instance
    rd_valid_gen #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .COUNTER_WIDTH(COUNTER_WIDTH)
    ) rd_valid_gen_inst (
        .full(full),
        .rd_clk(rd_clk),
        .reset(reset),
        .rd_valid(rd_valid)
    );
    
    // Read Clock Generation
    always
        #5 rd_clk = !rd_clk & !full;
        
    // Reset and Full Generation
    initial begin
        #2 reset = 1;
        #2 reset = 0;
        
        #30 full = 1;
        #10 full = 0;
        
        #110 full = 1;
        #10  full = 0;
    end

endmodule