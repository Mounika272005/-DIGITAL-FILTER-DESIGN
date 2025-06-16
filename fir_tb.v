`timescale 1ns/1ps

module fir_tb;

    reg clk, rst;
    reg [7:0] sample_in;
    wire [15:0] sample_out;

    fir_filter uut (
        .clk(clk),
        .rst(rst),
        .sample_in(sample_in),
        .sample_out(sample_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("fir.vcd");
        $dumpvars(0, fir_tb);

        // Init
        clk = 0;
        rst = 1;
        sample_in = 0;

        #10 rst = 0;

        // Feed samples
        #10 sample_in = 8'd5;
        #10 sample_in = 8'd10;
        #10 sample_in = 8'd15;
        #10 sample_in = 8'd20;
        #10 sample_in = 8'd0;

        #50 $finish;
    end
endmodule
