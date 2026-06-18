class imem_sequence_item extends uvm_sequence_item;

  rand logic [31:0]inst_arr[$];

  `uvm_object_utils(imem_sequence_item)

   constraint c {inst_arr.size() inside {[1:10000]}; }

  function new(string name="imem_sequence_item");
    super.new(name);
  endfunction

  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    foreach (inst_arr[i])
      printer.print_field($sformatf("inst_arr[%0d]", i), inst_arr[i], 32, UVM_HEX);
  endfunction

endclass
