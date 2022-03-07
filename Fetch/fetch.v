module Fetch(clk, PC , icode , ifun , rA , rB , valC , valP , halt_prog , is_instruction_valid,pcvalid) ;

parameter SIZE = 63 ;

// 1. In the fetch stage, we need to read the instruction from Instruction_memory using the PC value
// 2. The first instruction byte is divided into two 4-bits referred to as icode and ifun
//    icode tells us the instruction
//    ifun tells the function of instruction ,else it is 0


// The inputs
input [63:0] PC ;
input clk ;

// The outputs
output reg [3:0] ifun ;
output reg [3:0] icode ;
output reg [3:0] rA ;
output reg [3:0] rB ; 
output reg signed[63:0] valC ;
output reg signed[63:0] valP ;
output reg is_instruction_valid ;
output reg halt_prog ;
output reg pcvalid ;

// Registers
reg [7:0] Instruction_memory[0:128]; // Consider the Instruction_memory contains the instruction/data/storage etc at values given by PC
                          // and you can have 1024 values of PC


reg [0:7] byte1 ;
reg [0:7] byte2 ;

reg signed [0:63] if_valC_req ;

initial begin

  
   Instruction_memory[0] = 8'b01100000; //6 add
   Instruction_memory[1] = 8'b00000011; //%rax %rbx and store in rbx

   Instruction_memory[2] = 8'b00100000; // rrmovq 
   Instruction_memory[3] = 8'b00000011; // src = %rax dest = %rdx
   
   
   
   Instruction_memory[4] = 8'b01000000; //4-rmmovq 
   Instruction_memory[5] = 8'b00000011; //rax and (rbx)
   Instruction_memory[6] = 8'b00000000;  //VALC ---->from 6 to 13
   Instruction_memory[7] = 8'b00000000;
   Instruction_memory[8] = 8'b00000000;
   Instruction_memory[9] = 8'b00000000;
   Instruction_memory[10] = 8'b00000000;
   Instruction_memory[11] = 8'b00000000;
   Instruction_memory[12] = 8'b00000000;
   Instruction_memory[13] = 8'b00001111;
   

   Instruction_memory[14] = 8'b00010000; //no operation
   Instruction_memory[15] = 8'b00010000; //no operation
   Instruction_memory[16] = 8'b00000000; //halt


end

always@(posedge clk) 
  begin 

    byte1 = {Instruction_memory[PC]} ;
    byte2 = {Instruction_memory[PC+1]} ;

    icode = byte1[0:3];
    ifun  = byte1[4:7];

    if_valC_req = 64'd0 ;
    valC = 0;
    
    if(icode==4'b0011 || icode==4'b0100 || icode==4'b0101 || icode==4'b0111 || icode ==4'b1000)
    begin
    if_valC_req = {Instruction_memory[PC+2] , Instruction_memory[PC+3] , Instruction_memory[PC+4] , Instruction_memory[PC+5] , Instruction_memory[PC+6] , Instruction_memory[PC+7] , Instruction_memory[PC+8] , Instruction_memory[PC+9]} ;
    end
    

    is_instruction_valid = 1'b1 ;

    halt_prog = 0 ;
     
    // icode gives the instruction type

    if(icode == 4'b0000) // Halt instruction should be called
    begin
      halt_prog = 1;
      valP = PC + 64'd1;  // since only 1byte 
    end

    else if(icode == 4'b0001) //nop
    begin
      valP = PC + 64'd1;
    end

    else if(icode == 4'b0010) //cmovxx
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valP = PC + 64'd2;
    end

    else if(icode == 4'b0011) //irmovq
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valC = if_valC_req;
      valP = PC + 64'd10;
    end

    else if(icode == 4'b0100) //rmmovq
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valC = if_valC_req;
      valP = PC + 64'd10;
    end

    else if(icode == 4'b0101) //mrmovq
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valC = if_valC_req;
      valP = PC + 64'd10;
    end

    else if(icode == 4'b0110) //OPq
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valP = PC + 64'd2;
    end

    else if(icode==4'b0111) //jxx
    begin
      valC = if_valC_req;
      valP = PC + 64'd9;
    end

    else if(icode == 4'b1000) //call
    begin
      valC = if_valC_req;
      valP = PC + 64'd9;
    end

    else if(icode == 4'b1001) //ret
    begin
      valP = PC+64'd1;
    end

    else if(icode == 4'b1010) //pushq
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valP = PC + 64'd2;
    end

    else if(icode==4'b1011) //popq
    begin
      rA = byte2[0:3];
      rB = byte2[4:7];
      valP = PC + 64'd2;
    end

    else 
    begin
      is_instruction_valid = 1'b0;
    end

    pcvalid = 0;
    if(PC > 1023)
    begin
      pcvalid = 1 ;
    end

  end

endmodule




