module inventory #(parameter n=50, parameter tot_items=1000, parameter tot_ranges=186)(
input clk,
input reset,
input [n-1:0] items [0:tot_items-1],
output reg [9:0] count
);
reg [n-1:0] start_r [0:tot_ranges-1];
reg [n-1:0] end_r [0:tot_ranges-1];
reg [7:0] range_index;
reg [9:0] item_index;

initial begin
    $readmemh("range_start.memh", start_r);
    $readmemh("range_end.memh", end_r);
end
always @(posedge clk or posedge reset) begin
    if (reset) begin
        range_index <=0;
        item_index <=0;
        count <=0;
    end
    else begin 
        if (item_index < tot_items) begin
        if (items[item_index]>=start_r[range_index] && items[item_index] <= end_r[range_index]) begin
            count <= count + 1;
            range_index <= 0;
            item_index <= item_index + 1;
        end
        else if (range_index < tot_ranges-1) begin
            range_index <= range_index + 1;
        end
        else begin
            range_index <= 0;
            item_index <= item_index + 1;
        end
    end
    end 
end
endmodule