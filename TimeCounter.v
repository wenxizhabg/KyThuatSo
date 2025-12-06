///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: TimeCounter.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFireSoC> <Die::MPFS095T> <Package::FCSG325>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

module TimeCounter(clk, reset, buttonState, h1, h0, m1, m0, mode);
    input wire clk, reset;
    input wire [1:0] buttonState;
    output reg [3:0] h1, h0, m1, m0;
    output reg [1:0] mode;
    
    parameter MAX = 50_000_000;
    reg [25:0] counter;
    reg [5:0] second;
    
    always @(posedge clk) begin
        if (reset == 0) begin
            h1 <= 0; h0 <= 0;
            m1 <= 0; m0 <= 0;
            second <= 0;
            counter <= 1;
            mode <= 0;
        end
        
        else case (mode)
            0: begin
                if (buttonState == 2) mode <= 1;
                if (counter < MAX) counter <= counter + 1;
                else begin
                    counter <= 1;
                    if (second < 59) second <= second + 1;
                    else begin
                        second <= 0;
                        if (m0 < 9) m0 <= m0 + 1;
                        else begin 
                            m0 <= 0;
                            if (m1 < 5) m1 <= m1 + 1;
                            else begin
                                m1 <= 0;
                                if (h1 == 2 && h0 == 3) begin
                                    h1 <= 0;
                                    h0 <= 0;
                                end 
                                else begin
                                    if (h0 < 9) h0 <= h0 + 1;
                                    else begin
                                        h0 <= 0;
                                        h1 <= h1 + 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            1: begin
                if (buttonState == 2) mode <= 2;
                if (buttonState == 1) begin
                    if (m0 < 9) m0 <= m0 + 1;
                    else begin
                        m0 <= 0;
                        if (m1 < 5) m1 <= m1 + 1;
                        else m1 <= 0; 
                    end
                end
            end
            
            2'd2: begin
                if (buttonState == 2) begin
                    second <= 0;
                    mode <= 0;
                end
                if (buttonState == 1) begin
                    if (h1 == 2 && h0 == 3) begin
                        h1 <= 0;
                        h0 <= 0;
                    end 
                    else begin
                        if (h0 < 9) h0 <= h0 + 1;
                        else begin
                            h0 <= 0;
                            h1 <= h1 + 1;
                        end
                    end
                end
            end
        endcase
    end
endmodule

