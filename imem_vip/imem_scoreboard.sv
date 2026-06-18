class imem_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(imem_scoreboard)

  `uvm_analysis_imp_decl(_imem)

  uvm_analysis_imp_imem #(imem_sequence_item, imem_scoreboard) im_agent_export;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    im_agent_export = new("im_agent_export", this);
  endfunction



  virtual function void write_imem(imem_sequence_item t);


  endfunction




  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

endclass
