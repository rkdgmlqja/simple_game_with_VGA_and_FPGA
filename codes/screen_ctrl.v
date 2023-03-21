`timescale 1ns / 1ps
//Khb

module screen_ctrl(
    input clk,
    input rst_n,
    input current_state,
    input [x_width1-1:0] dong1x,
    input [y_width1-1:0] dong1y,
    input [x_width1-1:0] dong2x,
    input [y_width1-1:0] dong2y,
    input [x_width1-1:0] dong3x,
    input [y_width1-1:0] dong3y,
    input [x_width1-1:0] dong4x,
    input [y_width1-1:0] dong4y,
    input [x_width1-1:0] playerx,
    input [y_width1-1:0] playery,
    input [x_width-1:0] sx,  
    input [y_width-1:0] sy, 
    input de,
    input [7:0] c_time_step,
    input [7:0] best_score,
    output wire [3:0] Rout,
    output wire [3:0] Gout,
    output wire [3:0] Bout
    );
    reg [x_width-1:0] posx;
    reg [y_width-1:0] posy;
    parameter total_pixel=1920;
    parameter total_line=1080;
    parameter box_size = 350;
    parameter x_width = $clog2(Total_Pixels-1);
    parameter y_width = $clog2(Total_Lines-1);
    parameter Total_Pixels=2200;
    parameter Total_Lines=1125;
    parameter strt_pntx = total_pixel/2-box_size/2-1;
    parameter strt_pnty = total_line/2-box_size/2-1;
    parameter end_pntx = total_pixel-box_size-1-10;
    parameter end_pnty = total_line-box_size-1-10;
    
    
    parameter dong_x = 50;
    parameter dong_y = 50;
    parameter human_x = 50;
    parameter human_y = 50;
    parameter Active_PixelsLow =  192;
    parameter Active_LinesLow= 1080;
    parameter x_width1 = $clog2(Active_PixelsLow*2);
    parameter y_width1 = $clog2(Active_LinesLow);
    
    
//    always@(posedge clk)begin
//        hsout<=hsync;
//        vsout<=vsync;
//    end
    wire dongon1, dongon2, dongon3,dongon4, dongon;
    wire playeron;
    wire groundon;
    wire scoreon;
    wire bscoreon;
    
    assign dongon1 = ((sx>=dong1x*10-dong_x)&&(sx<=dong1x*10+dong_x))&&((sy>=dong1y-dong_y)&&(sy<=dong1y+dong_y));
    assign dongon2 = ((sx>=dong2x*10-dong_x)&&(sx<=dong2x*10+dong_x))&&((sy>=dong2y-dong_y)&&(sy<=dong2y+dong_y));
    assign dongon3 = ((sx>=dong3x*10-dong_x)&&(sx<=dong3x*10+dong_x))&&((sy>=dong3y-dong_y)&&(sy<=dong3y+dong_y));
    assign dongon4 = ((sx>=dong4x*10-dong_x)&&(sx<=dong4x*10+dong_x))&&((sy>=dong4y-dong_y)&&(sy<=dong4y+dong_y));
    
    assign dongon = dongon1||dongon2||dongon3||dongon4;
    
    assign playeron = ((sx>=playerx*10-human_x)&&(sx<=playerx*10+human_x))&&((sy>=playery-human_y)&&(sy<=playery+human_y));
    
    assign groundon = (sy>=980);
    
    assign scoreon = (sy>=30&&sy<=60&&sx>=30&&sx<=60+15*(c_time_step));
    
    assign bscoreon = (sy>=300&&sy<=330&&sx>=50&&sx<=80+15*(best_score));

//    assign Rout[0]=(de&&dongon);
//    assign Rout[1]=(de&&dongon);
//    assign Rout[2]=(de&&dongon);
//    assign Rout[3]=(de&&dongon);
    
//    assign Gout[0]=(de&&playeron);
//    assign Gout[1]=(de&&playeron);
//    assign Gout[2]=(de&&playeron);
//    assign Gout[3]=(de&&playeron);
    
//    assign Bout[0]=(de&&groundon);
//    assign Bout[1]=(de&&groundon);
//    assign Bout[2]=(de&&groundon);
//    assign Bout[3]=(de&&groundon);
    
    
    assign Rout[0]=(de&&current_state&&(dongon||scoreon))||(!current_state&&bscoreon);
    assign Rout[1]=(de&&current_state&&(dongon||scoreon))||(!current_state&&bscoreon);
    assign Rout[2]=(de&&current_state&&(dongon||scoreon))||(!current_state&&bscoreon);
    assign Rout[3]=(de&&current_state&&(dongon||scoreon))||(!current_state&&bscoreon);
    
    assign Bout[0]=(de&&current_state&&(playeron||scoreon))||(!current_state&&bscoreon);
    assign Bout[1]=(de&&current_state&&(playeron||scoreon))||(!current_state&&bscoreon);
    assign Bout[2]=(de&&current_state&&(playeron||scoreon))||(!current_state&&bscoreon);
    assign Bout[3]=(de&&current_state&&(playeron||scoreon))||(!current_state&&bscoreon);
    
    assign Gout[0]=(de&&current_state&&(groundon||scoreon))||(!current_state&&bscoreon);
    assign Gout[1]=(de&&current_state&&(groundon||scoreon))||(!current_state&&bscoreon);
    assign Gout[2]=(de&&current_state&&(groundon||scoreon))||(!current_state&&bscoreon);
    assign Gout[3]=(de&&current_state&&(groundon||scoreon))||(!current_state&&bscoreon);
    
endmodule
