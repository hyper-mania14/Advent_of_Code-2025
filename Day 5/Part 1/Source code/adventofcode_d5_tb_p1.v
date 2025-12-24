module inventory_tb;
parameter n=50;
parameter tot_items=1000; 
parameter tot_ranges=186;

reg clk;
reg reset;
reg [n-1:0] items [0:tot_items-1];
wire [9:0] count;

inventory uut #(n, tot_items, tot_ranges) (
    .clk(clk),
    .reset(reset),
    .items(items),
    .count(count)
);
always #5 clk = ~clk;
initial begin
    // initialize
    clk = 0;
    reset = 1;
    //items to check
    $readmemh("items.memh", items);

    #10 reset = 0;

    #1000;
    $display("Total Count: %0d", count);

    #10 $finish;
end
endmodule

