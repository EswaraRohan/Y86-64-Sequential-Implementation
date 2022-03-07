module PC_UPDATE(valP,valC,valM,Cnd,icode,PC,PC__Update);
  input [63:0] valP; //Incremented PC
  input [63:0] valC; //Insruction Constant
  input [63:0] valM; //Value from Memory
  input Cnd;         //Branch Flag
  input [3:0] icode; //Instruction Code
  input [63:0] PC;   
  output reg [63:0] PC__Update;
  
  
  always@(*) begin 
    if (icode == 4'b0111) begin
      //jxx - jmp, jle, jl, je, jne, jge, and jg
      //Program Counter is set to Dest if branch is taken (Takes valC)
      //Otherwise PC is incremented by 9 (Takes valP) 
      
      if  (Cnd == 1'b1) begin
        PC__Update = valC;
      end
      else begin
        PC__Update = valP;
      end
    end
    
    if (icode == 4'b1000) begin
      //call
      //Program Counter is set to Dest (Takes valC)
      
      PC__Update = valC;
    end
    
    if (icode == 4'b1001) begin
      //ret
      //Program Counter is set to return address (Takes valP)
      
      PC__Update = valM;
    end
    
    else begin
      PC__Update = valP;
    end
  end   
endmodule
