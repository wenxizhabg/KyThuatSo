module ButtonStateDetect(clk,reset, button, state);
    input wire clk, button, reset;
    output reg [1:0] state;

    parameter MAX = 50_000_000;
//<statements>
    reg preButton;
    reg [29:0] counter;
    reg [29:0] subCounter;
    
    
    always @ (posedge clk) begin
        if (reset == 0) begin
            preButton   <= 1;
            counter     <= 1;
            subCounter  <= 1;
            state       <= 0;
        end
        else begin 
            preButton <= button;
            
            if (preButton == 1 && button == 0) counter <= 1;
            
            if (preButton == 0 && button == 0) begin
                if (counter < MAX) counter <= counter + 1;
                else begin
                    if (subCounter < MAX/10 ) subCounter <= subCounter + 1;
                    else begin
                        subCounter <= 1;
                        state <= 1;
                    end
                end
            end
            
            if (preButton == 0 && button == 1) begin
                if (counter > MAX/2) state <= 2;
                if (counter > MAX/2000) state <= 1;
            end
        end
    end
endmodule
