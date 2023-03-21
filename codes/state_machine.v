//Kang HB
`timescale 1ns / 1ps

module state_machine(
input clk,
input rst_n,
input [2:0]switch_in,
input die,
output reg current_state
);
    parameter main = 0;
    parameter gaming = 1;
    reg next_state;
    
  
    always @ (posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            current_state<=main;
        end
        else begin
            current_state<= next_state;
        end
    end

    always@(*)begin
        case(current_state)
            main : if(switch_in==3)begin
                next_state<=gaming;
            end
            else begin
                next_state<=main;
            end
            
            gaming : if(die)begin
                next_state<=main;
            end
            else begin
                next_state<= gaming;
            end
            
            default : next_state<= main;
        endcase     
    end


endmodule
