# Distance Detector and Converter

This project implements a distance detector and converter using **VHDL** on an **FPGA NEXYS A7** and a **PMOD SONAR** module. The system measures distances and displays them in various units: **inches**, **feet**, **centimeters**, and **millimeters**.

## Project Features

- **Distance Measurement**:
  - Uses the PMOD SONAR to measure distances in inches.
- **Unit Conversion**:
  - Converts the measured distances into feet, centimeters, and millimeters.
- **Display**:
  - Displays the distance on 7-segment displays integrated into the FPGA board.
- **Unit Selection**:
  - Allows users to choose the display unit via on-board switches.

## System Architecture

The system consists of the following components:

1. **PMOD-SONAR-ctrl**:
   - Measures the distance using echo pulses and outputs the result in inches.
2. **Convertisseur**:
   - Converts inches to feet, centimeters, and millimeters using optimized arithmetic operations to reduce hardware resource consumption.
3. **FSM (Finite State Machine)**:
   - Controls the selection of the display unit based on the switch input.
4. **Multiplexeur (MUX)**:
   - Selects the appropriate unit to display.
5. **Binary to BCD Converter**:
   - Converts binary values to Binary-Coded Decimal (BCD) format for display.
6. **Transcoder**:
   - Maps BCD values to 7-segment display signals.
7. **Clock Enable**:
   - Reduces clock frequency for stable 7-segment display operation.
8. **7-Segment Display Controller**:
   - Manages the display of distances on the FPGA’s 7-segment display.

## Setup and Usage

1. **Hardware Requirements**:
   - FPGA Board: Nexys A7
   - Sensor: PMOD SONAR
2. **Software Requirements**:
   - Vivado Design Suite
3. **Steps**:
   - Connect the PMOD SONAR to the FPGA.
   - Program the FPGA with the provided VHDL code.
   - Use the switches to select the desired unit:
     - `00`: Inches
     - `01`: Centimeters
     - `10`: Feet
     - `11`: Millimeters
   - Observe the result on the 7-segment displays.

## Performance Analysis

- Utilization of FPGA resources:
  - **1%** Look-Up Tables (LUTs) and Flip-Flops (FFs)
  - **10%** Input/Output Pins
  - **3%** Buffers
- The design demonstrates high efficiency, leaving room for further enhancements.

## References

- [NEXYS A7 Reference Manual](https://digilent.com/reference/_media/reference/programmable-logic/nexys-a7/nexys-a7_rm.pdf)
- [PMOD SONAR Datasheet](https://digilent.com/reference/pmod/pmodmaxsonar/start)

## Conclusion

This project effectively demonstrates the use of VHDL for real-world applications such as distance measurement and conversion. By optimizing FPGA resource usage, it showcases the potential for further expansion and customization.

