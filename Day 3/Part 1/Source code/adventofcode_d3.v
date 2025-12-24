module joltage #(parameter N=100)(
    input [4*N-1:0] line,
    output reg [7:0] jolt
);

reg [3:0] max1, max2,d;
reg [6:0] p1,p2;

integer i;
always @(*) begin
    max1=0;
    max2=0;
    p1=-1;
    p2=-1;

for (i=0; i<N; i=i+1) begin
d=line[4*i+3:4*i];

if(d>max1) begin
    max2=max1;
    max1=d; 
    p2=p1;
    p1=i;
end

else if(d>max2) begin
    max2=d;
    p2=i;
end
end
if(p1<p2) begin
    jolt = {max1,max2};
end
else begin
    jolt = {max2,max1};
end
end
endmodule

module totalpower #(parameter N=100, M=200)(
    input clk,
    input reset,
    input start,
    input [4*N*M-1:0] lines, // total input
    output reg [15:0] power,
    output reg done
);

    reg [7:0] jolt;
    reg [8:0] count; //from 0 to 200
    reg running;

    wire [4*N-1:0] pline; //current line
    assign pline = lines[4*N*count + 4*N-1 : 4*N*count];

    joltage #(.N(N)) j1 (
        .line(pline),
        .jolt(jolt)
    );
    //state machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            power <= 0;
            count <= 0;
            done <= 0;
            running <= 0;
        end else if (start && !running) begin
            power <= 0;
            count <= 0;
            done <= 0;
            running <= 1;
        end else if (running) begin
            power <= power + jolt;
            if (count == M-1) begin
                done <= 1;
                running <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule