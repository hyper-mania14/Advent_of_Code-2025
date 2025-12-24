module inventory #(parameter n=50,parameter tot_ranges=186)(
input clk,
input reset,
output reg [n-1:0] count
);
reg [n-1:0] start_r [0:tot_ranges-1];
reg [n-1:0] end_r   [0:tot_ranges-1];
reg [63:0] total_count;
reg [63:0] curr_start, curr_end;
integer i;

initial begin
    $readmemh("range_start_sorted.memh", start_r); //input values for ranges
    $readmemh("range_end_sorted.memh", end_r);
    total_count = 0;
    curr_start = start_r[0];
    curr_end = end_r[0];
    for (i = 1; i < tot_ranges; i = i + 1) begin
        if (start_r[i] <= curr_end + 1) begin
            // Merge overlapping/adjacent ranges
            if (end_r[i] > curr_end)
                curr_end = end_r[i];
        end else begin
            // Add length of previous merged range
            total_count = total_count + (curr_end - curr_start + 1);
            curr_start = start_r[i];
            curr_end = end_r[i];
        end
    end
    // Add the last range
    total_count = total_count + (curr_end - curr_start + 1);
end
always @(*) begin
    count = total_count;
end
endmodule