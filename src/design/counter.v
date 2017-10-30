module counter ( clk, en, reset, addr );

    /* Parameters */
    
    parameter COUNTER_WIDTH = 3;
    
    /* Ports */
    
    input wire clk, en, reset;
    
    output reg [COUNTER_WIDTH - 1 : 0] addr = 0;
    
    /* Behavioral */
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            addr <= 0;
        else 
            if(en)
                addr <= addr + 1;
    end


endmodule