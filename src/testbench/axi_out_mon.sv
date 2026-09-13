class output_monitor extends uvm_monitor;
  `uvm_component_utils (output_monitor)

   virtual axi_if.out_mon vif;
   axi_config cfg;
   uvm_analysis_port #(trans) out_monf;
   trans out_m;

  function new (string name="output_monitor" ,uvm_component parent);
     super.new (name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if (!uvm_config_db # (axi_config) :: get (this," " , "axi_config" , cfg ))
          `uvm_fatal ( get_type_name() , "out_mon config error")
    out_monf=new ("out_monf" ,this);
  endfunction

  function void connect_phase (uvm_phase phase);
    super.connect_phase (phase);
    vif=cfg.vif;
  endfunction

  task run_phase ( uvm_phase phase);
    super.run_phase (phase);
   
    forever begin
      out_m =trans::type_id::create ("out_m");
      out_mon_drive ();
     
    end
  
  endtask

  task out_mon_drive;
     @(vif.out_mon_if)
      begin
       out_m.AWREADY = vif.out_mon_if.AWREADY;
       out_m.WREADY = vif.out_mon_if.WREADY;
       out_m.BRESP = vif.out_mon_if.BRESP;
       out_m.BVALID =vif.out_mon_if.BVALID;
       out_m.ARREADY =vif.out_mon_if.ARREADY;
       out_m.RDATA =vif.out_mon_if.RDATA;
       out_m.RRESP =vif.out_mon_if.RRESP;
       out_m.RVALID =vif.out_mon_if.RVALID;
     end
      out_monf.write (out_m);
        `uvm_info ("axi_out_monitor " , $sformatf("axi_out_monitor : awready=%d | wready=%d |  bresp=%d  | bvalid=%d | arready=%d | rdata=%d | rresp=%d | rvalid=%d |",out_m.AWREADY , out_m.WREADY ,out_m.BRESP ,out_m.BVALID ,out_m.ARREADY ,out_m.RDATA ,out_m.RRESP ,out_m.RVALID ),UVM_NONE)
       $display("---------------------------------------------------");
    
  endtask

 endclass
 
