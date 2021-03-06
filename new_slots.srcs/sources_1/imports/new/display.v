module display(clk,blank , num1, num2, num3, led, sel, seg);
input clk;
input [31:0] num1;
input [31:0] num2;
input [31:0] num3;
input [31:0] blank;

//reg [7:0] an_0; //d[7]-dp, d[6:0]-ASCII
output reg [15:0] led;
wire [15:0] out_led;
output reg [3:0] sel;
output reg [7:0] seg;	//a~g,dp


//å¨æ?æ«æ?:Hz
parameter update_interval = 500000 - 1;
//çç¾ç»éª:5Hz
parameter led_interval = 100000000 / 5 - 1;
 
reg [7:0] dat;
 
reg [1:0] cursel, cursel_0;
integer selcnt_1;		//éµî£å¼¿çâæ
integer selcnt_2;		//LEDéîåçâæ

initial  
begin 
cursel = 0;
cursel_0 = 0;
selcnt_1 = 0;
selcnt_2 = 0;
end

//

//


 
//éµî£å¼¿çâæéå±¾ææµ£å¶ï¿½å¤å«¨
always @(posedge clk)
begin
	selcnt_1 <= selcnt_1 + 1;
		
	if (selcnt_1 == update_interval)
	begin
		selcnt_1 <= 0;
		cursel <= cursel + 1;
	end
end

//LEDéîåçâæ
always @(posedge clk)
begin
	selcnt_2 <= selcnt_2 + 1;
		
	if (selcnt_2 == led_interval)
	begin
		selcnt_2 <= 0;
		cursel_0 <= cursel_0 + 1;
	end
end

always @(posedge clk)
begin
    case(cursel_0[1] & blank[31])
    1: led = 16'hffff;
    0: led = 16'h0;
    endcase
end



//éåå¦§éé¢ç¶å©æ°¬å§©éå ç



always @(*)
begin
	sel = 4'b1111;
	case (cursel)
		2'b00:
			begin 
			dat = num1[7:0];//AN3æ¶ç¯¶
			sel = 4'b0111;
			end
		2'b01:
			begin 
			dat = num2[7:0];//AN2æ¶ç¯µ
			sel = 4'b1011;
			end
		2'b10:
			begin 
			dat = num3[7:0];//AN1æ¶ç¯´
			sel = 4'b1101;
			end
		2'b11:
			begin 
			dat = 8'h0d;//éåå¦§éé¢ç¶
			sel = 4'b1110;
			end
	endcase
end


always @(*)
begin
	case (dat[6:0])
		7'h00: seg[7:0] <= 8'b00000011;		//å¯°å®æº?0
		7'h01: seg[7:0] <= 8'b00000011;		//éå§ã?0
		7'h02: seg[7:0] <= 8'b10011111;		//1
		7'h03: seg[7:0] <= 8'b00100101;		//2
		7'h04: seg[7:0] <= 8'b00001101;		//3
		7'h05: seg[7:0] <= 8'b10011001;		//4
		7'h06: seg[7:0] <= 8'b01001001;		//5
		7'h07: seg[7:0] <= 8'b01000001;		//6
		7'h08: seg[7:0] <= 8'b00011111;		//7
		7'h0c: seg[7:0] <= 8'b01111111;		//æ¤¤åî¬å¦¯îå
		7'h0d: seg[7:0] <= 8'b11111111;		//ç»è¹æ«?
		7'h0e: seg[7:0] <= 8'b11101111;		//_
		7'h0f: seg[7:0] <= 8'b11111101;		//-
		
		default: seg[7:0] <= 8'b01100001; 	//E-rror
	endcase
end
	
endmodule



