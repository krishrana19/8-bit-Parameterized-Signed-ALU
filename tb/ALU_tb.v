`timescale 1ns/1ps

module ALU_tb#(parameter size = 8) ;

reg signed [size-1:0] A;
reg signed [size-1:0] B;
reg [3:0] alu_sel;
wire signed [size-1:0] Y;
wire carry;
wire zero;
wire sign;
wire overflow;

ALU# (size) uut(
    .A(A),
    .B(B),
    .alu_sel(alu_sel),
    .Y(Y),
    .carry(carry),
    .zero(zero),
    .sign(sign),
    .overflow(overflow)
);

task inputs;
input [size-1:0] a;
input [size-1:0] b;
input [3:0] sel;

begin
    A = a; 
    B = b; 
    alu_sel = sel; 
    #10;
end

endtask 

initial begin
    $dumpfile("output.vcd");
    $dumpvars(0, ALU_tb);
    $monitor("time = %0dt, A = %b (%0d), B = %b (%0d), Sel = %b (%0d), Y = %b (%0d), carry = %b, zero = %b, sign = %b, overflow = %b",
                $time , A, A, B, B, alu_sel, alu_sel, Y, Y, carry, zero, sign, overflow);
    A = {size{1'b0}};
    B = {size{1'b0}};
    #10;

    // Arithmetic

    inputs(25,15,4'b0000);      // Add
    inputs(127,1,4'b0000);      // Add Overflow

    inputs(40,15,4'b0001);      // Sub
    inputs(-128,1,4'b0001);     // Sub Overflow

    inputs(126,0,4'b0010);      // Inc
    inputs(127,0,4'b0010);      // Inc Overflow

    inputs(-127,0,4'b0011);     // Dec
    inputs(-128,0,4'b0011);     // Dec Overflow

    inputs(15,0,4'b0100);       // Neg
    inputs(-128,0,4'b0100);     // Neg Overflow

    // Logic

    inputs(8'b10101010,8'b11001100,4'b0101);
    inputs(8'b10101010,8'b11001100,4'b0110);
    inputs(8'b10101010,8'b11001100,4'b0111);
    inputs(8'b10101010,8'b00000000,4'b1000);

    // Shift

    inputs(8'b10010110,0,4'b1001);
    inputs(8'b10010110,0,4'b1010);
    inputs(-64,0,4'b1011);

    // Rotate

    inputs(8'b10010110,0,4'b1100);
    inputs(8'b10010110,0,4'b1101);

    // Compare

    inputs(15,15,4'b1110);
    inputs(15,10,4'b1110);

    inputs(20,10,4'b1111);
    inputs(-20,10,4'b1111);

    $finish;
end

endmodule
