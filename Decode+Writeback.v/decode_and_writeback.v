module decode_and_writeback(valA , valB , valE , valM , clk , rA , rB , icode , cnd , register_memory0 , register_memory1 , register_memory2 ,register_memory3 , register_memory4 , register_memory5 ,register_memory6 ,register_memory7 ,register_memory8 , register_memory9 , register_memory10 ,register_memory11 , register_memory12 , register_memory13 , register_memory14) ;

parameter register_size = 14 ;

input clk ;
input [3:0] rA ;
input [3:0] rB ;
input cnd ;
input signed [63:0] valE ;
input signed [63:0] valM ;

input [3:0] icode ;
reg signed [63:0] register_memory[0:14] ;
assign rsp = 64'd4 ;
//assign rsp = 64'd4 ;


// If we were to consider that we have 15 register_memorys from %rax to %r14, the stack pointer is %rsp and it is in the 4th place

output reg signed [63:0] valA ;
output reg signed [63:0] valB ;


  output reg signed [63:0] register_memory0;
  output reg signed [63:0] register_memory1;
  output reg signed [63:0] register_memory2;
  output reg signed [63:0] register_memory3;
  output reg signed [63:0] register_memory4;
  output reg signed [63:0] register_memory5;
  output reg signed [63:0] register_memory6;
  output reg signed [63:0] register_memory7;
  output reg signed [63:0] register_memory8;
  output reg signed [63:0] register_memory9;
  output reg signed [63:0] register_memory10;
  output reg signed [63:0] register_memory11;
  output reg signed [63:0] register_memory12;
  output reg signed [63:0] register_memory13;
  output reg signed [63:0] register_memory14;

// Decode stage

initial begin
    register_memory[0] = 64'd20;
    register_memory[1] = 64'd21;
    register_memory[2] = 64'd54;
    register_memory[3] = 64'd1;
    register_memory[4] = 64'd31;
    register_memory[5] = 64'd63;
    register_memory[6] = 64'd12;
    register_memory[7] = 64'd95;
    register_memory[8] = 64'd72;
    register_memory[9] = 64'd52;
    register_memory[10] = 64'd3;
    register_memory[11] = 64'd8;
    register_memory[12] = 64'd9;
    register_memory[13] = 64'd4;
    register_memory[14] = 64'd6; /// doesn't matter 
end

always@(*)
  begin
     
    

    

    if(icode == 4'b0000) // Halt instruction should be called
    begin
      valA = 0 ;
      valB = 0 ;
    end

    else if(icode == 4'b0001) //nop
    begin
      valA = 0 ;
      valB = 0 ;
    end

    else if(icode == 4'b0010) //cmovxx
    begin
      valA = register_memory[rA] ;
      valB = register_memory[rB] ;
    end

    else if(icode == 4'b0100) //rmmovq
    begin
      valA = register_memory[rA] ;
      valB = register_memory[rB] ;
    end

    else if(icode == 4'b0101) //mrmovq
    begin
      valA = 0 ;
      valB = register_memory[rB] ;
    end

    else if(icode == 4'b0110) //OPq
    begin
      valA = register_memory[rA] ;
      valB = register_memory[rB] ;
    end

    else if(icode == 4'b1000) //call
    begin
      valA = 0;
      valB = register_memory[rsp] ;
    end

    else if(icode == 4'b1001) //ret
    begin
      valA = register_memory[rsp] ;
      valB = register_memory[rsp] ;
    end

    else if(icode == 4'b1010) //pushq
    begin
      valA = register_memory[rA] ;
      valB = register_memory[rsp] ;
    end

    else if(icode == 4'b1011) //popq
    begin
      valA = register_memory[rsp] ;
      valB = register_memory[rsp] ;
    end

    register_memory0 = register_memory[0];
    register_memory1 =register_memory[1];
    register_memory2=register_memory[2];
    register_memory3=register_memory[3];
    register_memory4=register_memory[4];
    register_memory5=register_memory[5];
    register_memory6=register_memory[6];
    register_memory7=register_memory[7];
    register_memory8=register_memory[8];
    register_memory9 = register_memory[9];
    register_memory10 = register_memory[10];
    register_memory11 = register_memory[11];
    register_memory12 = register_memory[12];
    register_memory13 = register_memory[13];
    register_memory14 = register_memory[14];

  end
  // Write back stage

always@(negedge clk)
  begin

    if(icode == 4'b0010) //cmovxx
    begin
        if(cnd == 1'b1)  // cnd =1 when condition like < or  = or > or le etc are satisfied
        begin
          register_memory[rB] = valE ;
        end
    end
    else if(icode==4'b0011) //irmovq
    begin
      register_memory[rB] = valE;
    end
    else if(icode == 4'b0101) //mrmovq
    begin
        register_memory[rA] = valM ;
    end

    else if(icode == 4'b0110) //OPq
    begin
        register_memory[rB] = valE ;
    end

    else if(icode == 4'b1000) //call
    begin
        register_memory[rsp] = valE ;
    end

    else if(icode == 4'b1001) //ret
    begin
       register_memory[rsp] = valE ;
    end

    else if(icode == 4'b1010) //pushq
    begin
        register_memory[rsp] = valE ;
    end

    else if(icode == 4'b1011) //popq
    begin
        register_memory[rsp] = valE ;
        register_memory[rA] = valM ;
    end

    register_memory0 = register_memory[0];
    register_memory1 = register_memory[1];
    register_memory2 = register_memory[2];
    register_memory3 = register_memory[3];
    register_memory4 = register_memory[4];
    register_memory5 = register_memory[5];
    register_memory6 = register_memory[6];
    register_memory7 = register_memory[7];
    register_memory8 = register_memory[8];
    register_memory9 = register_memory[9];
    register_memory10 = register_memory[10];
    register_memory11 = register_memory[11];
    register_memory12 = register_memory[12];
    register_memory13 = register_memory[13];
    register_memory14 = register_memory[14];
    

  end


endmodule
