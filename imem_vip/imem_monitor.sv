class imem_monitor extends uvm_monitor;

  `uvm_component_utils(imem_monitor)

  virtual imem_if imem_vif;

  uvm_analysis_port #(imem_sequence_item) mon_ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
    if(!uvm_config_db#(virtual imem_if)::get(this, "*", "imem_vif", imem_vif))
      `uvm_fatal(get_type_name(), $sformatf("imem_vif not found"))
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask


endclass
