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

//`timescale <time_units> / <precision>

module TimeCounter(clk, reset, buttonState, hour, minute, mode);
    input wire clk, reset;
    input wire [1:0] buttonState;        //0: Không nh?n, 1 là nh?n trong 20ms, 2 là nh?n trong 3 giây
    output reg [6:0] hour, minute;
    reg [6:0] second;
    output reg [1:0] mode; // 0: Ðang d?m, 1: S?a phút, 2: S?a giây
    
//<statements> 
    reg [25:0] counter;
        
    
    always @(posedge clk) begin
        if (reset == 1'b0) begin
            hour <= 7'd0;
            minute <= 7'd0;
            second <= 7'd0;
            counter <= 7'd0;
            mode <= 2'd0;
        end else
        
        case (mode)
            2'd0: begin
                if (buttonState == 2'd2) mode <= 2'd1;
                if (counter < 26'd49_999_999) counter <= counter + 26'd1;
                else begin
                    counter <= 0;
                    if (second < 7'd59) second <= second + 7'd1;
                    else begin
                        second <= 0;
                        if (minute < 7'd59) minute <= minute + 7'd1;
                        else begin
                            minute <= 7'd0;
                            if (hour < 7'd23) hour <= hour + 7'd1;
                            else hour <= 7'd0;
                        end
                    end
                end
            end
            
            2'd1: begin
                if (buttonState == 2'd2) mode <= 2'd2;
                
                if (buttonState == 2'd1) begin
                    if (minute < 7'd59) minute <= minute + 7'd1;
                    else minute <= 7'd0;
                end
            end
            
            2'd2: begin
                if (buttonState == 2'd2) begin
                    second <= 7'd0;
                    mode <= 2'd0;
                    
                end
                if (buttonState == 2'd1) begin
                    if (hour < 7'd23) hour <= hour + 7'd1;
                   else hour <= 7'd0; 
                end
            end
        endcase
    end
endmodule

