module counter_testbench ( );

    /* Parameters */
    
    parameter COUNTER_WIDTH = 3;
    
    /* Variables */
    
    reg clk = 0, en = 1, reset = 0;
    
    wire [COUNTER_WIDTH - 1 : 0] addr = 0;  
    
    /* Behavioral */
    
    // Counter Instance
    counter #( .COUNTER_WIDTH(COUNTER_WIDTH))
    counter_inst (
        .clk(clk),
        .en(en),
        .reset(reset),
        .addr(addr)
    );  
    
    // Clock Generation
    always
        #5 clk = !clk;
        
    // Reset Generation
    initial begin
        #2 reset = 1;
        #2 reset = 0;
    end    


endmodule