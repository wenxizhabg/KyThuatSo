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
//
// Targeted device: <Family::PolarFireSoC> <Die::MPFS095T> <Package::FCSG325>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module ButtonStateDetect(clk, reset, button, state);
    input wire clk, button, reset;     // Clock 50MHz
    output reg [1:0] state;

//<statements>
    reg preButton;
    reg [29:0] counter;
    reg [29:0] counter4Hz;
    
    
    
    always @ (posedge clk) begin
        if (reset == 1'b0) begin
            preButton   <= 1'b1;
            counter     <= 30'd0;
            counter4Hz  <= 30'd0;
            state       <= 2'b0;
        end
        else begin 
            preButton <= button;
            state <= 2'b0;
            
            if (preButton == 1'b1 && button == 0) counter <= 0; // su?n xu?ng
            if (preButton == 1'b0 && button == 1'b0) begin    /// dang gi? m?c tích c?c
                if (counter < 30'd49_999_999) counter <= counter + 1; // gi? ít hon 2 s
                else begin  // gi? hon 3 s
                    if (counter4Hz < 30'd5_999_999) counter4Hz <= counter4Hz + 30'd1;
                    else begin
                        counter4Hz <= 0;
                        state <= 2'd1;
                    end
                end
                
            end 
            
            if (preButton == 1'b0 && button == 1'b1) begin
                if (counter < 30'd49_999_999 )
                    if (counter > 30'd24_999_999) state <= 2'd2;
                    else if (counter > 30'd49_999) state <= 2'd1;
                end
        end
    end
endmodule

