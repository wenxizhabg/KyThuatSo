//////////////////////////////////////////////////////////////////////
// Created by Microsemi SmartDesign Sat Dec  6 20:56:33 2025
// Testbench Template
// This is a basic testbench that instantiates your design with basic 
// clock and reset pins connected.  If your design has special
// clock/reset or testbench driver requirements then you should 
// copy this file and modify it. 
//////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: tb.v
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

`timescale 100ms/1ms

module tb;

parameter SYSCLK_PERIOD = 1;// 10Hz
parameter SEC = 10;
parameter MIN = 60*SEC;
parameter HOUR = 60*MIN;
parameter DAY = 24*HOUR;



reg SYSCLK;
reg NSYSRESET;

reg [3:0] h1, h0, m1, m0;
reg [1:0] state, mode;

initial
begin
    SYSCLK = 0;
    NSYSRESET = 0;
    state = 0;
end

//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  TimeCounter
//////////////////////////////////////////////////////////////////////
TimeCounter #(.MAX(10)) TimeCounter_0 (
    // Inputs
    .clk(SYSCLK), .reset(NSYSRESET), .buttonState(state),
    // Outputs
    .h1(h1), .h0(h0), .m1(m1), .m0(m0), .mode(mode)
);

  initial begin
      #(SYSCLK_PERIOD * 10 * SEC) NSYSRESET = 1;
  
      // Chỉnh thành 23:59;
      // Nhấn lâu 1 lần => chỉnh phút;
      state = 2;#1;
      state = 0;#9;
      
      // Nhấn ngắn 59 lần 
      state = 1; #59;
      state = 0; #1;
      
      // Nhấn lâu 1 lần => chỉnh giờ;
      state = 2; #1;
      state = 0; #9;
      
      // Nhấn ngắn 23 lần 
      state = 1; #23;
      state = 0; #7;
      
      // Nhấn lâu 1 lần => Đếm thời gian
      state = 2; #1;
      state = 0; #9;
      
      
      // Chạy 1 phút => 00:00
      #MIN;
      
      // Chạy 1 tiếng => 01:00
      #HOUR;
      
      // Chạy 1 Ngày => 01:00
      #DAY;
      
  end

endmodule

