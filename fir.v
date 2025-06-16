module fir_filter (
    input clk,
    input rst,
    input [7:0] sample_in,
    output reg [15:0] sample_out
);

    reg [7:0] shift_reg[0:2];  // 3-tap delay line
    wire [15:0] mult[0:2];

    // Coefficients (e.g., h = [1, 2, 1])
    parameter h0 = 1, h1 = 2, h2 = 1;

    assign mult[0] = shift_reg[0] * h0;
    assign mult[1] = shift_reg[1] * h1;
    assign mult[2] = shift_reg[2] * h2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg[0] <= 0;
            shift_reg[1] <= 0;
            shift_reg[2] <= 0;
            sample_out <= 0;
        end else begin
            // Shift input samples
            shift_reg[2] <= shift_reg[1];
            shift_reg[1] <= shift_reg[0];
            shift_reg[0] <= sample_in;

            // FIR filter output
            sample_out <= mult[0] + mult[1] + mult[2];
        end
    end

endmodule