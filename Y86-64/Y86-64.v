`include "Fetch.v"
`include "execute.v"
`include "decode_and_writeback.v"
`include "memory.v"
`include "PC_UPDATE.v"

module processor;
    reg clk;
    reg [63:0] PC;
    reg Arr[0:2];
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB; 
    wire [63:0] valC;
    wire [63:0] valP;
    wire halt_prog;
    wire is_instruction_valid;
    wire pcvalid;
    wire cnd;
    wire [63:0] valA;
    wire [63:0] valB;
    wire [63:0] valE;
    wire [63:0] valM;
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
    wire ZF;
    wire SF;
    wire OF;
    wire [63:0] PC__Update;

Fetch fetch(
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


decode_and_writeback decode_and_wb(
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

data_memory Memory(
    .clk(clk),
    .icode(icode),
    .valE(valE),
    .valA(valA),
    .valM(valM),
    .valP(valP)
);

PC_UPDATE PCUPDATE(
    .valP(valP),
    .valC(valC),
    .valM(valM),
    .Cnd(Cnd),
    .icode(icode),
    .PC(PC),
    .PC__Update(PC__Update)
);

initial begin
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

initial begin
    //$dumpfile("SEQ.vcd");
   // $dumpvars(0,SEQ);
    Arr[0] = 1; //AOK
    Arr[1] = 0; //INS
    Arr[2] = 0; //HLT
    clk = 0;
    PC = 64'd48;
end

always @(*) begin
    PC = PC__Update;
end

always @(*) begin
    if (halt_prog) begin
        Arr[0] = 1'b0; //AOK
        Arr[1] = 1'b0; //INS
        Arr[2] = halt_prog; //HLT
    end

    else if (is_instruction_valid) begin
        Arr[0] = 1'b0; //AOK
        Arr[1] = is_instruction_valid; //INS
        Arr[2] = 1'b0; //HLT
    end

    else begin
        Arr[0] = 1'b1; //AOK
        Arr[1] = 1'b0; //INS
        Arr[2] = 1'b0; //HLT
    end

end

always @(*) begin

    if (Arr[2] == 1'b1) begin
        $finish;
    end
end

initial
$monitor("clk = %d icode = %b ifun = %b  rA = %b rB = %b valA = %d valB = %d  valC=%d valE=%d valM=%d Halt_Prog=%d InstructionValid=%d pcvalid=%d cnd=%d\nRegMem0=%d\nRegMem1=%d\nRegMem2=%d\nRegMem3=%d\nRegMem4=%d\nRegMem5=%d\nRegMem6=%d\nRegMem7=%d\nRegMem8=%d\nRegMem9=%d\nRegMem10=%d\nRegMem11=%d\nRegMem12=%d\nRegMem13=%d\nRegMem14=%d\nZF=%d\nSF=%d\nOF=%d",clk,icode,ifun,rA,rB,valA,valB,valC,valE,valM,halt_prog,is_instruction_valid,pcvalid,cnd,register_memory0,register_memory1,register_memory2,register_memory3,register_memory4,register_memory5,register_memory6,register_memory7,register_memory8,register_memory9,register_memory10,register_memory11,register_memory12,register_memory13,register_memory14,ZF,SF,OF);

  //  $monitor("clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valE=%d\n reg1=%d\n reg2=%d \n reg3=%d \n reg4=%d \n reg5=%d \n reg6=%d \n reg7=%d \n reg8=%d \n reg9=%d \n reg10=%d\n reg11=%d\n reg12=%d\n reg13=%d\n reg14=%d",clk,icode,ifun,rA,rB,valA,valB,valE,register_memory0, register_memory1, register_memory2, register_memory3, register_memory4, register_memory5, register_memory6, register_memory7, register_memory8, register_memory9, register_memory10, register_memory11, register_memory12, register_memory13, register_memory14);

endmodule
