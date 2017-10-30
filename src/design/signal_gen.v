module signal_gen (num, signal);

    /* Parameters */
    
    parameter NUM_WIDTH = 3;
    parameter NUM_VALUE = 7;
    
    /* Ports */
    
    input wire [NUM_WIDTH - 1 : 0] num;
    
    output wire signal;
    
    /* Behavioral */
    
    assign signal = (num == NUM_VALUE) ? 1'b1 : 1'b0;

endmodule