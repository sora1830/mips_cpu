module top (
    input clk, reset,
    input  btn_l, btn_r,
    output [15 : 0] leds,
    output [3  : 0] disp_sel,
    output [7  : 0] disp_dig
    );

    wire [31:0] memData, writeMemData;
    wire MemWrite;
    wire [1:0] MemMode;
    wire [15:0] memAddr;

    mips _mips(clk, reset, memData, MemWrite, MemMode, writeMemData, memAddr, btn_l, btn_r, leds, disp_sel, disp_dig);

    exmemory _ex_mem(clk, reset, MemWrite, MemMode, memAddr, writeMemData,
                //btn_l, btn_r, leds, disp_sel, disp_dig, 
                memData
                );


endmodule // top


//module top_tb ();
//    reg clk, reset;
//    wire [15:0] leds;
//    wire [3:0] disp_sel;
//    wire [7:0] disp_dig;
//    reg  btn_l, btn_r;
//    top _top(clk, reset,  btn_l, btn_r, leds, disp_sel, disp_dig);

//    always #5
//        clk = ~clk;

//    initial begin
//        $dumpvars(0, _top);
//        clk = 0;
//        reset = 0;
//        btn_l = 0;
//        btn_r = 0;
//        # 100 reset = 1;
//        # 200 reset = 0;
//        # 500 btn_l = 1;
//        # 60000000 begin
//            btn_l = 0;
//        end
        
        
//        //# 100 btn_r = 1;
//        //# 10 btn_r = 0;

//        # 1600000000 $finish;
//    end


//endmodule // top_tb
