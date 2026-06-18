class imem_r_type_test extends imem_base_test;

  //imem_env im_env;

  `uvm_component_utils(imem_r_type_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //im_env = imem_env::type_id::create("im_env", this);
  endfunction



  task run_phase(uvm_phase phase);
    imem_r_type_sequence imem_random_seq;
    imem_random_seq = imem_r_type_sequence::type_id::create("imem_random_seq", this);
    phase.raise_objection(this);
    super.run_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Executing imem_r_type_test run_phase()"), UVM_DEBUG)
    assert(imem_random_seq.randomize());
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    foreach(imem_random_seq.inst_arr[i]) `uvm_info(get_type_name(), $sformatf("Printing inst_arr_%0f:%d", i, imem_random_seq.inst_arr[i]), UVM_DEBUG);
    imem_random_seq.start(im_env.im_agent.im_sequencer);
    `uvm_info(get_type_name(), $sformatf("Finished imem_r_type_test run_phase()"), UVM_DEBUG)
     #1us;
    phase.drop_objection(this);
  endtask

endclass


class imem_i_type_test extends imem_base_test;

  //imem_env im_env;

  `uvm_component_utils(imem_i_type_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //im_env = imem_env::type_id::create("im_env", this);
  endfunction



  task run_phase(uvm_phase phase);
    imem_i_type_sequence imem_random_seq;
    imem_random_seq = imem_i_type_sequence::type_id::create("imem_random_seq", this);
    phase.raise_objection(this);
    super.run_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Executing imem_i_type_test run_phase()"), UVM_DEBUG)
    assert(imem_random_seq.randomize());
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    foreach(imem_random_seq.inst_arr[i]) `uvm_info(get_type_name(), $sformatf("Printing inst_arr_%0f:%d", i, imem_random_seq.inst_arr[i]), UVM_DEBUG);
    imem_random_seq.start(im_env.im_agent.im_sequencer);
    `uvm_info(get_type_name(), $sformatf("Finished imem_i_type_test run_phase()"), UVM_DEBUG)
     #1us;
    phase.drop_objection(this);
  endtask

endclass



























class imem_random_test extends imem_base_test;

  //imem_env im_env;

  `uvm_component_utils(imem_random_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //im_env = imem_env::type_id::create("im_env", this);
  endfunction



  task run_phase(uvm_phase phase);
    imem_random_sequence imem_random_seq;
    imem_random_seq = imem_random_sequence::type_id::create("imem_random_seq", this);
    phase.raise_objection(this);
    super.run_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Executing imem_random_test run_phase()"), UVM_DEBUG)
    assert(imem_random_seq.randomize() with { inst_arr.size() == 100;});
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    foreach(imem_random_seq.inst_arr[i]) `uvm_info(get_type_name(), $sformatf("Printing inst_arr_%0f:%d", i, imem_random_seq.inst_arr[i]), UVM_DEBUG);
    imem_random_seq.start(im_env.im_agent.im_sequencer);
    `uvm_info(get_type_name(), $sformatf("Finished imem_random_test run_phase()"), UVM_DEBUG)
     #1ms;
    phase.drop_objection(this);
  endtask

endclass



class imem_target_test extends imem_base_test;

  //imem_env im_env;

  `uvm_component_utils(imem_target_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //im_env = imem_env::type_id::create("im_env", this);
  endfunction



  task run_phase(uvm_phase phase);
    imem_random_sequence imem_random_seq;
    imem_random_seq = imem_random_sequence::type_id::create("imem_random_seq", this);
    phase.raise_objection(this);
    super.run_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Executing imem_target_test run_phase()"), UVM_DEBUG)
    assert(imem_random_seq.randomize() with {
                                             inst_arr.size() == 12;
                                             foreach(inst_arr[i])
                                                 if(i==0) inst_arr[i]==32'h00500113;
                                                 else if(i==4) inst_arr[i]==32'h00C00193;
                                                 else if(i==8) inst_arr[i]==32'hFF718393;
                                                });
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    foreach(imem_random_seq.inst_arr[i]) `uvm_info(get_type_name(), $sformatf("Printing inst_arr_%0f:%d", i, imem_random_seq.inst_arr[i]), UVM_DEBUG);
    imem_random_seq.start(im_env.im_agent.im_sequencer);
    `uvm_info(get_type_name(), $sformatf("Finished imem_target_test run_phase()"), UVM_DEBUG)
     #1ms;
    phase.drop_objection(this);
  endtask

endclass
