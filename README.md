The Frame Aligner is a key component in digital communication systems, responsible for maintaining synchronization of incoming data streams.
It continuously scans the received serial data and identifies specific header patterns that mark the beginning of valid frames.

Each frame is divided into two parts:
Header — a unique bit sequence that indicates frame boundaries and enables alignment recovery.
Payload — the actual data being transmitted following the header.

Once the aligner detects consecutive valid headers, it achieves synchronization and ensures that data is correctly framed, preserving both data integrity and protocol timing.

This project demonstrates the design and verification of the Frame Aligner logic, including header detection, alignment state transitions, and verification using SystemVerilog testbench, scoreboard, and coverage analysis based on industry-standard verification methodologies.
