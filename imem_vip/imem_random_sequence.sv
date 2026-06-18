class imem_random_sequence extends uvm_sequence #(imem_sequence_item);

  rand bit [31:0] inst_arr[$];

  `uvm_object_utils(imem_random_sequence)

  function new(string name="imem_random_sequence");
    super.new(name);
  endfunction

  task body();
    super.body();
    `uvm_info(get_type_name(), $sformatf("Executing imem_random_sequence"), UVM_DEBUG)
    `uvm_do_with(req, {
                       inst_arr.size() == local::inst_arr.size();
                       foreach(inst_arr[i]) inst_arr[i] == local::inst_arr[i];
                       });
    `uvm_info(get_type_name(), $sformatf("Finished imem_random_sequence run, printing seq item"), UVM_DEBUG)
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    req.print();
  endtask

endclass




class imem_target_sequence extends uvm_sequence #(imem_sequence_item);

  rand bit [31:0] inst_arr[$];

  `uvm_object_utils(imem_target_sequence)

  function new(string name="imem_target_sequence");
    super.new(name);
  endfunction

  task body();
    super.body();
    `uvm_info(get_type_name(), $sformatf("Executing imem_target_sequence"), UVM_DEBUG)
    `uvm_do_with(req, {
                       inst_arr.size() == local::inst_arr.size();
                       foreach(inst_arr[i]) inst_arr[i] == local::inst_arr[i];
                       });
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    req.print();
  endtask

endclass
