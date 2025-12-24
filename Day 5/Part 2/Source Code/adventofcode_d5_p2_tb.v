module inventory_tb;
    parameter n = 50;
    parameter tot_ranges = 4;

    reg clk;
    reg reset;
    wire [n-1:0] count;

        inventory #(n, tot_ranges) uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset and monitor
    initial begin
        reset = 1;
        #10;
        reset = 0;
        #20000;
        $display("Total items: %0d", count);
        $finish;
    end
endmodule