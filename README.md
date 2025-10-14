

#  Multicycle Processor (Verilog)

This repository contains the Verilog implementation of a **Multicycle Processor** as part of the *Computer Systems Architecture (CSA)* course project.
The processor is designed to execute instructions in multiple cycles using separate modules for datapath and control.

---

##  Project Structure

```
├── ALU.v                     # Arithmetic Logic Unit
├── ALUC.v                    # ALU Control
├── CU_SM.v                   # Control Unit (State Machine)
├── Instruction_Register.v    # Instruction Register
├── IR_TB.v                   # Testbench for Instruction Register
├── Jump_Address.v            # Jump Address Calculator
├── Memory.v                  # Instruction/Data Memory
├── Memory_Data_Register.v    # Memory Data Register
├── PC.v                      # Program Counter
├── PC_TB.v                   # Testbench for Program Counter
├── Processor.ucf             # User Constraints File (for FPGA)
├── Processor.v               # Main Processor File
├── Register_File.v           # Register File
├── Register_file.txt         # Sample Register File Input
├── Seven_Segment_Display.v   # Display Module
├── Sig_Extension.v           # Sign Extension Unit
├── SM_TB.v                   # Testbench for Control State Machine
├── Top_Module.v              # Top-Level Processor Integration
└── README.md                 # Project Documentation
```

---

##  Setup Instructions

### 1. Prerequisites

* Install [Xilinx ISE / Vivado](https://www.xilinx.com/) or any Verilog-compatible simulator (e.g., ModelSim, iverilog).
* Have access to an FPGA board (if testing on hardware) – e.g., Nexys 3 Spartan-6.
* Clone this repository:

  ```bash
  git clone https://github.com/your-username/Talha-2.git
  cd Talha-2
  ```

---

### 2. Simulation (Software Testing)

1. Open your Verilog simulator (ModelSim, Icarus Verilog, or Xilinx ISE Simulator).
2. Compile the required modules:

   ```tcl
   vlog ALU.v ALUC.v CU_SM.v Instruction_Register.v Jump_Address.v Memory.v \
        Memory_Data_Register.v PC.v Processor.v Register_File.v \
        Seven_Segment_Display.v Sig_Extension.v Top_Module.v
   ```
3. Run testbenches (example):

   ```tcl
   vlog PC_TB.v
   vsim PC_TB
   run -all
   ```

---

### 3. FPGA Deployment (Hardware Testing)

1. Open **Xilinx ISE**.
2. Create a new project and add all `.v` files.
3. Add `Processor.ucf` as the constraints file for FPGA pin mapping.
4. Synthesize → Implement Design → Generate Bitstream.
5. Upload the bitstream to your FPGA board using iMPACT / Vivado Hardware Manager.

---

##  Features

* **Multicycle execution** – splits instruction execution into multiple stages (fetch, decode, execute, memory, write-back).
* **ALU operations** – supports addition, subtraction, AND, OR, XOR, NOR, and shifts.
* **Control Unit (FSM)** – manages instruction flow across cycles.
* **Modular design** – each component implemented as a standalone Verilog module.
* **Testbenches included** – for PC, Instruction Register, and Control Unit.

---

## Example Run

You can load instructions into `Memory.v` and simulate the processor.
Registers can be initialized using `Register_file.txt`.
Waveform simulation in ModelSim/ISE will show:

* PC increments/jumps
* Instruction decoding
* ALU results
* Memory read/write

---

