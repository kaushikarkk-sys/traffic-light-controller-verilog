module traffic_light_controller (
    input  clk,
    input reset,

    output reg A_red,
    output reg A_yellow,
    output reg A_green,

    output reg B_red,
    output reg B_yellow,
    output reg B_green
);

    // State declaration
    reg [1:0] state;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // State transition
    always @(posedge clk or posedge reset) begin

        if (reset)
            state <= S0;

        else begin
            case (state)

                S0: state <= S1;
                S1: state <= S2;
                S2: state <= S3;
                S3: state <= S0;

                default: state <= S0;

            endcase
        end
    end

    // Output logic
    always @(*) begin

        // Default: all lights OFF
        A_red    = 1'b0;
        A_yellow = 1'b0;
        A_green  = 1'b0;

        B_red    = 1'b0;
        B_yellow = 1'b0;
        B_green  = 1'b0;

        case (state)

            // Road A GREEN, Road B RED
            S0: begin
                A_green = 1'b1;
                B_red   = 1'b1;
            end

            // Road A YELLOW, Road B RED
            S1: begin
                A_yellow = 1'b1;
                B_red    = 1'b1;
            end

            // Road A RED, Road B GREEN
            S2: begin
                A_red   = 1'b1;
                B_green = 1'b1;
            end

            // Road A RED, Road B YELLOW
            S3: begin
                A_red    = 1'b1;
                B_yellow = 1'b1;
            end

            default: begin
                A_red = 1'b1;
                B_red = 1'b1;
            end

        endcase
    end

endmodule
