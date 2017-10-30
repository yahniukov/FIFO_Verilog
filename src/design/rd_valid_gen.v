module rd_valid_gen( full, rd_clk, reset, rd_valid );
    
    /* Parameters */
    parameter FIFO_DEPTH = 8;
    parameter COUNTER_WIDTH = 3;
    
    /* Ports */
    
    input wire full;
    input wire rd_clk;
    input wire reset;
    
    output wire rd_valid;
    
    /* Variables */
    
    reg [COUNTER_WIDTH : 0] counter = 0;
    reg full_counter = 0;
    
    /* Behavioral */
    
    assign rd_valid = (counter < FIFO_DEPTH + 1) & full_counter & !full;
    
    always @(posedge full or posedge reset) begin
        if(reset)
            full_counter <= 0;
        else
            if(!full_counter)
                full_counter <= 1;
    end
    
    always @(posedge full or posedge rd_clk or posedge reset) begin
        if(reset) 
            counter <= 0;
        else begin
            if(full) 
                counter <= 0;
            else
                if(rd_valid)
                    counter <= counter + 1;
        end
    end
    
    
endmodule
