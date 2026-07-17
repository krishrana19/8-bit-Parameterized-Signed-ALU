# 8-bit Parameterized Signed ALU in Verilog

A parameterized **8-bit Signed Arithmetic Logic Unit (ALU)** designed in **Verilog HDL**. The project supports arithmetic, logical, shift, rotate, and comparison operations with status flag generation. The design was functionally verified using **Icarus Verilog** and **GTKWave**, and synthesized using **Yosys**.

---

## Features

* Parameterized data width (default: 8-bit)
* Signed arithmetic operations
* Logical operations
* Logical and arithmetic shift operations
* Rotate operations
* Signed comparison operations
* Status flag generation

  * Carry
  * Zero
  * Sign
  * Overflow
* Fully verified using a dedicated testbench
* RTL synthesis using Yosys

---

## Supported Operations

| Opcode | Operation                   |
| :----: | --------------------------- |
| `0000` | Addition                    |
| `0001` | Subtraction                 |
| `0010` | Increment                   |
| `0011` | Decrement                   |
| `0100` | Two's Complement (Negation) |
| `0101` | Bitwise AND                 |
| `0110` | Bitwise OR                  |
| `0111` | Bitwise XOR                 |
| `1000` | Bitwise NOT                 |
| `1001` | Logical Left Shift          |
| `1010` | Logical Right Shift         |
| `1011` | Arithmetic Right Shift      |
| `1100` | Rotate Left                 |
| `1101` | Rotate Right                |
| `1110` | Equality Comparison         |
| `1111` | Greater Than Comparison     |

---

## Status Flags

### Carry Flag

Indicates carry out during addition/subtraction or the bit shifted out during logical shift operations.

### Zero Flag

Set when the output `Y` equals zero.

### Sign Flag

Represents the sign of the output result (Most Significant Bit of `Y`).

### Overflow Flag

Indicates signed arithmetic overflow.

Overflow is generated for:

* Addition
* Subtraction
* Increment
* Decrement
* Two's Complement (only for the minimum signed value)

---

## Project Structure

```text
8-bit-Parameterized-Signed-ALU
│
├── README.md
├── .gitattributes
│
├── src
│   └── ALU.v
│
├── tb
│   └── ALU_tb.v
│
├── synthesis
│   └── synth.ys
│
└── images
    ├── gtkwave_waveform.png
    └── yosys_statistics.png
```

---

## Tools Used

* Verilog HDL
* Visual Studio Code
* Icarus Verilog
* GTKWave
* Yosys

---

## Simulation

Compile the design:

```bash
iverilog -o alu src/ALU.v tb/ALU_tb.v
```

Run the simulation:

```bash
vvp alu
```

Open the waveform:

```bash
gtkwave output.vcd
```

---

## RTL Synthesis

Run the synthesis script:

```bash
yosys synthesis/synth.ys
```

The synthesis process:

* Reads the RTL design
* Converts behavioral Verilog into synthesizable logic
* Optimizes the design
* Reports synthesis statistics
* Generates a synthesized Verilog netlist

---

## Verification

The testbench verifies:

* Normal arithmetic operations
* Signed overflow conditions
* Increment and decrement edge cases
* Two's complement overflow
* Logical operations
* Logical and arithmetic shifts
* Rotate operations
* Signed equality comparison
* Signed greater-than comparison
* Carry, Zero, Sign and Overflow flags

---

## Synthesis Results

=== ALU ===

   Number of wires:                 59
   Number of wire bits:            210
   Number of public wires:          11
   Number of public wire bits:      35
   Number of ports:                  8
   Number of port bits:             32
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                 52
     $add                            2
     $and                           11
     $eq                            17
     $gt                             1
     $logic_not                      2
     $mux                            2
     $neg                            1
     $not                            4
     $or                             3
     $pmux                           3
     $reduce_or                      3
     $sub                            2
     $xor                            1

---

## Future Improvements

* Barrel shifter
* Additional comparison operations
* Arithmetic left shift
* Parameterized shift amount
* Parity flag
* Less-than and greater-than-or-equal comparison
* SystemVerilog version
* Constrained-random verification

---

## Author

**Krish Rana**

Electronics and Communication Engineering
Punjab Engineering College (PEC), Chandigarh


