module carparksys_tb;

  
  reg clk;
  reg rst;
  reg fs;
  reg bs;
  reg [1:0] pw_1;
  reg [1:0] pw_2;

 
  wire GREEN_LED;
  wire RED_LED;
  wire [6:0] HEX_1;
  wire [6:0] HEX_2;
initial begin
 clk = 0;
 forever #10 clk = ~clk;
 end
 initial begin
 
 rst = 0;
 fs = 0;
 bs= 0;
 pw_1 = 0;
 pw_2 = 0;
 
 #100;
 rst = 1;
 #20;
 fs= 1;
 #1000;
 fs= 0;
 pw_1 = 1;
 pw_2 = 2;
 #2000;
 bs=1;
 end
 endmodule



