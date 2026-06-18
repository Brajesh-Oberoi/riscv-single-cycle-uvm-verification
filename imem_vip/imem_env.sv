class imem_env extends uvm_env;

  `uvm_component_utils(imem_env);

  imem_agent      im_agent;
  imem_scoreboard im_scoreboard;
  imem_coverage   im_coverage;


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    im_agent    = imem_agent::type_id::create("im_agent", this);
    im_coverage = imem_coverage::type_id::create("im_coverage", this);
    im_scoreboard = imem_scoreboard::type_id::create("im_scoreboard", this);
  endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    im_agent.im_ap.connect(im_scoreboard.im_agent_export);
    im_agent.im_ap.connect(im_coverage.analysis_export);
  endfunction



endclass
