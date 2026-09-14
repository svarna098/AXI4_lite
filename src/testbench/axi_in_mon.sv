class input_monitor extends uvm_monitor;

  `uvm_component_utils (input_monitor)
 
   uvm_analysis_port #(trans) in_monf;
   virtual axi_if.in_mon vif;
   axi_config cfg;
   trans m;

   function new ( string name ="input_monitor" , uvm_component parent);
       super.new (name ,parent);
   endfunction

  function void build_phase (uvm_phase phase);
  
    super.build_phase (phase);
    if (!uvm_config_db # (axi_config) :: get (this," " , "axi_config" , cfg ))
          `uvm_fatal ( get_type_name() , "in_mon config error")
    in_monf =new ("in_monf" ,this);
  endfunction

 
  function void connect_phase (uvm_phase phase );
     super.connect_phase (phase);
     vif =cfg.vif;
  endfunction

  task run_phase (uvm_phase phase);
     super.run_phase(phase);
     
    forever begin
       m =trans::type_id::create ("m");
       mon_data ();
       
  end
  endtask
 
  task mon_data ;
    @(vif.in_mon_if)  
      begin
       m.AWVALID = vif.in_mon_if.AWVALID;
       m.AWADDR =vif.in_mon_if.AWADDR;
       m.WVALID =vif.in_mon_if.WVALID;
       m.WDATA =vif.in_mon_if.WDATA;
       m.BREADY =vif.in_mon_if.BREADY;
       m.ARVALID =vif.in_mon_if.ARVALID;
       m.ARADDR = vif.in_mon_if.ARADDR;
       m.RREADY = vif.in_mon_if.RREADY;
       m.ARPROT =vif.in_mon_if.ARPROT;
       m.AWPROT =vif.in_mon_if.AWPROT;
       m.WSTRB =vif.in_mon_if.WSTRB;

        
     end
      in_monf.write(m);
       `uvm_info ("axi_in_monitor " , $sformatf("axi_in_monitor : awvalid=%d | awaddr=%d |  wvalid=%d  | wdata=%d | bready=%d | arvalid=%d | araddr=%d | rready=%d | arprot=%d | awprot=%d | wstrb=%d |",m.AWVALID , m.AWADDR ,m.WVALID ,m.WDATA ,m.BREADY ,m.ARVALID ,m.ARADDR ,m.RREADY ,m.ARPROT ,m.AWPROT ,m.WSTRB),UVM_NONE)
    
      $display("------------------------------------------");

    endtask
endclass
