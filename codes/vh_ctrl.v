`timescale 1ns / 1ps
//Khb

module vh_ctrl(
    input  wire  clk,   // pixel clock
    input  wire  rst_n,   // reset in pixel clock domain
    output reg   [x_width-1:0] sx,  // horizontal screen position
    output reg   [y_width-1:0] sy,  // vertical screen position
    output wire   hsync,     // horizontal sync
    output wire   vsync,     // vertical sync
    output wire   de         
    );
    //Horizontal_timings
    //parameter Active_Pixels=1280;
    //parameter HFront_Porch=110;
    //parameter HSync_Width=40;
    //parameter Total_Pixels=1650;
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

    // vertical timings
    //parameter Active_Lines=720;
    //parameter VFront_Porch=5;
    //parameter VSync_Width=5;
    //parameter Total_Lines=750;
    parameter Active_Lines=1080;
    parameter VFront_Porch=4;
    parameter VSync_Width=5;
    parameter Total_Lines=1125;
    parameter VA_END = Active_Lines-1;           // end of active pixels
    parameter VS_STA = VA_END + VFront_Porch;   // sync starts after front porch
    parameter VS_END = VS_STA + VSync_Width;    // sync ends
    parameter SCREEN = Total_Lines-1;           // last line on screen (after back porch)

    assign hsync = (sx >= HS_STA && sx < HS_END);
    assign vsync = (sy >= VS_STA && sy < VS_END); 
    assign de = (sx <= HA_END && sy <= VA_END);

    // calculate horizontal and vertical screen position
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sx <= 0;
            sy <= 0;
        end
        else if (sx == LINE) begin  // last pixel on line?
            sx <= 0;
            sy <= (sy == SCREEN) ? 0 : sy + 1;  // last line on screen?
        end else begin
            sx <= sx + 1;
        end
        
    end
    
    
    
endmodule
