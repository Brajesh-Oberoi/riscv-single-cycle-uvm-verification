class imem_base_test extends uvm_test;

  imem_env im_env;

  `uvm_component_utils(imem_base_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    im_env = imem_env::type_id::create("im_env", this);
  endfunction


  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass
