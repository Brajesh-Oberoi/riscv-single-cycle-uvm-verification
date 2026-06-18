///////////////////////////////////////////////////////////////
// datapath
//
// Definition of the multicycle RISC-V processor datapath
///////////////////////////////////////////////////////////////

module datapath(input  logic        clk, reset,
    input  logic [1:0]  ResultSrc,
    input  logic        PCSrc, ALUSrc,
    input  logic        RegWrite,
    input  logic [1:0]  ImmSrc,
    input  logic [2:0]  ALUControl,
    output logic        Zero,
    output logic [31:0] PC,
    input  logic [31:0] Instr,
    output logic [31:0] ALUResult, WriteData,
    input  logic [31:0] ReadData);

logic [31:0] PCNext, PCPlus4, PCTarget;
logic [31:0] ImmExt;
logic [31:0] SrcA, SrcB;
logic [31:0] Result;

// next PC logic
flopr #(32) pcreg(clk, reset, PCNext, PC);
adder       pcadd4(PC, 32'd4, PCPlus4);
adder       pcaddbranch(PC, ImmExt, PCTarget);
mux2 #(32)  pcmux(PCPlus4, PCTarget, PCSrc, PCNext);

// register file logic
regfile     rf(clk, RegWrite, Instr[19:15], Instr[24:20],
     Instr[11:7], Result, SrcA, WriteData);
extend      ext(Instr[31:7], ImmSrc, ImmExt);

// ALU logic
mux2 #(32)  srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
alu         alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
mux3 #(32)  resultmux(ALUResult, ReadData, PCPlus4, ResultSrc, Result);
endmodule

module regfile(input  logic        clk,
   input  logic        we3,
   input  logic [ 4:0] a1, a2, a3,
   input  logic [31:0] wd3,
   output logic [31:0] rd1, rd2);

bit [31:0] rf[31:0]; //temporary solution changed logic to bit

// three ported register file
// read two ports combinationally (A1/RD1, A2/RD2)
// write third port on rising edge of clock (A3/WD3/WE3)
// register 0 hardwired to 0

always_ff @(posedge clk)
if (we3) rf[a3] <= wd3;

assign rd1 = (a1 != 0) ? rf[a1] : 0;
assign rd2 = (a2 != 0) ? rf[a2] : 0;
endmodule

module extend(input  logic [31:7] instr,
  input  logic [1:0]  immsrc,
  output logic [31:0] immext);

always_comb
case(immsrc)
   // I-type
2'b00:   immext = {{20{instr[31]}}, instr[31:20]};
   // S-type (stores)
2'b01:   immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
   // B-type (branches)
2'b10:   immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
   // J-type (jal)
2'b11:   immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
default: immext = 32'bx; // undefined
endcase
endmodule


module alu(input  logic [31:0] a, b,
    input  logic [2:0]  alucontrol,
    output logic [31:0] result,
    output logic        zero);

logic [31:0] condinvb, sum;
logic        v;              // overflow
logic        isAddSub;       // true when is add or subtract operation

assign condinvb = alucontrol[0] ? ~b : b;
assign sum = a + condinvb + alucontrol[0];
assign isAddSub = ~alucontrol[2] & ~alucontrol[1] |
             ~alucontrol[1] & alucontrol[0];

always_comb
case (alucontrol)
3'b000:  result = sum;         // add
3'b001:  result = sum;         // subtract
3'b010:  result = a & b;       // and
3'b011:  result = a | b;       // or
3'b100:  result = a ^ b;       // xor
3'b101:  result = sum[31] ^ v; // slt
3'b110:  result = a << b[4:0]; // sll
3'b111:  result = a >> b[4:0]; // srl
default: result = 32'bx;
endcase

assign zero = (result == 32'b0);
assign v = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;

endmodule