class imem_driver extends uvm_driver #(imem_sequence_item);

  `uvm_component_utils(imem_driver)

  virtual imem_if imem_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual imem_if)::get(this, "*", "imem_vif", imem_vif))
      `uvm_fatal(get_type_name(), $sformatf("imem_vif not found"))
  endfunction



  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    drive_reset();
    get_and_drive();
    seq_item_port.item_done();
  endtask



  task drive_reset();
  endtask


  task get_and_drive();
    seq_item_port.get_next_item(req);
      repeat(req.inst_arr.size())
          begin
            if(imem_vif.prgm_cntr==0) imem_vif.imem_data <= req.inst_arr[imem_vif.prgm_cntr];
            @(imem_vif.prgm_cntr);
            imem_vif.imem_data <= req.inst_arr[imem_vif.prgm_cntr];
            `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
            req.print();
          end
  endtask


endclass
