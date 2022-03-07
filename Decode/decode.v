module decode(valA , valB , clk , icode , rA , rB ) ; // Don't get confused we don not need to send halt coz we are decoding

parameter SIZE = 63 ;


input clk ;
input [3:0] rA ;
input [3:0] rB ;
//input reg [3:0] rsp ;
input [3:0] icode ;
reg [63:0] register_memory [0:14] ;

assign rsp = 64'd4 ;

// If we were to consider that we have 15 register_memorys from %rax to %r14, the stack pointer is %rsp and it is in the 4th place

output reg [63:0] valA ;
output reg [63:0] valB ;

initial
  begin
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
    register_memory[14] = 64'd6;
    begin
    

always@(posedge clk)
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

  /*  else if(icode == 4'b0011) //irmovq
    begin
      valB = register_memory[rB] ;
    end */

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

   /* else if(icode==4'b0111) //jxx
    begin
      
    end */

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

    else if(icode==4'b1011) //popq
    begin
      valA = register_memory[rsp] ;
      valB = register_memory[rsp] ;
    end

    

  end

endmodule
