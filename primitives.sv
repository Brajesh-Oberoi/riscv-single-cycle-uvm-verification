///////////////////////////////////////////////////////////////
// primitives
//
// Definition of common and primitive logic elements.
///////////////////////////////////////////////////////////////

module flopr #(parameter WIDTH = 8)
    (input  logic             clk, reset,
     input  logic [WIDTH-1:0] d, 
     output logic [WIDTH-1:0] q);

always_ff @(posedge clk, posedge reset)
if (reset) q <= '0;
else       q <= d;
endmodule

module mux2 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1, 
    input  logic             s, 
    output logic [WIDTH-1:0] y);

assign y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1, d2,
    input  logic [1:0]       s, 
    output logic [WIDTH-1:0] y);

assign y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule

module adder(input  [31:0] a, b,
    output [31:0] y);

assign y = a + b;
endmodule