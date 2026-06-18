class riscv_env extends uvm_env;

  `uvm_component_utils(riscv_env)

  imem_env im_env;
  dmem_env dm_env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    im_env = imem_env::type_id::create("im_env", this);
    dm_env = dmem_env::type_id::create("dm_env", this);
  endfunction


endclass
