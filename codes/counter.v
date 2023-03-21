`timescale 1ns / 1ps
//Kang

module counter(
    input clk,
    input rst_n,
    input current_state,
    output wire mv
//    output reg [7:0] c_time_step
    );
    parameter max_num = 148*1000*50-1;
    parameter cnt2mxnum = 1920;
    parameter cnt_width = $clog2(max_num);
    parameter cnt_width2 = $clog2(cnt2mxnum);
    reg [cnt_width-1:0] cnt;
//    reg [cnt_width2-1:0] cnt2;
    reg cnton,cnton1;
    assign mv=cnton&&!cnton1;
    always @ (posedge clk or negedge rst_n)begin
        cnton1<=cnton;
        if(!rst_n)begin
            cnt<=0;
            cnton<=0;
        end
        else begin
        
            if(cnt>=max_num)begin
                cnton<=1;
            end
            else begin
                cnton<=0;
            end
            if(cnt>=max_num)begin
                cnt<=0;
            end
            else begin
                cnt<=cnt+1;
            end
        end 
    end
    
//    always @ (posedge clk or negedge rst_n)begin
//        if(!rst_n||current_state==0)begin
//            cnt2<=0;
//            c_time_step<=0;
//        end
//        else begin
//            if(cnt2==1000-1)begin
//                cnt2<=0;
//                c_time_step<=c_time_step+1;
//            end
//            else if(cnt>=max_num)begin
//                cnt2<=cnt2+1;
//            end
//        end
//    end
    
endmodule
