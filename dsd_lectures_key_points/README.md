# Digital Design and Computer Architecture — L1-L6 key insights:

## Lecture 1:

### Course Overview

* The course introduces **how computers are built**, starting from **transistors** all the way to **microprocessors and GPUs**.
* It emphasizes key design aspects such as **efficiency, performance, and scalability**.


### Understanding Computing Layers

* The course highlights how computing spans **many layers**, from solving high-level problems down to **electrons and physical transistors**.
* Knowing these layers is crucial for making meaningful advances in computer architecture.
### Modern Computing Landscape

* Today’s systems integrate **CPUs, GPUs, and accelerators**, which challenges traditional system design.
* This calls for **rethinking interconnects** and overall architecture.

### Transistors and CMOS Logic

* **Transistors act as switches** controlled by voltage: N-type is on when HIGH signal is applied at gate, P-type is vice versa.
* A **CMOS inverter** uses one NMOS and one PMOS transistor to implement NOT logic.
* **NAND gates** are built from combinations of NMOS and PMOS transistors.
* **AND gates** are made by **inverting a NAND gate’s output**.
* CMOS gates are structured with **pull-up (PMOS)** and **pull-down (NMOS)** networks.

---

## Lecture 2:

### CMOS Gate Operation

* A CMOS gate has:

  * A **pull-up network** (PMOS to Vdd)
  * A **pull-down network** (NMOS to GND)
* Only one of the two should conduct at any time to avoid power waste.

### Power Consumption

* Power is used in two ways:

  * **Dynamic power** (during switching): proportional to capacitance, frequency, and V².
  * **Static power** (leakage): present even when idle(IV).
* Reducing voltage is key to saving power.

### Boolean Algebra Review

* Boolean rules help **simplify circuits** and optimize logic.
* **Bubble pushing** (based on De Morgan’s laws) helps you rewrite gates for easier implementation.

### SOP and POS Forms

* **Sum of Products (SOP)**: ORing minterms.
* **Product of Sums (POS)**: ANDing maxterms.
* These forms are starting points for **logic minimization**.

### Combinational Logic Building Blocks

* **Decoders**: Activate a unique output for each input combo (used in memory/address decoding).
* **Multiplexers (Muxes)**: Select from multiple inputs using control signals.
* **Adders**: Perform binary addition; full adders handle two bits + carry-in.
* **LUTs** can be used to implement any logical function.
* **PLAs**: Implement multiple logic functions using programmable interconnects.

---

## Lecture 3: 

### Logical Completeness

* **AND, OR, and NOT** are enough to build any logic function.
* **NAND and NOR** are each individually complete as well.

### More Combinational Components

* **Equality checkers** compare inputs.
* **ALUs** perform arithmetic and logical operations.
* **Tri-state buffers** allow multiple signals to share a bus line.
* Muxes can be built from tri-state buffers.

### Boolean Simplification

* Simplifying logic reduces gate count and power.
* **“Don’t care”** conditions help during minimization.

### Priority Circuits

* Handle **multiple requests** with **priority resolution**.
* Simplified using "don’t care" entries in truth tables.

### Sequential Logic Intro

* Unlike combinational logic, **sequential logic remembers history**.
* **State depends on both current and past inputs**.

### Basic Memory Elements

* **Cross-coupled inverters** store a single bit (bistable), but lack control.
* **RS Latch** adds control (Set/Reset), but has an invalid input case.
* **Gated D Latch** improves reliability with a clocked write enable.
* **Registers** store multiple bits using D latches.
* **D-flipflops** store only on the positive edge of a clock cycle, made using two back to back d-latches in a master slave configuration.

### Memory as Logic

* Memory arrays can be used to **implement logic functions**.
* **FPGAs** use this technique with **lookup tables (LUTs)**.

### Finite State Machines (FSMs)

* FSMs model systems with finite states, inputs, outputs, and transitions.
* **Moore FSMs**: outputs depend on state only.
* **Mealy FSMs**: outputs depend on state and inputs.

### Clocked Systems

* Most digital systems are **synchronous**.
* The **clock signal** controls state transitions.
* Delays must be considered when choosing the clock period.

---

## Lecture 4: 

### FSM Construction

* Built using:

  * **State registers (D flip-flops)**
  * **Next state logic**
  * **Output logic**
* Timing is key: the **clock cycle** must allow logic to settle.

### State Diagrams and Tables

* We convert real-world descriptions (like traffic lights) into:

  * **State diagrams**
  * **State transition tables**
  * **Boolean expressions** for next state/output logic

### FSM Encoding Strategies

* **Binary encoding**: Represents states using the minimum number of flip-flops (log₂N), saving space but possibly requiring more logic for transitions.
* **One-hot encoding**: Assigns one flip-flop per state, making transitions faster and logic simpler at the cost of more flip-flops.
* **Output encoding**: Embeds output values directly into the state representation, reducing output logic complexity.


---

## Lecture 5:

### **Coding Styles in Verilog**

* **Structural:**

  ```verilog
  and (out, a, b);  // Gate-level instantiation
  my_module m1 (.a(a), .b(b), .y(y));  // Module instantiation
  ```

