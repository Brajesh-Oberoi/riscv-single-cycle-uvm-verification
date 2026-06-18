class imem_sequencer extends uvm_sequencer#(imem_sequence_item);


  `uvm_component_utils(imem_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass
