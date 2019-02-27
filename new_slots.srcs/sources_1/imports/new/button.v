module button (
    input clk, reset,
    input btn_l, btn_r, 
    // 0: Wait for operation
    // 1: Wait for address input to write ram
    // 2: Wait for address input to read ram
    // 3: Wait for data input to write ram

    output reg [31:0] IOState
    );

    initial begin
        IOState = 32'hffffffff;
    end

    always @ (posedge clk) begin
        if (reset | btn_r) IOState <= 32'b0;
        else if (btn_l) IOState    <= 32'hffffffff;
    end

endmodule // button


//module button_tb ();
//    reg clk, reset;
//    reg btn_l, btn_r;
//    wire [31:0] IOState;

//    button _button(clk, reset, btn_l, btn_r, IOState);


//    initial begin
//        $dumpvars(0, _button);
//        clk =  0;
//        btn_l = 0;
//        btn_r = 0;
//        # 20 reset = 1;
//        # 10 reset = 0;
//        # 20 btn_l = 1;
//        # 10 btn_l = 0;
//        # 20 btn_r = 1;
//        # 10 btn_r = 0;
//        # 50 $finish;
//    end

//    always #5
//        clk = ~clk;

//endmodule // button_tb
