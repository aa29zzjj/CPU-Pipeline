`timescale 1ns / 1ps

module BHT(
    input clk,
    input [31:0] PC,
    output Prediction,
    input DoUpdate,
    input [31:0] UpdatePC,
    input UpdateDirection
    );
   // dummy code
  
   
    // Your code here
   reg [1: 0]  HTable [2047:0];
   wire [10:0] LookupIndex;
   wire [10:0] UpdateIndex;
   
    assign LookupIndex = PC[12: 2];
    assign UpdateIndex = UpdatePC[12:2];
    
    wire [1:0] initialUpdateValue;
    assign initialUpdateValue = HTable[UpdateIndex];
    assign Prediction = HTable[LookupIndex][1];
    
    always @ (posedge clk)
    begin
        if(DoUpdate)
        begin
            if(UpdateDirection)
            begin
            if(2'b11 == initialUpdateValue)
            begin
                HTable[UpdateIndex]<=2'b11;
            end
            else
            begin
                HTable[UpdateIndex] <= initialUpdateValue + 1;
            end
            end
            else
            begin
            if(2'b00 == initialUpdateValue)
            begin
            HTable[UpdateIndex] <= 2'b00;
            end
            else
            begin
                HTable[UpdateIndex] <= initialUpdateValue - 1;
             end
             end
          end
          end
             
         integer x;
         initial
         begin
         for (x=0; x < 32; x = x+1) HTable[x] <= 2'b10;
         end
endmodule