module exmemory #(parameter WIDTH = 32, ADDR_WIDTH = 16) (
    input clk, reset,
    // ========= Signal from Controller =========
    input MemWrite,
    input [1            : 0] MemMode,
    input [ADDR_WIDTH-1 : 0] memAddr,
    input [WIDTH-1      : 0] memWriteData,
    // ========= I/O Devices =========
//    input  [0           : 0] btn_l, btn_r,
//    output [15          : 0] leds,
//    output [3           : 0] disp_sel,
//    output [7           : 0] disp_dig,

    output reg [WIDTH-1 : 0] memReadData
    );

    wire [31 : 0] romData;
    wire [31 : 0] ramData;
    wire RamWrite;

//    wire [31:0] IOState;
//    wire [31:0] dp_in;
//    button _btn(clk, reset,  btn_l, btn_r, IOState);
//    display dis(clk, dp_in, leds, disp_sel, disp_dig);
    
//    reg [31:0] num2;
//    reg [31:0] num3;
//    reg [31:0] num1;
//    reg [31:0] blank;
    
//    assign dp_in = {blank[7:0],num1[7:0],num2[7:0],num3[7:0]};
    
    
    
    assign RamWrite = ~reset & MemWrite ;//& (memAddr[11:8]==4'b0010);
    
    rom ROM(memAddr[11:2], romData);
    ram RAM(clk, RamWrite, memAddr[11:2], memWriteData, ramData);

   

    always @ ( * ) begin
        // $display("[exmemory] time: %h, mode: %b, read %h", $time, MemMode, memAddr);
        case (memAddr[15:12])
            4'h0: begin//0x000-0x0ff  for ROM
                case (MemMode)
                    2'b00: memReadData <= romData;
                    2'b01: begin
                        case (memAddr[1:0])
                            2'b00: memReadData <= {{24{romData[7]}}, romData[7:0]};
                            2'b01: memReadData <= {{24{romData[15]}}, romData[15:8]};
                            2'b10: memReadData <= {{24{romData[23]}}, romData[23:16]};
                            2'b11: memReadData <= {{24{romData[31]}}, romData[31:24]};
                        endcase
                    end
                    2'b10: begin
                        case (memAddr[1:0])
                            2'b00: memReadData <= {24'b0, romData[7:0]};
                            2'b01: memReadData <= {24'b0, romData[15:8]};
                            2'b10: memReadData <= {24'b0, romData[23:16]};
                            2'b11: memReadData <= {24'b0, romData[31:24]};
                        endcase
                    end
                endcase
                // $display("[exmemory] read from ROM(%h), got %h", memAddr, memReadData);
            end
            4'h1: begin//0x100-0x1ff  for RAM
                case (MemMode)
                    2'b00: memReadData <= ramData;
                    2'b01: begin
                        case (memAddr[1:0])
                            2'b00: memReadData <= {{24{ramData[7]}}, ramData[7:0]};
                            2'b01: memReadData <= {{24{ramData[15]}}, ramData[15:8]};
                            2'b10: memReadData <= {{24{ramData[23]}}, ramData[23:16]};
                            2'b11: memReadData <= {{24{ramData[31]}}, ramData[31:24]};
                        endcase
                    end
                    2'b10: begin
                        case (memAddr[1:0])
                            2'b00: memReadData <= {24'b0, ramData[7:0]};
                            2'b01: memReadData <= {24'b0, ramData[15:8]};
                            2'b10: memReadData <= {24'b0, ramData[23:16]};
                            2'b11: memReadData <= {24'b0, ramData[31:24]};
                        endcase
                    end
                endcase
                // $display("[exmemory] read from RAM(%h), got %h", memAddr, memReadData);
            end
//            4'hf: begin
//                case (memAddr)
//                    16'hfffb: memReadData <= IOState ;
//                endcase
//            end
        endcase
    end

    
//    always @ (posedge clk) begin
//        if (MemWrite) begin
//            case (memAddr)
//                16'hfff1: num1 <= memWriteData ;
//                16'hfff2: num2 <= memWriteData ;
//                16'hfff3: num3 <= memWriteData ;
//                16'hfff4: blank <= memWriteData ;
//            endcase
//        end
//    end

endmodule // exmemory


// module exmemory_tb ();

//     reg clk, reset, MemWrite;
//     reg [15:0] addr;
//     reg [31:0] inData;
//     wire [31:0] outData;
//     reg btn_l, btn_r;
//     wire [15 : 0] leds;
//     wire [3  : 0] disp_sel;
//     wire [7  : 0] disp_dig;
//     reg [1:0] MemMode;

//     exmemory mem(clk, reset, MemWrite, MemMode, addr, inData,  btn_l, btn_r, leds, disp_sel, disp_dig, outData);

//     always #1 clk = ~clk;

//     initial 
//     begin
//         # 0 $dumpvars(0, _exmemory);
//         # 0 MemMode = 0; btn_l = 0; btn_r = 0;
//         # 0 clk = 0;
//         # 0 reset = 1;
//         # 0 MemWrite = 0;
//         # 0 addr = 16'h1000;
//         # 0 inData = 32'hdeadbeef;
//         # 10 reset = 0;
//         # 20 MemWrite = 1;
//         # 30 MemWrite = 0;
//         # 40 addr = 16'hff00;
//         # 50 MemWrite = 1;
//         # 60 MemWrite = 0;
//         # 70 addr = 16'h0001;
//         # 80 addr = 16'h0002;
//         # 90 addr = 16'h0004;
//         # 100 addr = 16'h1000;
//         # 110 addr = 16'hfffb;
//         # 130 btn_l = 1;
//         # 140 btn_l = 0;
//         # 160 btn_r = 1;
//         # 170 btn_r = 0;
//         # 50 $finish;
//     end

// endmodule // exmemory_tb
