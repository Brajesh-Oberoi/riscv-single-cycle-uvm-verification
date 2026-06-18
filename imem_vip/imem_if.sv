interface imem_if;


logic [31:0]imem_data;
logic [31:0]prgm_cntr;

modport driver_modport (
  output imem_data,
  input prgm_cntr
);



task collect_transactions();
endtask


task collect();
endtask


endinterface
