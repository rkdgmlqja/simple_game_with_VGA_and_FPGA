`timescale 1ns / 1ps
//Kang

module top(
    input wire clkt,
    input wire rstt,
    input wire sw1,
    input wire sw2,
    input wire sw3,
    input wire sw4,
    output wire [0:3]Rout,
    output wire [0:3]Gout,
    output wire [0:3]Bout,
    output wire hsyncout,
    output wire vsyncout
    );
    ///vhctr prmtr
    parameter x_width = $clog2(LINE);
    parameter y_width = $clog2(SCREEN);
   
    parameter Active_Pixels=1920;
    parameter HFront_Porch=88;
    parameter HSync_Width=44;
    parameter Total_Pixels=2200;
    parameter HA_END = Active_Pixels-1;           // end of active pixels
    parameter HS_STA = HA_END + HFront_Porch;   // sync starts after front porch
    parameter HS_END = HS_STA + HSync_Width;   // sync ends
    parameter LINE   = Total_Pixels-1;           // last pixel on line (after back porch)

    parameter Active_Lines=1080;
    parameter VFront_Porch=4;
    parameter VSync_Width=5;
    parameter Total_Lines=1125;
    parameter VA_END = Active_Lines-1;           // end of active pixels
    parameter VS_STA = VA_END + VFront_Porch;   // sync starts after front porch
    parameter VS_END = VS_STA + VSync_Width;    // sync ends
    parameter SCREEN = Total_Lines-1;   

    
    wire rst_n;
    wire [2:0] switch_top;
    wire [x_width-1:0] sxt;
    wire [y_width-1:0]  syt;
    wire hsync_mid;
    wire vsync_mid;
    wire de_mid;
    
    wire current_state;
    wire die;
    wire mv;
    
    parameter Active_PixelsLow =  192;
    parameter Active_LinesLow= 1080;
    parameter x_width2 = $clog2(Active_PixelsLow*2);
    parameter y_width2 = $clog2(Active_LinesLow);
    wire [x_width2-1:0] dong1x;
    wire [y_width2-1:0] dong1y;
    wire [x_width2-1:0] dong2x;
    wire [y_width2-1:0] dong2y;
    wire [x_width2-1:0] dong3x;
    wire [y_width2-1:0] dong3y;
    wire [x_width2-1:0] dong4x;
    wire [y_width2-1:0] dong4y;
    wire [x_width2-1:0] playerx;
    wire [y_width2-1:0] playery;
    
    wire [7:0] c_time_step;
    wire [7:0] best_score;
    
    counter cnt(
        .clk(clkt),
        .rst_n(rst_n),
        .mv(mv)
        
    );
    
    switch_interface si(
        .clk(clkt),
        .rst(rstt),
        .rst_n(rst_n),
        .btn1in(sw1),
        .btn2in(sw2),
        .btn3in(sw3),
        .btn4in(sw4),
        .switch_out(switch_top)
    );
    
    vh_ctrl vc(
        .clk(clkt),
        .rst_n(rst_n),
        .sx(sxt),
        .sy(syt),
        .hsync(hsyncout),
        .vsync(vsyncout),
        .de(de_mid)
    );
    
    state_machine sm(
        .clk(clkt),
        .rst_n(rst_n),
        .current_state(current_state),
        .die(die),
        .switch_in(switch_top)
    );
    
    game gm(
        .clk(clkt),
        .rst_n(rst_n),
        .switch_in(switch_top),
        .current_state(current_state),
        .dong1x(dong1x),
        .dong1y(dong1y),
        .dong2x(dong2x),
        .dong2y(dong2y),
        .dong3x(dong3x),
        .dong3y(dong3y),
        .dong4x(dong4x),
        .dong4y(dong4y),
        .playerx(playerx),
        .playery(playery),
        .die(die),
        .mv(mv),
        .c_time_step(c_time_step),
        .best_score(best_score)
    );
    
    screen_ctrl sc(
        .clk(clkt),
        .rst_n(rst_n),
        .current_state(current_state),
        .dong1x(dong1x),
        .dong1y(dong1y),
        .dong2x(dong2x),
        .dong2y(dong2y),
        .dong3x(dong3x),
        .dong3y(dong3y),
        .dong4x(dong4x),
        .dong4y(dong4y),
        .playerx(playerx),
        .playery(playery),
        .sx(sxt),
        .sy(syt),
        .de(de_mid),
        .Rout(Rout),
        .Gout(Gout),
        .Bout(Bout),
        .c_time_step(c_time_step),
        .best_score(best_score)
    );
    
    
    
endmodule
