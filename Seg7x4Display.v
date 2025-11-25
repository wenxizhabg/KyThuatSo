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
module BinToDec (in, out1, out0);
    input wire [6:0] in;
    output reg [3:0] out1, out0;
    
    always @(*) begin
        case (in)
            // --- T? 00 Ð?N 09 (Ch?c = 0) ---
            7'd0: begin out1 = 4'd0; out0 = 4'd0; end
            7'd1: begin out1 = 4'd0; out0 = 4'd1; end
            7'd2: begin out1 = 4'd0; out0 = 4'd2; end
            7'd3: begin out1 = 4'd0; out0 = 4'd3; end
            7'd4: begin out1 = 4'd0; out0 = 4'd4; end
            7'd5: begin out1 = 4'd0; out0 = 4'd5; end
            7'd6: begin out1 = 4'd0; out0 = 4'd6; end
            7'd7: begin out1 = 4'd0; out0 = 4'd7; end
            7'd8: begin out1 = 4'd0; out0 = 4'd8; end // B?t bu?c 4'd
            7'd9: begin out1 = 4'd0; out0 = 4'd9; end // B?t bu?c 4'd
            // --- T? 10 Ð?N 19 (Ch?c = 1) ---
            7'd10: begin out1 = 4'd1; out0 = 4'd0; end
            7'd11: begin out1 = 4'd1; out0 = 4'd1; end
            7'd12: begin out1 = 4'd1; out0 = 4'd2; end
            7'd13: begin out1 = 4'd1; out0 = 4'd3; end
            7'd14: begin out1 = 4'd1; out0 = 4'd4; end
            7'd15: begin out1 = 4'd1; out0 = 4'd5; end
            7'd16: begin out1 = 4'd1; out0 = 4'd6; end
            7'd17: begin out1 = 4'd1; out0 = 4'd7; end
            7'd18: begin out1 = 4'd1; out0 = 4'd8; end
            7'd19: begin out1 = 4'd1; out0 = 4'd9; end
            // --- T? 20 Ð?N 29 (Ch?c = 2) ---
            7'd20: begin out1 = 4'd2; out0 = 4'd0; end
            7'd21: begin out1 = 4'd2; out0 = 4'd1; end
            7'd22: begin out1 = 4'd2; out0 = 4'd2; end
            7'd23: begin out1 = 4'd2; out0 = 4'd3; end
            7'd24: begin out1 = 4'd2; out0 = 4'd4; end
            7'd25: begin out1 = 4'd2; out0 = 4'd5; end
            7'd26: begin out1 = 4'd2; out0 = 4'd6; end
            7'd27: begin out1 = 4'd2; out0 = 4'd7; end
            7'd28: begin out1 = 4'd2; out0 = 4'd8; end
            7'd29: begin out1 = 4'd2; out0 = 4'd9; end
            // --- T? 30 Ð?N 39 (Ch?c = 3) ---
            7'd30: begin out1 = 4'd3; out0 = 4'd0; end
            7'd31: begin out1 = 4'd3; out0 = 4'd1; end
            7'd32: begin out1 = 4'd3; out0 = 4'd2; end
            7'd33: begin out1 = 4'd3; out0 = 4'd3; end
            7'd34: begin out1 = 4'd3; out0 = 4'd4; end
            7'd35: begin out1 = 4'd3; out0 = 4'd5; end
            7'd36: begin out1 = 4'd3; out0 = 4'd6; end
            7'd37: begin out1 = 4'd3; out0 = 4'd7; end
            7'd38: begin out1 = 4'd3; out0 = 4'd8; end
            7'd39: begin out1 = 4'd3; out0 = 4'd9; end
            // --- T? 40 Ð?N 49 (Ch?c = 4) ---
            7'd40: begin out1 = 4'd4; out0 = 4'd0; end
            7'd41: begin out1 = 4'd4; out0 = 4'd1; end
            7'd42: begin out1 = 4'd4; out0 = 4'd2; end
            7'd43: begin out1 = 4'd4; out0 = 4'd3; end
            7'd44: begin out1 = 4'd4; out0 = 4'd4; end
            7'd45: begin out1 = 4'd4; out0 = 4'd5; end
            7'd46: begin out1 = 4'd4; out0 = 4'd6; end
            7'd47: begin out1 = 4'd4; out0 = 4'd7; end
            7'd48: begin out1 = 4'd4; out0 = 4'd8; end
            7'd49: begin out1 = 4'd4; out0 = 4'd9; end
            // --- T? 50 Ð?N 59 (Ch?c = 5) ---
            7'd50: begin out1 = 4'd5; out0 = 4'd0; end
            7'd51: begin out1 = 4'd5; out0 = 4'd1; end
            7'd52: begin out1 = 4'd5; out0 = 4'd2; end
            7'd53: begin out1 = 4'd5; out0 = 4'd3; end
            7'd54: begin out1 = 4'd5; out0 = 4'd4; end
            7'd55: begin out1 = 4'd5; out0 = 4'd5; end
            7'd56: begin out1 = 4'd5; out0 = 4'd6; end
            7'd57: begin out1 = 4'd5; out0 = 4'd7; end
            7'd58: begin out1 = 4'd5; out0 = 4'd8; end
            7'd59: begin out1 = 4'd5; out0 = 4'd9; end
            default: begin out1 = 4'd9; out0 = 4'd9; end
        endcase
    end
