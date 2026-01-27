# Synchronize-FIFO
This project implements a parameterized synchronous FIFO (First-In First-Out) buffer in Verilog. The FIFO is designed using a single clock domain for both read and write operations and supports full and empty status flags.

✨ Features

8-bit wide data input/output

16-depth FIFO memory

Separate read and write enable signals

Full and Empty flag logic

Overflow & underflow protection

Pointer wrap-around detection using MSB technique

Fully synchronous design

🧠 Architecture & Working

Memory size: 16 × 8-bit

Read pointer and write pointer are 5-bit wide

Lower 4 bits → memory addressing

MSB → wrap-around tracking

FIFO Conditions:

Empty:
write_pointer == read_pointer

Full:
write_pointer[3:0] == read_pointer[3:0]
and
write_pointer[4] != read_pointer[4]

Data is written when wr_en && !full

Data is read when rd_en && !empty

🛠️ Tools & Skills Used

Verilog HDL

FIFO architecture

Memory modeling

Pointer-based control logic

Digital design fundamentals

📌 Applications

On-chip buffering

Producer–consumer systems

Communication interfaces

Streaming data paths

Foundation for asynchronous FIFO design

🚀 Future Improvements

Parameterized depth and data width

Almost full / almost empty flags

Asynchronous FIFO version

SystemVerilog-based verification testbench

Coverage & assertion-based verification
