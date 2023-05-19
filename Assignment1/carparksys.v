module carparksys(clk,rst,fs,bs,pw_1,pw_2)
input clk,rst;
 input fs, bs;
 input [1:0] pw_1, pw_2;
 output wire GREEN_LED,RED_LED;
output reg [6:0} HEX_1, HEX_2;

parameter rest = 4'b0000, wait_pw = 4'b0001, wrong_pw = 4'b0010, right_pw = 4'b0011;
reg[2:0] current_state, next_state;
reg[31:0] counter_wait;
reg red_tmp, green_tmp;

always @(posedge clk or negedge rst)
begin
if(~rst)
cuurent_state = rest;
else 
current_state = next_state;
end

 always @(posedge clk or negedge reset_n) 
 begin
 if(~rst) 
 counter_wait <= 0;
 else if(current_state==wait_pw)
 counter_wait <= counter_wait + 1;
 else 
 counter_wait <= 0;
 end
 
 always @(*)
 begin
 case(current_state)
 rest: begin
         if(sensor_entrance == 1)
 next_state = wait_pw;
 else
 next_state = rest;
 end
 wait_pw: begin
 if(counter_wait <= 3)
 next_state = wait_pw;
 else 
 begin
 if((password_1==2'b01)&&(password_2==2'b10))
 next_state = right_pw;
 else
 next_state = wrong_pw;
 end
 end
 WRONG_PASS: begin
 if((password_1==2'b01)&&(password_2==2'b10))
 next_state = right_pw;
 else
 next_state = wrong_pw;
 end
right_pw : begin
 if(sensor_entrance==1 && sensor_exit == 1)
 next_state = STOP;
 else if(sensor_exit == 1)
 next_state =rest;
 else
 next_state = right_pw;

end
 stop: begin
 if((password_1==2'b01)&&(password_2==2'b10))
 next_state = right_pw;
 else
 next_state = STOP;
 end
 default: next_state = rest;
 endcase
 end
 //output
 always @(posedge clk) begin 
 case(current_state)
 rest: begin
 green_tmp = 1'b0;
 red_tmp = 1'b0;
 HEX_1 = 7'b1111111; // off
 HEX_2 = 7'b1111111; // off
 end
wait_pw: begin
 green_tmp = 1'b0;
 red_tmp = 1'b1;
 HEX_1 = 7'b000_0110; // E
 HEX_2 = 7'b010_1011; // n 
 end
 wrong_pw: begin
 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 HEX_1 = 7'b000_0110; // E
 HEX_2 = 7'b000_0110; // E 
 end
 right_pw: begin
 green_tmp = ~green_tmp;
 red_tmp = 1'b0;
 HEX_1 = 7'b000_0010; // 6
 HEX_2 = 7'b100_0000; // 0 
 end
 stop: begin
 green_tmp = 1'b0;
 red_tmp = ~red_tmp;
 HEX_1 = 7'b001_0010; // 5
 HEX_2 = 7'b000_1100; // P 
 end
 endcase
 end
 assign RED_LED = red_tmp  ;
 assign GREEN_LED = green_tmp;

endmodule

