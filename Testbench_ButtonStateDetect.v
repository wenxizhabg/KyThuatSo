//////////////////////////////////////////////////////////////////////
// Created by Microsemi SmartDesign Sat Dec  6 18:39:11 2025
// Testbench Template
// This is a basic testbench that instantiates your design with basic 
// clock and reset pins connected.  If your design has special
// clock/reset or testbench driver requirements then you should 
// copy this file and modify it. 
//////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: TB.v
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

`timescale 100us    /1us

module TB;

parameter SYSCLK_PERIOD = 1;// 10KHz
parameter SEC = 10000;


reg SYSCLK;
reg NSYSRESET;
reg [1:0] state;
reg button;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b1;
end


//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  ButtonStateDetect
//////////////////////////////////////////////////////////////////////
ButtonStateDetect #(.MAX(10000)) ButtonStateDetect_0 (
    // Inputs
    .clk(SYSCLK),
    .reset(NSYSRESET),
    .button(button),

    // Outputs
    .state(state)

    // Inouts

);

initial begin
    button = 1;
    
    // Nhấn lâu hơn 1 giây 
    #SEC; button = 0;
    #(1.5*SEC); button = 1;
    
    
    // Nhấn trong 0.2 giây, nhấn ngắn
    #(0.5*SEC); button = 0;
    #(0.2*SEC); button = 1;
    
    // Nhấn dài trong 0.6 giây
    #(0.3*SEC); button = 0;
    #(0.6*SEC); button = 1;
    
    // Nút bị nẩy trong 0.2ms
    #(0.3*SEC); button = 0;
    #(0.2*SEC); button = 1;
    
    #SEC;
    $stop;
    
end

endmodule

