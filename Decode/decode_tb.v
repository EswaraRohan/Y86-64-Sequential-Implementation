module decode_tb;
  
  reg clk;
  reg [63:0] register[0:14] ;

  reg [3:0] icode;
  reg [3:0] rA;
  reg [3:0] rB; 
  wire [63:0] valA;
  wire [63:0] valB;


  decode DUT(valA , valB , clk , icode , rA , rB ) ;
  
  initial begin 
      
    clk = 0;

    #3 clk=~clk; icode = 4'b0000; rA = 64'd2 ; rB = 64'd3;
 
    #3 clk=~clk;
    #3 clk=~clk; icode = 4'b0010; rA = 64'd12 ; rB = 64'd5;

    #3 clk=~clk;
    #3 clk=~clk; icode = 4'b0100; rA = 64'd6 ; rB = 64'd1;

    #3 clk=~clk;
    #3 clk=~clk; icode = 4'b0101; rA = 64'd14 ; rB = 4'd3;
    #3 clk=~clk;
    #3 clk=~clk; icode = 4'b1010; rA = 64'd2 ; rB = 4'd14;


    
  end 
  
  initial 
		$monitor("icode = %b, rA = %d , rB = %d , valA = %d , valB = %d\n",icode,rA,rB,valA,valB) ;


endmodule
