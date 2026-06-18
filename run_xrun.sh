#!/bin/bash
#---------------------------------------------------------------
# xrun script for RISC-V Single Cycle Processor
# Cadence Xcelium simulation
#---------------------------------------------------------------

# Design uses `include directives in riscv_tb.sv to pull in:
#   riscvsingle.sv -> primitives.sv, datapath.sv, controller.sv
# So only riscv_tb.sv needs to be passed to xrun.
#
# riscvtest.txt (instruction hex) must be in the run directory
# since $readmemh("riscvtest.txt", RAM) uses a relative path.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

xrun \
  -sv \
  -top testbench \
  -timescale 1ns/1ps \
  -access +rw \
  -gui \
  -input ${SCRIPT_DIR}/xrun_cmd.tcl \
  +incdir+${SCRIPT_DIR} \
  ${SCRIPT_DIR}/riscv_tb.sv \
  -l xrun.log
