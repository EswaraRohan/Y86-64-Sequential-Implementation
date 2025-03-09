# Y86-64 Sequential Implementation

## Overview

This project involves the development of a processor architecture based on the Y86-64 Instruction Set Architecture (ISA) using Verilog. The design focuses on a sequential implementation, thoroughly tested to meet all specified requirements through simulations.

## Features

- **Sequential Design**: Implements a sequential processor architecture.
- **Y86-64 ISA Support**: Executes all instructions from the Y86-64 ISA, except for `call` and `ret` instructions.
- **Modular Design**: Each stage of the processor is coded as a separate module and tested independently to facilitate seamless integration.

## Design Approach

The design follows a modular approach, with each stage of the processor implemented as an independent module. This methodology ensures that each component can be tested individually, simplifying the integration process. The primary stages include:

1. **Fetch**: Reads instructions from memory.
2. **Decode**: Interprets the fetched instructions and reads the necessary registers.
3. **Execute**: Performs arithmetic or logical operations.
4. **Memory**: Handles memory read or write operations.
5. **Write Back**: Writes results back to the appropriate registers.
6. **Program Counter (PC) Update**: Updates the program counter to point to the next instruction.

## File Structure

- `Fetch.v`: Handles the instruction fetch stage.
- `Decode.v`: Manages the instruction decode stage.
- `Execute.v`: Responsible for the execution stage.
- `Memory.v`: Oversees memory operations.
- `Writeback.v`: Manages the write-back stage.
- `PC_Update.v`: Updates the program counter.
- `Y86-64.v`: Top-level module integrating all stages.
- `Testbenches/`: Contains testbenches for individual modules and the integrated processor.
- `Documentation/`: Includes the project report detailing design decisions, supported features, simulation snapshots, and challenges encountered.

## Testing and Verification

Each module has been independently tested using specific testbenches to verify its functionality. Additionally, integrated tests have been conducted to ensure cohesive operation across all modules. The tests include:

- **Module-Specific Tests**: Validate the functionality of individual stages.
- **Integrated Tests**: Ensure seamless interaction between all stages.
- **Assembly Program Execution**: Executes assembly programs written in Y86-64 ISA to verify the processor's functionality.


