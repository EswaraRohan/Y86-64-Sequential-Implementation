module fetchtb;
  
  
  
  reg [63:0] PC;
  reg clk;
  reg [7:0] memory[0:51] ;

  wire [3:0] ifun;
  wire [3:0] icode;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;


  Fetch DUT(clk, PC , icode , ifun , rA , rB , valC , valP , halt_prog , is_instruction_valid) ;
  
  initial begin 
      
    clk=0; PC=64'd0;

    #3 clk=~clk; PC = 64'd0 ;
 
    #3 clk=~clk;
    #3 clk=~clk;PC=valP;

    #3 clk=~clk;
    #3 clk=~clk;PC=valP;

    #3 clk=~clk;
    #3 clk=~clk;PC=valP;
    #3 clk=~clk;
    #3 clk=~clk;PC=valP;


    
  end 
  
  initial 
		$monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d , halt program = %b , is_instruction_valid = %b\n",clk,PC,icode,ifun,rA,rB,valC,valP,halt_prog,is_instruction_valid);
endmodule
