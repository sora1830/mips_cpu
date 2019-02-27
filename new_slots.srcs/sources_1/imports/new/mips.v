module mips (
    input clk, reset,
    // ========= Data from Memory =========
    input [31  : 0] memData,
    // ========= Signal to Memory =========
    output MemWrite,        //低电平读，高电平�?
    output [1  : 0] MemMode,
    // ========= Data to Memory =========
    output [31 : 0] writeMemData,
    output [15 : 0] memAddr
    ,input  [0           : 0] btn_l, btn_r,
    output [15          : 0] leds,
    output [3           : 0] disp_sel,
    output [7           : 0] disp_dig
    );

    wire PCWriteCond, PCWrite;
    wire [1:0] PCSource;
    wire IorD, MemToReg, IRWrite, RegWrite, RegDst;
    wire [1:0] ALUSrcA, ALUSrcB;
    wire zero;
    wire [31:0] aluResult, aluParamData1, aluParamData2;
    wire [5:0] op, funct;
    wire [4:0] ALUOP;

    datapath _datapath(clk, reset, PCWriteCond, PCWrite, PCSource, IorD, MemToReg, IRWrite, RegWrite, RegDst, ALUSrcA, ALUSrcB, zero, aluResult, memData, op, funct, aluParamData1, aluParamData2, writeMemData, memAddr
                        , btn_l, btn_r, leds, disp_sel, disp_dig);

    controller _controller(clk, reset, op, funct, MemWrite, MemMode, PCWriteCond, PCWrite, PCSource, IorD, MemToReg, IRWrite, RegWrite, RegDst, ALUSrcA, ALUSrcB, ALUOP);

    alu _alu(aluParamData1, aluParamData2, ALUOP, zero, aluResult);

endmodule // mips
