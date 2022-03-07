`include "ALU.v"

module Execute(icode,ifun,valA,valB,valC,valE,clk,cnd,ZF,SF,OF);
  parameter SIZE = 63 ;

  input [3:0] icode; //Instruction Code
  input [3:0] ifun;  //Instruction Function
  input signed [63:0] valA; //Register Value A
  input signed [63:0] valB; //Register Value B
  input signed [63:0] valC; //Instruction Constant
  input clk;         //Clock
  output reg [63:0] valE; //EXECUTION Result
  output reg cnd;        //1 bit signal which determine whether to take branch or not
  output reg ZF;         //Zero Flag
  output reg SF;         //Sign Flag
  output reg OF;		 //Overflow Flag
  reg in1,in2,in3,in4,in5,in6,in7;
  wire OUTP1,OUTP2,OUTP3,OUTP4;
  reg [1:0] CONTROL;
  reg signed [63:0] Input1;
  reg signed [63:0] Input2;
  reg signed [63:0] OP;
  wire signed [63:0] Output;
  wire OVERFLOW;
  
  not g1 (OUTP1,in1);
  or g2 (OUTP2,in2,in3);
  and g3 (OUTP3,in4,in5);
  xor g4 (OUTP4,in6,in7);
  
  initial begin
    ZF = 0;
    SF = 0;
    OF = 0;
    CONTROL = 2'b00;
    Input1 = 64'b0;
    Input2 = 64'b0;
  end
  
  
  ALU ALU_1(.OVERFLOW(OVERFLOW),.Output(Output),.CONTROL(CONTROL),.Input1(Input1),.Input2(Input2));
  
 
  always @(*) begin
    
    if (clk == 1) begin
      cnd = 0;
      if (icode == 4'b0010)
       begin //cmovXX-rrmovq,cmovle,cmovl,cmove,cmovne,cmovge,cmovg
        if (ifun == 4'b0000) 
        begin //rrmovq
          valE = valA + 64'd0;
          cnd = 1;
        end
        else if (ifun == 4'b0001) begin //cmovle - Less OR Equal (signed <=) - (SF ^ OF) | ZF
          valE = valA + 64'd0;
          in6 = SF;
          in7 = OF;
          if (OUTP4) begin
            cnd = 1;
          end
          else if (ZF) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0010) begin //cmovl - Move when Less - (SF ^ OF)
          valE = valA + 64'd0;
          in6 = SF;
          in7 = OF;
          if (OUTP4) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0011) begin //cmove - Move When Equal - ZF
          valE = valA + 64'd0;
          if (ZF) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0100) begin //cmovne - Move When Not Equal - ~ZF
          valE = valA + 64'd0;
          in1 = ZF;
          if (OUTP1) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0101) begin //cmovge - Move When Greater Than Or Equal -- ~(SF ^ OF)
          valE = valA + 64'd0;
          in6 = SF;
          in7 = OF;
          in1 = OUTP4;
          if (OUTP1) begin
            cnd = 1;
          end
        end 
        
        else if (ifun == 4'b0110) begin //cmovg - Move When Greater --  ~(SF ^ OF) & ~ZF
          valE = valA + 64'd0;
          in6 = SF;
          in7 = OF;
          in1 = OUTP4;
          if (OUTP1) begin
            in1 = ZF;
            if (OUTP1) begin
              cnd = 1;
            end
          end
        end
      end
     
      else if (icode == 4'b0011) begin //irmovq
        valE = valC + 64'd0;
      end
      
      else if (icode == 4'b0100) begin //rmmovq
        valE = valB + valC;
      end
      
      else if (icode == 4'b0101) begin //mrmovq
        valE = valB + valC;
      end
      
      else if (icode == 4'b0110) begin //OPq - Addition, Subtraction, AND, XOR
        
        ZF = (Output == 1'b0);
        SF = (Output < 1'b0);
        OF = (Input1 < 1'b0 == Input2 < 1'b0) && (Output < 1'b0 != Input1 < 1'b0);
        
        if (ifun == 4'b0000) begin //ADD
          CONTROL = 2'b00;
          Input1 = valA;
          Input2 = valB;
        end
        
        if (ifun == 4'b0001) begin //SUBTRACT
          CONTROL = 2'b01;
          Input1 = valA;
          Input2 = valB;
        end
        
        if (ifun == 4'b0010) begin //AND
          CONTROL = 2'b10;
          Input1 = valA;
          Input2 = valB;
        end
                
        if (ifun == 4'b0011) begin //XOR
          CONTROL = 2'b11;
          Input1 = valA;
          Input2 = valB;
        end
        
        OP = Output;
        valE = OP;
      end
      
      else if (icode == 4'b0111) begin //jxx- jmp, jle, jl, je, jne, jge, and jg
        if (ifun == 4'b0000) begin //jmp - Jump  Unconditionally
          cnd = 1;
        end
         
        else if (ifun == 4'b0001) begin //jle - Jump when Less than or equal -- (SF ^ OF) | ZF
          in6 = SF;
          in7 = OF;
          if (OUTP4) begin
            cnd = 1;
          end
          else if (ZF) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0010) begin //jl - Jump when Less -- (SF ^ OF)
          in6 = SF;
          in7 = OF;
          if (OUTP4) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0011) begin //je - Jump when Equal or Zero -- ZF
          if (ZF) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0100) begin //jne - Jump when not equal -- ~ZF
          in1 = ZF;
          if (OUTP1) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0101) begin //jge - Jump when greater than or equal -- ~(SF ^ OF)
          in6 = SF;
          in7 = OF;
          in1 = OUTP4;
          if (OUTP1) begin
            cnd = 1;
          end
        end
        
        else if (ifun == 4'b0110) begin //jg - Jump when Greater -- ~(SF ^ OF) & ~ZF
          in6 = SF;
          in7 = OF;
          in1 = OUTP4;
          if (OUTP1) begin
            in1 = ZF;
            if (OUTP1) begin
              cnd = 1;
            end
          end
        end  
      end
   
      else if (icode == 4'b1000) begin //Call
        valE = valB - 64'd8;
      end
      
      else if (icode == 4'b1001) begin //Ret
        valE = valB + 64'd8;
      end
      
      else if (icode == 4'b1010) begin //pushq
        valE = valB - 64'd8;
      end
      
      else if (icode == 4'b1011) begin //popq
        valE = valB + 64'd8;
      end
    end 
  end 
endmodule
