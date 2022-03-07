`include "Fetch.v"
`include "decode_and_writeback.v"



module execute_tb;
  reg clk;
  reg [63:0] PC;
  

  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valE;
  wire [63:0] valM ;
  wire  cnd;
  reg [63:0] register_memory [0:14] ;  
  
  wire [63:0] register_memory0;
  wire [63:0] register_memory1;
  wire [63:0] register_memory2;
  wire [63:0] register_memory3;
  wire [63:0] register_memory4;
  wire [63:0] register_memory5;
  wire [63:0] register_memory6;
  wire [63:0] register_memory7;
  wire [63:0] register_memory8;
  wire [63:0] register_memory9;
  wire [63:0] register_memory10;
  wire [63:0] register_memory11;
  wire [63:0] register_memory12;
  wire [63:0] register_memory13;
  wire [63:0] register_memory14;

  Fetch fetch1(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .halt_prog(halt_prog),
    .is_instruction_valid(is_instruction_valid),
    .pcvalid(pcvalid)
  );
  
  //decode decode(.valA(valA) , .valB(valB) , .clk(clk) , .icode(icode) , .rA(rA) , .rB(rB) ) ;

  Execute execute(
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .clk(clk),
    .cnd(cnd),
    .ZF(ZF),
    .SF(SF),
    .OF(OF)
  );


  decode_and_writeback decode(
      .valA(valA),
      .valB(valB),
      .valE(valE),
      .valM(valM),
      .clk(clk),
      .rA(rA),
      .rB(rB),
      .icode(icode),
      .cnd(cnd),
      .register_memory0(register_memory0),
      .register_memory1(register_memory1),
      .register_memory2(register_memory2),
      .register_memory3(register_memory3),
      .register_memory4(register_memory4),
      .register_memory5(register_memory5),
      .register_memory6(register_memory6),
      .register_memory7(register_memory7),
      .register_memory8(register_memory8),
      .register_memory9(register_memory9),
      .register_memory10(register_memory10),
      .register_memory11(register_memory11),
      .register_memory12(register_memory12),
      .register_memory13(register_memory13),
      .register_memory14(register_memory14)
  ); 

  initial begin
 


    //$display("original register \nreg1=%d \nreg2=%d\nreg3=%d\nreg4=%d\nreg5=%d\nreg6=%d\nreg7=%d\nreg8=%d\nreg9=%d\nreg10=%d\nreg11=%d\nreg12=%d\nreg13=%d\nreg14=%d\n", register_memory[0], register_memory[1], register_memory[2], register_memory[3], register_memory[4], register_memory[5], register_memory[6], register_memory[7], register_memory[8], register_memory[9], register_memory[10], register_memory[11], register_memory[12], register_memory[13], register_memory[14]);
    //$display("execution") ;
    clk=0;
    

   #3 clk=~clk;PC=64'd0;
   #3 clk=~clk;
   #3 clk=~clk;PC=valP;
   #3 clk=~clk;
   #3 clk=~clk;PC=valP;
   #3 clk=~clk;
   #3 clk=~clk;PC=valP;
   #3 clk=~clk;

   
  end 
  #3 clk=~clk;PC=64'd0;
   #3 clk=~clk;
   #3 clk=~clk;PC=valP;
   #3 clk=~clk;
   #3 clk=~clk;PC=valP;
   #3 clk=~clk;
   #3 clk=~clk;PC=valP;
   #3 clk=~clk;

   
  end 
  
  initial 
  
    $monitor("clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valE=%d\n reg1=%d\n reg2=%d \n reg3=%d \n reg4=%d \n reg5=%d \n reg6=%d \n reg7=%d \n reg8=%d \n reg9=%d \n reg10=%d\n reg11=%d\n reg12=%d\n reg13=%d\n reg14=%d",clk,icode,ifun,rA,rB,valA,valB,valE,register_memory0, register_memory1, register_memory2, register_memory3, register_memory4, register_memory5, register_memory6, register_memory7, register_memory8, register_memory9, register_memory10, register_memory11, register_memory12, register_memory13, register_memory14);
endmodule
