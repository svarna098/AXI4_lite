class axi_environment extends uvm_env ;
 `uvm_component_utils (axi_environment)

 axi_config cfg;
 in_agent in_agnt;
 out_agent out_agnt;
  axi_scoreboard scb;
 axi_subscriber sub;
 
 function new (string name="axi_enviroment" ,uvm_component parent);
    super.new (name ,parent );
 endfunction

 function void build_phase (uvm_phase phase);
     super.build_phase (phase);
     if (! uvm_config_db #(axi_config) :: get ( this ," " ,"axi_config" ,cfg))
          `uvm_fatal (get_type_name() , "environment config fail")
   
     in_agnt = in_agent ::type_id ::create ("in_agnt",this);
     out_agnt =out_agent ::type_id ::create ("out_agnt",this);
     scb =axi_scoreboard ::type_id :: create ("scb",this);
     sub= axi_subscriber ::type_id ::create ("sub" ,this);
 endfunction

 function void connect_phase (uvm_phase phase );
    super.connect_phase (phase );
    in_agnt.in_mon.in_monf.connect (scb.in_mon_scb.analysis_export);
    out_agnt.out_mon.out_monf.connect(scb.out_mon_scb.analysis_export);
    in_agnt.in_mon.in_monf.connect(sub.analysis_export);
 endfunction

endclass

  
