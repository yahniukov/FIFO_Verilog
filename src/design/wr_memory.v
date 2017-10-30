module wr_memory ( wr_data, wr_clk, wr_en, wr_addr,
                   remapping_memory,
                   full,
                   reset );
                            
    /* Parameters */
    
    parameter WR_DATA_WIDTH = 1;
    parameter WR_ADDR_WIDTH = 3;
    
    parameter MEM_DEPTH = 8;
         
    /* Ports */
    
    input wire [WR_DATA_WIDTH - 1 : 0] wr_data;
    input wire [WR_ADDR_WIDTH - 1 : 0] wr_addr;
    input wire                         wr_clk, wr_en;
    
    input wire full;
    
    output reg  [MEM_DEPTH - 1 : 0] remapping_memory;
    
    input wire reset;
    
    /* Variables */
    
    reg [WR_DATA_WIDTH - 1 : 0] memory [MEM_DEPTH - 1 : 0];
    
    integer i;
    
    /* Behavioral */
    
    always @(posedge wr_clk or posedge reset) begin
        if(reset)
            for(i = 0; i < MEM_DEPTH; i = i + 1)
                memory[i] <= 0;
        else 
            if(wr_en)
                memory[wr_addr] <= wr_data;
    end                            
                            
    always @(posedge full or posedge reset) begin
        if(reset)
            remapping_memory <= 0;
        else 
            for(i = 0; i < MEM_DEPTH; i = i + 1)
                remapping_memory[i] <= memory[i];
    end
                                
endmodule                            