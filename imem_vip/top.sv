module top;

`include "uvm_macros.svh"
import uvm_pkg::*;
import imem_pkg::*;

bit [31:0]prgm_cntr;
logic [31:0]imem_data;
int data;
imem_if imem_vif();

assign imem_data = imem_vif.driver_modport.imem_data;
assign imem_vif.driver_modport.prgm_cntr = prgm_cntr;

initial
  repeat(20)
    begin
      #100us; prgm_cntr++;
    end

initial
  begin
    uvm_config_db#(virtual imem_if)::set(null, "*", "imem_vif", imem_vif);
    run_test("");
  end




endmodule
