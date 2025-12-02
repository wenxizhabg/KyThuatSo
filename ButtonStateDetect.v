///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ButtonStateDetect.v
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

//`timescale <time_units> / <precision>

module ButtonStateDetect(clk,reset, button, state);
    input wire clk, button, reset;
    output reg [1:0] state;

    parameter FREQ_CLK = 30'd50_000_000;
//<statements>
    reg preButton;
    reg [29:0] counter;
    reg [29:0] counter10Hz;
    
    
    always @ (posedge clk) begin
        if (reset == 1'b0) begin
            preButton   <= 1'b1;
            counter     <= 30'd0;
            counter10Hz <= 23'd0;
            state       <= 2'd0;
        end
        else begin 
            preButton <= button;
            state <= 2'd0;
            
            if (preButton == 1'b1 && button == 1'b0) counter <= 0;
            
            if (preButton == 1'b0 && button == 1'b0) begin
                if (counter < FREQ_CLK - 30'd1) counter <= counter + 1;
                else begin
                    if (counter10Hz < FREQ_CLK/10 - 30'd1) counter10Hz <= counter10Hz + 23'd1;
                    else begin
                        counter10Hz <= 30'd0;
                        state <= 2'd1;
                    end
                end
            end
            
            if (preButton == 1'b0 && button == 1'b1) begin
                if (FREQ_CLK/10 < counter && counter < FREQ_CLK-1) state <= 2'd2;
                if (FREQ_CLK/2000 < counter && counter < FREQ_CLK/10 - 1) state <= 2'd1;
            end
        end
    end
endmodule

