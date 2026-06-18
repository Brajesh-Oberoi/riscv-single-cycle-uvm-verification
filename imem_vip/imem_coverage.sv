class imem_coverage extends uvm_subscriber #(imem_sequence_item);

  `uvm_component_utils(imem_coverage)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction



  virtual function void write(imem_sequence_item t);


  endfunction




  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

endclass
