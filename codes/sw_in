//Kang HB
`timescale 1ns / 1ps

module switch_interface(
input clk,
input rst,
input btn1in,
input btn2in,
input btn3in,
input btn4in,
output reg [2:0]switch_out,
output reg rst_n
);

reg rstq1, rstq2;
reg btn1in1, btn1in2;
reg btn2in1, btn2in2;
reg btn3in1, btn3in2;
reg btn4in1, btn4in2;

wire fmscnt;
reg [19:00] mscnt ;
localparam ms = 625000;

wire rstd, btn1ind, btn2ind, btn3ind, btn4ind;
assign  rstd = (rstq1)&(~rstq2);
assign  btn1ind = (btn1in1)&(~btn1in2);
assign  btn2ind = (btn2in1)&(~btn2in2);
assign  btn3ind = (btn3in1)&(~btn3in2);
assign  btn4ind = (btn4in1)&(~btn4in2);

//5msclkgen
always @(posedge clk) begin
    if(fmscnt)begin
        if(rstd)begin
            mscnt<=0;
         end
         else begin
            mscnt<=mscnt;
         end
    end
    else begin
        mscnt<=mscnt+1;
        if(mscnt==ms-1)begin
            mscnt<=0;
        end
    end
end
assign fmscnt = (mscnt==ms-1) ? 1'b1:1'b0; 

always@(posedge clk) begin
    if(fmscnt) begin
        rstq1<=rst;
        rstq2<=rstq1;
        
        btn1in1<=btn1in;
        btn1in2<=btn1in1;
        
        btn2in1<=btn2in;
        btn2in2<=btn2in1;
        
        btn3in1<=btn3in;
        btn3in2<=btn3in1;
        
        btn4in1<=btn4in;
        btn4in2<=btn4in1;
       
    end
end

always@(posedge clk)begin
    if(fmscnt)begin
        if(rstd) begin
            rst_n<=0;
        end
        else begin
            rst_n<=1;
        end
        
        if(btn1ind) begin
            switch_out<= 3'd1;
        end
        else if(btn2ind) begin
            switch_out<= 3'd2;
        end
        else if(btn3ind) begin
            switch_out<= 3'd3;
        end
        else if(btn4ind) begin
            switch_out<= 3'd4;
        end
        else begin
            switch_out<= 3'd0;
        end
    end
end


endmodule
