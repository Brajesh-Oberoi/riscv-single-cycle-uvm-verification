class load_type_instruction extends base_inst;

  `uvm_object_utils_begin(load_type_instruction)
  `uvm_object_utils_end
  rand bit [11:0] imm_data;

  constraint imm_data_c        { imm_data == { func7 , rs1 }; }
  constraint imm_data_positive { imm_data[11]==1'b0; } //let's take only positive numbers
  constraint rs_c              { rs2 == 0; }
  constraint opcode_c          { opcode == 7'b0000011; }
  constraint func3_c           { func3 inside {0,1,2,4,6}; }
  //constraint zero_base_addr    { imm_data == 0; }
  constraint mem_size          { imm_data inside {[0:127]};}

  function new(string name="load_type_instruction");
    super.new(name);
  endfunction


endclass


class load_i_type_sequence extends uvm_sequence #(imem_sequence_item);

  `uvm_object_utils(load_i_type_sequence)

   rand int inst_arr[];

  function new(string name="load_i_type_sequence");
    super.new(name);
  endfunction


  task body();
    load_type_instruction it_inst;
    imem_sequence_item item;
    bit single_inst_arr[];
    it_inst = new("it_inst");
    item = imem_sequence_item::type_id::create("item");

    assert(item.randomize() with { inst_arr.size() == 1000;/*local::inst_arr.size();*/}  );

    foreach(item.inst_arr[i])
      begin
        assert(it_inst.randomize());
        it_inst.pack(single_inst_arr);
        it_inst.print();
        item.inst_arr[i] = { >> {single_inst_arr} };
      end

    super.body();
    `uvm_info(get_type_name(), $sformatf("Executing load_i_type_sequence"), UVM_DEBUG)

    //start_item(item);
    //finish_item(item);
    `uvm_send(item)
    `uvm_info(get_type_name(), $sformatf("Finished load_i_type_sequence run, printing seq item"), UVM_DEBUG)
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
     item.print();
  endtask

endclass




class riscv_load_regs_test extends riscv_base_test;


`uvm_component_utils(riscv_load_regs_test)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
  endfunction



  task run_phase(uvm_phase phase);
    load_i_type_sequence load_i_type_seq;
    load_i_type_seq = load_i_type_sequence::type_id::create("load_i_type_seq", this);
    super.run_phase(phase);
    phase.raise_objection(this);
    super.run_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Executing riscv_load_regs_test run_phase()"), UVM_DEBUG)
    assert(load_i_type_seq.randomize());
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
    foreach(load_i_type_seq.inst_arr[i]) `uvm_info(get_type_name(), $sformatf("Printing inst_arr_%0f:%d", i, load_i_type_seq.inst_arr[i]), UVM_DEBUG);
    load_i_type_seq.start(rv_env.im_env.im_agent.im_sequencer);
    `uvm_info(get_type_name(), $sformatf("Finished riscv_load_regs_test run_phase()"), UVM_DEBUG)
     #1us;
    phase.drop_objection(this);
  endtask

endclass
