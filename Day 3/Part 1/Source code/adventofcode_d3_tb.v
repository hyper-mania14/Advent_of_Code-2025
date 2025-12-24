module power_tb;

    parameter N = 100;
    parameter M = 200;

    reg clk;
    reg reset;
    reg start;

    // flat digit memory (only for testbench)
    reg [3:0] flat [0:N*M-1];

    //single vector of lines put together
    reg [4*N*M-1:0] lines;

    wire [15:0] power;
    wire done;

    totalpower #(N, M) tp (
        .clk(clk),
        .reset(reset),
        .start(start),
        .lines(lines),
        .power(power),
        .done(done)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        // initialize
        clk   = 0;
        reset = 1;
        start = 0;

        // load digits from file
        $readmemh("digits.memh", flat);

        // digits into lines
        for (i = 0; i < N*M; i = i + 1) begin
            lines[4*i +: 4] = flat[i];
        end

        #10 reset = 0;

       //computation
        #10 start = 1;
        #10 start = 0;

        @(posedge done);

        // result
        $display("Total Power: %0d", power);

        #10 $finish;
    end

endmodule
