class imem_agent extends uvm_agent;

`uvm_component_utils(imem_agent)

imem_driver     im_driver;
imem_sequencer  im_sequencer;
imem_monitor    im_monitor;
imem_config     im_cfg;

uvm_analysis_port #(imem_sequence_item) im_ap;
function new (string name, uvm_component parent);
  super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  im_driver     = imem_driver::type_id::create("im_driver", this);
  im_sequencer  = imem_sequencer::type_id::create("im_sequencer", this);
  im_monitor    = imem_monitor::type_id::create("im_monitor", this);
  im_ap            = new("im_ap", this);
  //if(!uvm_config_db#(imem_config)::get(this, "*", "imem_cfg", im_cfg))
    //`uvm_info(get_type_name(), $sformatf("imem_cfg not found"), UVM_DEBUG)
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  im_driver.seq_item_port.connect(im_sequencer.seq_item_export);
  im_monitor.mon_ap.connect(im_ap);
endfunction

endclass