* **Behavioral:**

  ```verilog
  always @(*) y = a & b;  // Describes logic behaviorally
  ```

---

### **Bit Manipulation**

* **Slicing:** `a[3:0]`
* **Concatenation:** `{a, b}`
* **Replication:** `{4{a}}`  // Repeat a 4 times

---

### **Built-in Gates and Operators**

* **Primitive gates:** `and`, `or`, `not`, `nand`, etc.

  ```verilog
  and (out, in1, in2);
  ```

* **Operators:**

  * Bitwise: `&`, `|`, `^`, `~`
  * Reduction: `&a`, `|a`
  * Conditional: `(sel) ? a : b`

---

### **Number Representation**

* **Syntax:** `width'basevalue`

  ```verilog
  4'b1010  // 4-bit binary 1010
  8'hA5    // 8-bit hex A5
  6'd42    // 6-bit decimal 42
  ```

* **Special values:**

  * `'X'` — unknown
  * `'Z'` — high impedance (tri-state)

---

### **Synthesis vs Simulation**

* **Synthesis:** Generates hardware (FPGA/ASIC).
* **Simulation:** Runs behavior in software (e.g., ModelSim).

---

### **Thinking in Hardware**

* Always map your code to **flip-flops, gates, muxes, etc.**
* Avoid writing code that has **no hardware equivalent** (e.g., unbounded loops).

---

### **Good Practices**

* **Naming** should be kept consistent.
* Define **bit widths explicitly**.
* One **module per file**.
* Prefer **parameterization** for reuse.

---

### **Sequential Logic in Verilog**

```verilog
always @(posedge clk) begin
  q <= d;  // Non-blocking assignment for flip-flops
end
```

* Use `<=` for **non-blocking**, `=` for **combinational (in always @\*)**.
* Signals inside `always` must be `reg`.

---

### **Resets**

```verilog
// Asynchronous Reset
always @(posedge clk or posedge rst) begin
  if (rst)
    q <= 0;
  else
    q <= d;
end

// Synchronous Reset
always @(posedge clk) begin
  if (rst)
    q <= 0;
  else
    q <= d;
end
```

---

### **FSM Implementation Syntax**

```verilog
// State Register
always @(posedge clk) begin
  if (reset)
    state <= S0;
  else
    state <= next_state;
end

// Next-State Logic
always @(*) begin
  case (state)
    S0: next_state = (in) ? S1 : S0;
    S1: next_state = (in) ? S1 : S0;
  endcase
end

// Output Logic (Moore-style)
assign out = (state == S1);
```



* Use:

  * `always @(posedge clk)` for **state transitions**
  * `case` statements for **next-state logic**
  * `assign` or another `always` block for **outputs** (Moore or Mealy style)

---

## Lecture 6: Timing and Verification
### Delays:
* **Propagation Delay (t\_pd):** This is the maximum time it takes for a signal to go from input to output. It's the "worst-case" delay.
* **Contamination Delay (t\_cd):** This is the *minimum* time it takes for a signal to change at the output after an input changes. It's the "best-case" delay, and it's essential for preventing glitches.
* **Sequential Circuit Timing:** We're looking at timing in circuits with memory (like flip-flops). There are new parameters here:
    * **Setup Time (t\_setup):** The data signal needs to be stable *before* the clock edge.
    * **Hold Time (t\_hold):** The data signal needs to be stable *after* the clock edge.
    * **Clock-to-Q Delay (t\_clkq):** The time it takes for the output (Q) to change after the clock edge.

### Clock Timing Parameters:
* **Clock Period (T\_c):** The time for one full clock cycle. It needs to be long enough to accommodate all the delays (propagation, clock-to-Q, setup).
* **Maximum Clock Frequency:** This is the inverse of the minimum clock period. We want to run our circuits as fast as possible, but we're limited by these delays.

### Timing Analysis terminology:
* **Timing Analysis:** We're learning how to analyze circuits to figure out the maximum clock frequency. This involves tracing paths and adding up delays.
* **Critical Path:** The path with the longest delay is the critical path. It determines the maximum clock frequency.
* **Synchronous Design:** Most modern digital systems are synchronous, meaning everything is controlled by a clock. This simplifies timing analysis.
* **Glitches:** These are unwanted, temporary changes in a signal. Contamination delay is crucial to prevent them.

### Verification:
* **Verifying Designs:** Simulation is key to making sure our circuits work correctly. We can use test benches to apply inputs and check the outputs.
* **Test Benches:** These are Verilog modules that apply stimuli to our designs and check for errors.
* **Types of Simulation:**
    * **Functional Simulation:** Checks the logic without considering timing.
    * **Timing Simulation:** Includes gate delays for more accurate results.
* **Formal Verification:** This is a more rigorous way to prove the correctness of our designs using mathematical techniques. It's more thorough than simulation but can be computationally expensive.
* **Model Checking:** A type of formal verification that checks if a design satisfies certain properties.
* **Property Specification:** We use languages like SystemVerilog to define the properties we want to verify.
* **Importance of Verification:** Verification is *essential* to catch bugs before we build the actual hardware. Finding bugs in hardware is much more expensive than finding them in software.

---