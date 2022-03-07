module data_memory( clk , icode , valE , valA , valM , valP) ;

// valP is only used in 'call'

parameter memory_size = 4095  ;

  input clk;
  input [3:0] icode;
  input [63:0] valA;
  input [63:0] valE;
  input [63:0] valP;
  
  output reg [63:0] valM;
  

  reg [63:0] data_memory[0:memory_size];
  
  
    /* integer i ;
     for(i=0; i<4095 ;i = i + 1)
     begin
     data_memory[i] = 64'd3;
     end
*/
  

 
  always@(*)
  begin
   
    valM = 64'd0 ;
    
    // rmmovq
    if(icode == 4'b0100) 
    begin
      data_memory[valE] = valA;
      $display("\nThe memory contained all 3 earlier but now memory[valE] has changed to %d in the following\n",data_memory[valE]);
    end

    //mrmovq
    if(icode == 4'b0101) 
    begin
      valM = data_memory[valE] ;
      $display("\nvalM was originally 0, now after shifting from memory to register valM is %d after the following instruction ",valM) ;
    end

    // call
    if(icode == 4'b1000) 
    begin
      data_memory[valE] = valP;
      $display("\nThe memory contained all 3 earlier but now memory[valE] has changed to %d after the following instruction\n",data_memory[valE]);
    end

    // ret
    if(icode == 4'b1001) 
    begin
      valM = data_memory[valA];
      $display("\nvalM was originally 0, now after shifting from memory to register valM is %d after the following instruction ",valM) ;
    end
    
    // pushq
    if(icode == 4'b1010) 
    begin
      data_memory[valE] = valA;
      $display("\nThe memory contained all 3 earlier but now memory[valE] has changed to %d in the following\n",data_memory[valE]);
    end
    
    // popq
    if(icode == 4'b1011) 
    begin
      valM = data_memory[valE];
      $display("\nvalM was originally 0, now after shifting from memory to register valM is %d after the following instruction",valM) ;
    end

    
  end
  
endmodule
