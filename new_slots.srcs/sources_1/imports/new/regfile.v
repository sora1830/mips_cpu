module regfile #(parameter WIDTH = 32, ADDR_WIDTH = 5) (
    input clk, reset,
    input regWrite,
    input [ADDR_WIDTH-1 : 0] readAddr1, readAddr2, writeAddr,
    input [WIDTH-1      : 0] writeData,
    output [WIDTH-1     : 0] readData1, readData2
    //
        ,input  [0           : 0] btn_l, btn_r,
        output [15          : 0] leds,
        output [3           : 0] disp_sel,
        output [7           : 0] disp_dig
        //
    );
    wire [31:0] IOState;
    reg [WIDTH-1 : 0] MEM[0:(1<<ADDR_WIDTH)-1];

    assign readData1 = MEM[readAddr1];
    assign readData2 = MEM[readAddr2];

    initial begin
        MEM[0] = 0;
        MEM[11] = 8;
        MEM[12] = 8;
        MEM[13] = 8;
    end

    always @ (posedge clk) begin
        if (regWrite)
            MEM[writeAddr] <= writeData;
         else MEM[23] <= IOState;
    end

    always @ ( posedge clk ) begin
        $display("[regfile] time: %h, regWrite: %b, writeAddr: %h, writeData: %h, $t0: %h, $t1: %h, $t2: %h, $t3: %h", $time, regWrite, writeAddr, writeData, MEM[8], MEM[9], MEM[10], MEM[11]);
    end
    
    //
        wire [31:0] blank;
        wire [31:0] num1;
        wire [31:0] num2;
        wire [31:0] num3;

        button _btn(clk, reset,  btn_l, btn_r, IOState);
        display dis(clk, blank ,num1,num2,num3, leds, disp_sel, disp_dig);

        assign  num1 = MEM[11];
        assign  num2 = MEM[12];
        assign  num3 = MEM[13];
        assign  blank = MEM[26];
//        initial begin
//            num3 <= 32'h00000005;
//            num2 <= 32'h00000005;
//            num1 <= 32'h00000005;
//            blank <= 32'h00000000;
//        end


        //


endmodule // regfile

//
// module regfile_tb ();
//
//     reg clk, reset, regWrite;
//     reg [4:0] ra1, ra2, wa;
//     reg [31:0] wd;
//     wire [31:0] rd1, rd2;
//
//     regfile ff(clk, reset, regWrite, ra1, ra2, wa, wd, rd1, rd2);
//
//     always #5
//         clk = ~clk;
//
//     initial begin
//         $monitor("time: %d\nra1: %d  rd1: %h\nra2: %d  rd2: %h", $time, ra1, rd1, ra2, rd2);
//         clk = 0;
//         reset = 1;
//         ra1 = 8;
//         ra2 = 9;
//         wa = 10;
//         wd = 32'hdeadbeef;
//         regWrite = 0;
//         # 10 reset = 0;
//         # 10 regWrite = 1;
//         # 10 regWrite = 0;
//         # 10 ra1 = 10;
//         # 10 $finish;
//     end
//
// endmodule // regfile_tb
