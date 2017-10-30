module signal_gen_testbench ( );

    /* Parameters */
    
    parameter NUM_WIDTH = 3;
    parameter NUM_VALUE = 7;
    
    /* Variables */
    
    reg [NUM_WIDTH - 1 : 0] num = 0;
    reg clk = 0;
    
    wire signal;
    
    /* Behavioral */
    
    // Signal Generator Instance
    signal_gen #(
        .NUM_WIDTH(NUM_WIDTH),
        .NUM_VALUE(NUM_VALUE)
    ) signal_gen_inst (
        .num(num),
        .signal(signal)
    );
    
    // Clock Generation
    always
        #5 clk = !clk;
        
    // Number Generation
    always @(posedge clk)
        num <= num + 1;


endmodule