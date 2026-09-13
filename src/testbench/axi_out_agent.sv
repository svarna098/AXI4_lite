class out_agent extends uvm_agent;
   `uvm_component_utils (out_agent)

   axi_config cfg;
   output_monitor out_mon;
   
  function new (string name =" out_agent" , uvm_component parent);
      super.new (name ,parent);
  endfunction

 function void build_phase (uvm_phase phase);
    super.build_phase (phase);
  if (!uvm_config_db #(axi_config) :: get (this ," " ,"axi_config" ,cfg))
      `uvm_fatal (get_type_name() ,"output agent config fail")

  if (cfg.output_agent_is_active ==UVM_PASSIVE )
      out_mon = output_monitor :: type_id :: create ("out_mon" ,this);
  endfunction

endclass

