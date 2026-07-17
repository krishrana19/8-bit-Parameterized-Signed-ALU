`timescale 1ns/1ps

// Project : 8-bit Parameterized Signed ALU
// Author : Krish Rana

module ALU# (parameter size = 8)
    (
    input signed [size-1:0] A,
    input signed [size-1:0] B,

    input [3:0] alu_sel,

    output reg signed [size-1:0] Y,
    output reg carry,
    output reg zero,
    output reg sign,
    output reg overflow
    // output reg parity
);

wire a_sign = A[size-1];
wire b_sign = B[size-1];
wire y_sign = Y[size-1];

always @(*) begin

    // INITIALISING every output as 0
    Y = {size{1'b0}};
    carry = 1'b0;
    zero = 1'b0;
    sign = 1'b0;
    overflow = 1'b0;

    case (alu_sel)

    // Arithmetic -> FOLLOWS SIGNED ARITHMETIC 
    4'b0000 : begin 
        {carry,Y} = {a_sign,A} + {b_sign,B}; // Add 
        overflow = (a_sign & b_sign & ~(y_sign)) | (~(a_sign) & ~(b_sign) & y_sign);
    end
    4'b0001 : begin
        {carry,Y} = {a_sign,A} - {b_sign,B}; // Subtract
        overflow = (a_sign & ~(b_sign) & ~(y_sign)) | (~(a_sign) & b_sign & y_sign);
    end
    4'b0010 : begin
        {carry,Y} = {a_sign,A} + 1; // Increment
        overflow = ~(a_sign) & y_sign;
    end
    4'b0011 : begin 
        {carry,Y} = {a_sign,A} - 1; // Decrement
        overflow = a_sign & ~(y_sign);
    end
    4'b0100 : begin
        Y = -A; // 2's Complement -> carry is left unchanged to 0
        overflow = (A == {1'b1, {(size-1){1'b0}}});
    end

    // Logical
    4'b0101 : Y = A & B; // And
    4'b0110 : Y = A | B; // Or
    4'b0111 : Y = A ^ B; // Xor
    4'b1000 : Y = ~A; // Not

    // Logical Shift -> SHIFTED out bit is stored in CARRY
    4'b1001 : begin  // Logical Left Shift
        carry = A[size-1]; 
        Y = A << 1;
    end
    4'b1010 : begin  // Logical Right Shift
        carry = A[0];
        Y = $unsigned(A) >> 1;
    end

    // Aritmetic Shift
    4'b1011 : begin  // Arithmetic Right Shift
        carry = A[0];
        Y = A >>> 1;
    end

    // Rotate
    4'b1100 : Y = {A[size-2:0], A[size-1]}; // Rotate Left
    4'b1101 : Y = {A[0], A[size-1:1]}; // Rotate Right

    // Comparision -> IF TRUE, ALL OUTPUT Bits will be 1 else ALL bits are 0, FOLLOWS SIGNED COMPARISION
    4'b1110 : Y = (A == B) ? {size{1'b1}} : {size{1'b0}}; // Compare
    4'b1111 : Y = (A > B) ? {size{1'b1}} : {size{1'b0}}; // Greater than

    // IF DOESN'T match with any above cases, the output will be 0 
    default : Y = {size{1'b0}};

    endcase

    sign = Y[size-1];
    zero = (Y == {size{1'b0}});

end

endmodule