endmodule



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
            3'd0: seg[6] = 1'b1;
            3'd1: seg[8] = 1'b1;
            3'd2, 3'd4: seg[9] = 1'b1;
            3'd3: seg[12] = 1'b1;
            default: begin
                seg[6] = 1'bz;
                seg[8] = 1'bz;
                seg[9] = 1'bz;
                seg[12] = 1'bz;
            end
        endcase
        
        case (value)
            4'd0: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd1: begin
                seg[4] = 1'b0;
                seg[7] = 1'b0;
            end
            4'd2: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd3: begin
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd4: begin
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
            end
            4'd5: begin
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd6: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd7: begin
                seg[4] = 1'b0;
                seg[7] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd8: begin
                seg[1] = 1'b0;
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd9: begin
                seg[2] = 1'b0;
                seg[4] = 1'b0;
                seg[5] = 1'b0;
                seg[7] = 1'b0;
                seg[10] = 1'b0;
                seg[11] = 1'b0;
            end
            4'd10: seg[3] = 1'b0;
            default begin
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
    
    
    reg [9:0] counter;
    initial counter = 10'd0;
    /////// CÓ nhi?m v? xu?tc các giá tr? c?a h1 h0 m1 m0 colon ra seg
    always @(posedge clk) begin
        if (counter < 10'd499) counter <= counter + 1;
        else counter <= 10'd0;
        
        if (counter < 10'd9) begin           // Reset led
            digit <= 3'd5;
            value <= 4'd11;
        end
        else if (counter < 10'd99) begin
            digit <= 3'd0;
            value <= m0;
        end
        else if (counter < 10'd109) begin
            digit <= 3'd5;
            value <= 4'd11;
        end
        else if (counter < 10'd199) begin
            digit <= 3'd1;
            value <= m1;
        end 
        else if (counter <10'd209) begin
            digit <= 3'd5;
            value <= 4'd11;
        end
        else if (counter < 10'd299) begin
            digit <= 3'd2;
            value <= h0;
        end
        else if (counter < 10'd309) begin
            digit <= 3'd5;
            value <= 4'd11;
        end
        else if (counter < 10'd399) begin
            digit <= 3'd3;
            value <= h1;
        end
        else if (counter < 10'd409) begin
            digit <= 3'd5;
            value <= 4'd11;
        end
        else if (counter < 10'd499)
            if (colon) begin
                digit <= 3'd4;
                value <= 4'd10;
            end
        
    end
    
    
    
endmodule







module Seg7x4Display(clk, hour, minute, mode, seg);
    input wire clk;
    input wire [6:0] hour, minute;
    input wire [1:0] mode;
    output reg [12:1] seg;
    reg colon;
    reg [29:0] counter;
    
    initial counter <= 30'd0;
    
    reg [3:0] h1, h0, m1, m0;
    reg [3:0] buffH1, buffH0, buffM1, buffM0;
    BinToDec HourDecoder (.in(hour), .out1(buffH1), .out0(buffH0));
    BinToDec MinuteDecoder (.in(minute), .out1(buffM1), .out0(buffM0));
    
    always @(posedge clk) begin
        case (mode)
            2'd0: begin
                m1 <= buffM1;
                m0 <= buffM0;
                h1 <= buffH1;
                h0 <= buffH0;
                if (counter <30'd49999999) counter <= counter + 30'd1;
                else counter <= 30'd0;
                
                if (counter < 30'd24999999) colon <= 1'b1;
                else colon <= 1'b0;
            end
            
            2'd1: begin
                colon <= 1'b0;
                h1 <= buffH1;
                h0 <= buffH0;
                
                if (counter <30'd24_999_999 ) counter <= counter + 30'd1;
                else counter <= 30'd0;
                
                if (counter < 30'd12_499_999) begin
                    m1 <= buffM1;
                    m0 <= buffM0;
                end
                else begin
                    m1 <= 4'd11;
                    m0 <= 4'd11;
                end
            end
            
            2'd2: begin
                colon <= 1'b0;
                m1 <= buffM1;
                m0 <= buffM0;
                
                if (counter < 30'd24_999_999) counter <= counter + 30'd1;
                else counter <= 30'd0;
                
                if (counter < 30'd12_499_999) begin
                    h1 <= buffH1;
                    h0 <= buffH0;
                end
                else begin
                    h1 <= 4'd11;
                    h0 <= 4'd11;
                end
            end
        endcase
    end
    
    
    
    
    LedDecode LedDecoder (.clk(clk), .h1(h1), .h0(h0), .m1(m1), .m0(m0), .colon(colon), .seg(seg));
//<statements>

    
endmodule

