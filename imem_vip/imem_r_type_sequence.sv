class base_inst extends uvm_object;

  rand bit [6:0]func7;
  rand bit [4:0]rs1;
  rand bit [4:0]rs2;
  rand bit [2:0]func3;
  rand bit [4:0]rd;
  rand bit [6:0]opcode;

  function new(string name="base_inst");
    super.new(name);
  endfunction

`uvm_object_utils_begin(base_inst)
  `uvm_field_int(func7, UVM_ALL_ON)
  `uvm_field_int(rs1, UVM_ALL_ON)
  `uvm_field_int(rs2, UVM_ALL_ON)
  `uvm_field_int(func3, UVM_ALL_ON)
  `uvm_field_int(rd, UVM_ALL_ON)
  `uvm_field_int(opcode, UVM_ALL_ON)
`uvm_object_utils_end


endclass


class r_type_inst extends base_inst;

  function new(string name="r_type_inst");
    super.new(name);
  endfunction

  `uvm_object_utils(r_type_inst)

  constraint rs_c     { rs1 !=0; rs2!=0; rd!=0; }
  constraint opcode_c { opcode == 7'b0110011;   }
  constraint func7_c  { func7 inside {7'b0000000, 7'b0100000}; }
  constraint func3_c  { func3 inside {[0:7]}; }

endclass

class i_type_instruction extends base_inst;

  `uvm_object_utils_begin(i_type_instruction)
  `uvm_object_utils_end
  rand bit [11:0] imm_data;

  constraint imm_data_c        { imm_data == { func7 , rs1 }; }
  constraint imm_data_positive { imm_data[11]==1'b0; } //let's take only positive numbers
  constraint rs_c              { rs2 != 0; }
  constraint opcode_c          { opcode == 7'b0010011; }
  constraint func3_c           { func3 inside {2,3,4,6,7}; }

  function new(string name="i_type_instruction");
    super.new(name);
  endfunction


endclass


class imem_i_type_sequence extends uvm_sequence #(imem_sequence_item);

  `uvm_object_utils(imem_i_type_sequence)

   rand int inst_arr[];

  function new(string name="imem_i_type_sequence");
    super.new(name);
  endfunction


  task body();
    i_type_instruction it_inst;
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
    `uvm_info(get_type_name(), $sformatf("Executing imem_i_type_sequence"), UVM_DEBUG)

    //start_item(item);
    //finish_item(item);
    `uvm_send(item)
    `uvm_info(get_type_name(), $sformatf("Finished imem_i_type_sequence run, printing seq item"), UVM_DEBUG)
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
     item.print();
  endtask

endclass


class imem_r_type_sequence extends uvm_sequence #(imem_sequence_item);

  rand bit [31:0] inst_arr[$];
  `uvm_object_utils(imem_r_type_sequence)

  function new(string name="imem_r_type_sequence");
    super.new(name);
  endfunction

  task body();
    imem_sequence_item item;
    r_type_inst rt_inst;
    typedef bit [31:0] packed_32b_t;
    bit single_inst_arr[];
    int n_inst   = 100;
    rt_inst = new("rt_inst");
    item = imem_sequence_item::type_id::create("item");
    assert(item.randomize() with {inst_arr.size() == n_inst;});

    foreach(item.inst_arr[i])
      begin
        assert(rt_inst.randomize());
        rt_inst.pack(single_inst_arr);
        rt_inst.print();
        //item.inst_arr[i] = packed_32b_t'(single_inst_arr);
        item.inst_arr[i] = { >> {single_inst_arr} };
      end

    super.body();
    `uvm_info(get_type_name(), $sformatf("Executing imem_r_type_sequence"), UVM_DEBUG)

    //start_item(item);
    //finish_item(item);
    `uvm_send(item)
    `uvm_info(get_type_name(), $sformatf("Finished imem_r_type_sequence run, printing seq item"), UVM_DEBUG)
    `uvm_info(get_type_name(), $sformatf("Printing seq_item"), UVM_DEBUG)
     item.print();
  endtask

endclass
