///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Seg7x4Display.v
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



module LedDecodeDigit (digit, value, seg);
    input wire [2:0] digit;
    input wire [3:0] value;
    output reg [12:1] seg;    
    // digit = 4 và value = 10 nghia là d?u colon
    // digit >4 và value >10 là reset
    // Led khi chân 9 m?c 1 và chân 3 m?c 0 là sáng d?u colon
    
    always @(*) begin
        seg = 12'bz;
        case (digit)
            0: seg[6] = 1'b1;
            1: seg[8] = 1'b1;
            2, 4: seg[9] = 1'b1;
            3: seg[12] = 1'b1;
            default: begin
                seg[6] = 1'bz;
                seg[8] = 1'bz;
                seg[9] = 1'bz;
                seg[12] = 1'bz;
            end
        endcase
        
        case (value)
            0: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            1: begin
                seg[4] = 1'b0;
                seg[7] = 1'b0;
            end
            2: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[11] = 1'b0;
            end
            3: begin
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[11] = 1'b0;
            end
            4: begin
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
            end
            5: begin
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            6: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            7: begin
                seg[4] = 1'b0;
                seg[7] = 1'b0;
                seg[11] = 1'b0;
            end
            8: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            9: begin
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            10: seg[3] = 1'b0;
            default: begin
                seg[1] = 1'bz;
                seg[2] = 1'bz;
                seg[3] = 1'bz;
                seg[4] = 1'bz;
                seg[5] = 1'bz;
                seg[7] = 1'bz;
                seg[10] = 1'bz;
                seg[11] = 1'bz;
            end
        endcase
    end
endmodule

module LedDecode (clk, h1, h0, m1, m0, colon, seg);
    input wire [3:0] h1, h0, m0, m1;
    input wire colon, clk;
    output reg [12:1] seg;
    
    reg [2:0] digit;
    reg [3:0] value;
    LedDecodeDigit LedDigitDecoder (.digit(digit), .value(value), .seg(seg));
    
    parameter  PER = 500;
    
    reg [9:0] counter;
    initial counter = 0;

    always @(posedge clk) begin
    
        if (counter < PER) counter <= counter + 1;
        else counter <= 1;
        
        if (counter < PER/5*1) begin
            digit <= 0;
            value <= m0;
        end
        else if (counter < PER/5*2) begin
            digit <= 1;
            value <= m1;
        end
        else if (counter < PER/5*3) begin
            digit <= 2;
            value <= h0;
        end
        else if (counter < PER/5*4) begin
            digit <= 3;
            value <= h1;
        end
        else if (counter < PER/5*5)
            if (colon) begin
                digit <= 4;
                value <= 10;
            end
            else begin 
                digit <= 5;
                value <= 11;
            end
    end
    
    
endmodule

module Seg7x4Display(clk, h1, h0, m1, m0, mode, seg);
    input wire clk;
    input wire [3:0] h1, h0, m1,m0;
    input wire [1:0] mode;
    output reg [12:1] seg;
    
    reg colon;
    reg [29:0] counter;
    
    parameter MAX = 50_000_000;

    reg [3:0] buffH1, buffH0, buffM1, buffM0;
    LedDecode LedDecoder (.clk(clk), .h1(buffH1), .h0(buffH0), .m1(buffM1), .m0(buffM0), .colon(colon), .seg(seg));

    always @(posedge clk) begin
        case (mode)
            2'd0: begin
                buffM1 <= m1;
                buffM0 <= m0;
                buffH1 <= h1;
                buffH0 <= h0;
                if (counter < MAX) counter <= counter + 1;
                else counter <= 1;
                
                if (counter < MAX/2) colon <= 0;
                else colon <= 1;
            end
            
            2'd1: begin
                buffH1 <= h1;
                buffH0 <= h0;
                colon <= 0;
                
                if (counter < MAX/2) counter <= counter + 1;
                else counter <= 1;
                
                if (counter < MAX/4) begin
                    buffM1 <= 11;
                    buffM0 <= 11;
                end
                else begin
                    buffM1 <= m1;
                    buffM0 <= m0;
                end
            end
                
            2'd2: begin
                colon <= 1'b0;
                buffM1 <= m1;
                buffM0 <= m0;
                
                if (counter < MAX/2) counter <= counter + 1;
                else counter <= 1;
                
                if (counter < MAX/4) begin
                    buffH1 <= 11;
                    buffH0 <= 11;
                end
                else begin
                    buffH1 <= h1;
                    buffH0 <= h0;
                end
            end
        endcase
    end    
endmodule

