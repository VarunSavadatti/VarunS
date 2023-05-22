module evenodd_parity(x,clk,z)
input x,clk;
output reg z;
reg even_odd;
parameter even=0,odd=1;
always@(posedge clk)
case(even_odd)
even : begin 
       z<=x ? 1:0;
       even_odd<=x ? odd:even;
       end
odd : begin
      z<=x ? 0:1;
      even_odd<=x ? even:odd;
      end
default:even_odd<=even;
       endcase 
endmodule
       
