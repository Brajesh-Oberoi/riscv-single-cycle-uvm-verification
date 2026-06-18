class riscv_base_test extends uvm_test;

  `uvm_component_utils(riscv_base_test)

  riscv_env rv_env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rv_env = riscv_env::type_id::create("rv_env", this);
  endfunction



  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   `uvm_info(get_type_name(), "Executing riscv_base_test", UVM_DEBUG)
  endtask

endclass
