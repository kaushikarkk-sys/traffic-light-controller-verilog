`timescale 1ns/1ps

module traffic_light_controller_tb;

    reg clk;
    reg reset;

    wire A_red;
    wire A_yellow;
    wire A_green;

    wire B_red;
    wire B_yellow;
    wire B_green;

    // Instantiate the DUT
    traffic_light_controller DUT (
        .clk(clk),
        .reset(reset),

        .A_red(A_red),
        .A_yellow(A_yellow),
        .A_green(A_green),

        .B_red(B_red),
        .B_yellow(B_yellow),
        .B_green(B_green)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin

        // Initial values
        clk = 0;
        reset = 1;

        // Hold reset
        #10;

        // Release reset
        reset = 0;

        // Allow FSM to run
        #50;

        // Apply reset again
        reset = 1;
        #10;

        // Release reset
        reset = 0;

        #40;

        $finish;

    end

endmodule
