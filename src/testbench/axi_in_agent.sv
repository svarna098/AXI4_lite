class in_agent extends uvm_agent;
   `uvm_component_utils (in_agent)

    axi_config cfg;
    axi_drv drv;
    input_monitor in_mon;
    axi_sequencer seq;

    function new ( string name="in_agent" ,uvm_component parent);
        super.new (name ,parent);
    endfunction

   function void build_phase (uvm_phase phase);
      super.build_phase (phase );
      if (!uvm_config_db #(axi_config) ::get (this , " " ,"axi_config" ,cfg))
          `uvm_fatal (get_type_name() ,"input agent config fail")
         in_mon =input_monitor::type_id ::create ("in_mon" ,this);
      if (cfg.input_agent_is_active == UVM_ACTIVE )
        begin
         seq =axi_sequencer::type_id ::create ("seq" ,this);
         drv =axi_drv ::type_id::create ("drv",this);
        end
   endfunction

  function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
     if (cfg.input_agent_is_active == UVM_ACTIVE )
        begin
            drv.seq_item_port.connect ( seq.seq_item_export);
        end
   endfunction

endclass

