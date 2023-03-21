`timescale 1ns / 1ps
//KHB
//////////////////////////////////////////////////////////////////////////////////

module game(
input clk,
input rst_n,
input [2:0] switch_in,
input current_state,
input mv,
output reg [7:0] c_time_step,
output reg [7:0] best_score,

output reg [x_width-1:0] dong1x,
output reg [y_width-1:0] dong1y,
output reg [x_width-1:0] dong2x,
output reg [y_width-1:0] dong2y,
output reg [x_width-1:0] dong3x,
output reg [y_width-1:0] dong3y,
output reg [x_width-1:0] dong4x,
output reg [y_width-1:0] dong4y,
output reg [x_width-1:0] playerx,
output reg [y_width-1:0] playery,
//output reg strt,
output reg die
    );
    wire tch_dtcr;
    wire tch_dtcr1;
    wire tch_dtcr2;
    wire tch_dtcr3;
    wire tch_dtcr4;
    

    
    
    parameter dong_x = 5;
    parameter dong_y = 50;
    parameter human_x = 5;
    parameter human_y = 50;
    parameter Active_PixelsLow =  192;
    parameter Active_LinesLow= 1080;
    parameter x_width = $clog2(Active_PixelsLow*2);
    parameter y_width = $clog2(Active_LinesLow);
    //dongx set
    reg dong1yindex, dong1yindex2;
    reg dong2yindex, dong2yindex2;
    reg dong3yindex, dong3yindex2;
    reg dong4yindex, dong4yindex2;
    wire dong1yon;
    wire dong2yon;
    wire dong3yon;
    wire dong4yon;
    //touch detector assign
    assign tch_dtcr1 = ((playerx-human_x<=dong1x+dong_x)&&(playerx+human_x>=dong1x-dong_x))&&(playery-human_y<=dong1y+dong_y);
    assign tch_dtcr2 = ((playerx-human_x<=dong2x+dong_x)&&(playerx+human_x>=dong2x-dong_x))&&(playery-human_y<=dong2y+dong_y);
    assign tch_dtcr3 = ((playerx-human_x<=dong3x+dong_x)&&(playerx+human_x>=dong3x-dong_x))&&(playery-human_y<=dong3y+dong_y);
    assign tch_dtcr4 = ((playerx-human_x<=dong4x+dong_x)&&(playerx+human_x>=dong4x-dong_x))&&(playery-human_y<=dong4y+dong_y);
    assign tch_dtcr = tch_dtcr1||tch_dtcr2||tch_dtcr3||tch_dtcr4;
    //assign tch_dtcr = tch_dtcr1;
    assign dong1yon = dong1yindex&&!dong1yindex2;
    assign dong2yon = dong2yindex&&!dong2yindex2;
    assign dong3yon = dong3yindex&&!dong3yindex2;
    assign dong4yon = dong4yindex&&!dong4yindex2;
    //assign tch_dtcr = 0; 
    
    
    always @ (posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            best_score<=0;
        end
        else begin
            if(best_score< c_time_step)begin
                best_score<=c_time_step;
            end
        end
    end
    
    always @( posedge clk) begin
        dong1yindex2<=dong1yindex;
        dong2yindex2<=dong2yindex;
        dong3yindex2<=dong3yindex;
        dong4yindex2<=dong4yindex;
        if(dong1y==929)begin
            dong1yindex<=1;
        end
        else begin
            dong1yindex<=0;
        end
        
        if(dong2y==929)begin
            dong2yindex<=1;
        end
        else begin
            dong2yindex<=0;
        end
        
        if(dong3y==929)begin
            dong3yindex<=1;
        end
        else begin
            dong3yindex<=0;
        end
        
        if(dong4y==929)begin
            dong4yindex<=1;
        end
        else begin
            dong4yindex<=0;
        end
    end 
    
    //die assgin
    always @ (posedge clk or negedge rst_n)begin
        if(!rst_n)begin 
            die<=0;
            
        end
        else begin
            die<=tch_dtcr;
            
        end
    end



    //dongy 
    always @ (posedge clk or negedge rst_n)begin
        if(!rst_n||die||!current_state)begin
            dong1y<=100;
            dong2y<=100;
            dong3y<=100;
            dong4y<=100;
            c_time_step<=0; 
        end 
        else begin
            if(mv)begin
                if(dong1yon||dong1y>=929)begin
                    dong1y<=0;
                    c_time_step<=c_time_step+3;
                end
                else begin
                    dong1y<=dong1y+5+c_time_step*2;
                end
                
                if(dong2yon||dong2y>=929)begin
                    dong2y<=0;
                end
                else begin
                    dong2y<=dong2y+10+c_time_step*2;
                end
                
                if(dong3yon||dong3y>=929)begin
                    dong3y<=0;
                end
                else begin
                    dong3y<=dong3y+15+c_time_step*2;
                end
                
                if(dong4yon||dong4y>=929)begin
                    dong4y<=0;
                end
                else begin
                    dong4y<=dong4y+20+c_time_step*2;
                end
            end
        end
    end
    
    always @ (posedge clk or negedge rst_n)begin
        if(!rst_n||die||!current_state)begin
            dong1x<=10;
            dong2x<=60; 
            dong3x<=120; 
            dong4x<=180;  
        end 
        else begin
            if(mv)begin
                if(dong1x>=Active_PixelsLow)begin
                    dong1x<=10;
                end
                else if(dong1yon||dong1y>=929)begin
                    dong1x<=dong1x+35;
                end
                
                if(dong2x>=Active_PixelsLow)begin
                    dong2x<=20;
                end
                else if(dong2yon||dong2y>=929)begin
                    dong2x<=dong2x+47;
                end
                
                if(dong3x>=Active_PixelsLow)begin
                    dong3x<=30;
                end
                else if(dong3yon||dong3y>=929)begin
                    dong3x<=dong3x+13;
                end
                
                if(dong4x>=Active_PixelsLow)begin
                    dong4x<=10;
                end
                else if(dong4yon||dong4y>=929)begin
                    dong4x<=dong4x+52;
                end
            end
        end
    end
    
    
    
    always @ (posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            //playerx<= 15;
            playerx<= 96;
            playery<= 930-1;
        end
        else begin
            if(current_state==0)begin
                playerx<= 96;
                playery<= 930-1;
            end
            else begin
                if(playerx>=192||playerx<=0)begin
                    playerx<=playerx;
                end
                else begin
                    if(switch_in==1)begin
                        playerx<=playerx-5;
                    end
                    else if(switch_in==2)begin
                        playerx<=playerx+5;
                    end
                    else begin
                        playerx<=playerx;
                    end
                end
            end
        end
    end
    
endmodule
