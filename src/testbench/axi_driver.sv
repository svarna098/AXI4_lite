/*
class axi_drv extends uvm_driver #(trans);
  
   axi_config cfg;
   virtual axi_if.drv vif ;
  `uvm_component_utils (axi_drv);
   

   function new ( string name= "axi_drv" , uvm_component parent );
     super.new ( name , parent );
   endfunction

   function void build_phase ( build_phase phase );
      super.build_phase (phase);
    if (!uvm_config_db #( axi_config ):: get ("this"," " , axi_config ,cfg);
        `uvm_fatal ( get_type_name() , " driver config fail ")
   endfunction

  function void connect_phase (connect_phase phase);
      super.connect_phase (phase);
      vif=cfg.vif;
  endfunction

   task run_phase ();
      
        forever begin
             seq_item_port.get_next_item (req);
             drive_in (req);
             seq_item_port.item_done ();
        end

   endtask
  

  task drive_in (trans d);

     @(vif.drv_if)

       
       vif.drv_if.AWVALID <= d.AWVALID;
       vif.drv_if.WVALID <= d.WVALID;
       vif.drv_if.ARVALID <= d.ARVALID;
       vif.drv_if.RREADY <= d.RREADY;
       vif.drv_if.ARPROT <=d.ARPROT;
       vif.drv_if.WSTRB <= d.WSTRB;
       vif.drv_if.AWPROT <= d.AWPROT;
       

       if (d.AWVALID)
           wait (vif.drv_if.AWREADY)
               vif.drv_if.AWADDR <= d.AWADDR;
           // vif.drv_if.AWADDR <= d.AWADDR;

       if (d.WVALID)
            wait (vif.drv_if.WREADY )
               vif.drv_if.WDATA <= d.WDATA;
          //  vif.drv_if.WDATA <= d.WDATA;
       
       if (d.ARVALID )
           vif.drv_if.ARADDR <= d.ARADDR;
       
      
 endtask

endclass


*/


class axi_drv extends uvm_driver #(trans);
  
   axi_config cfg;
   virtual axi_if.drv vif ;
  `uvm_component_utils (axi_drv);
   
    bit [31:0] temp_addr ;
    bit [31:0] temp_data ;
    bit [31:0] temp_raddr ;
        bit aw_flag = 0;
    bit w_flag  = 0;



   function new ( string name= "axi_drv" , uvm_component parent );
     super.new ( name , parent );
   endfunction

   function void build_phase ( uvm_phase phase );
      super.build_phase (phase);
    if (!uvm_config_db #( axi_config ):: get (this," " , "axi_config",cfg))
        `uvm_fatal ( get_type_name() , " driver config fail ")
   endfunction

  function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      vif=cfg.vif;
  endfunction

   task run_phase (uvm_phase phase);
       wait (vif.drv_if.rst == 1) begin
        forever begin
             seq_item_port.get_next_item (req);
             drive_in (req);
             seq_item_port.item_done ();
              
        end
end
   endtask
  
/*
  task drive_in (trans d);

     @(vif.drv_if)
       
       vif.drv_if.AWVALID <= d.AWVALID;
       vif.drv_if.WVALID <= d.WVALID;
       vif.drv_if.ARVALID <= d.ARVALID;
       vif.drv_if.RREADY <= d.RREADY;
       vif.drv_if.ARPROT <=d.ARPROT;
       vif.drv_if.WSTRB <= d.WSTRB;
       vif.drv_if.AWPROT <= d.AWPROT;
       //vif.drv_if.AWADDR <=d.AWADDR;
       //vif.drv_if.WDATA <= d.WDATA;
       
       
     

       if (d.AWVALID) begin
               temp_addr <= d.AWADDR;
           if(vif.drv_if.AWREADY)
               vif.drv_if.AWADDR <= temp_addr;
           // vif.drv_if.AWADDR <= d.AWADDR;
       end

       if (d.WVALID) begin
             temp_data <= d.WDATA;
            if (vif.drv_if.WREADY)
               vif.drv_if.WDATA <= temp_data ;
          //  vif.drv_if.WDATA <= d.WDATA;
       end
      
      if (vif.drv_if.AWREADY && vif.drv_if.WREADY)
            vif.drv_if.BREADY <= d.BREADY;
     
            

       if (d.ARVALID) begin
               temp_raddr <= d.ARADDR;

           if (vif.drv_if.ARREADY)
           vif.drv_if.ARADDR <= temp_raddr;
        end

      if(d.RVALID) begin
           vif.drv_if.RREADY <= d.RREADY;
       end
             
 endtask

endclass

*/
/*
task drive_in(trans d);

  aw_flag = 0;
  w_flag  = 0;

  @(vif.drv_if);

  // ---------------- RESET ----------------
  if (!vif.drv_if.rst) begin
    vif.drv_if.AWVALID <= 0;
    vif.drv_if.WVALID  <= 0;
    vif.drv_if.ARVALID <= 0;
    vif.drv_if.BREADY  <= 0;
    vif.drv_if.RREADY  <= 0;
    return;
  end

  // Drive protection and strobe
  vif.drv_if.AWPROT <= d.AWPROT;
  vif.drv_if.ARPROT <= d.ARPROT;
  vif.drv_if.WSTRB  <= d.WSTRB;

  // ---------------- WRITE ADDRESS ----------------
  if (d.AWVALID && !aw_flag) begin
    vif.drv_if.AWADDR  <= d.AWADDR;
    vif.drv_if.AWVALID <= 1;

    while (!vif.drv_if.AWREADY)
      @(vif.drv_if);

    aw_flag = 1;
    vif.drv_if.AWVALID <= 0;
  end

  // ---------------- WRITE DATA ----------------
  if (d.WVALID && !w_flag) begin
    vif.drv_if.WDATA  <= d.WDATA;
    vif.drv_if.WVALID <= 1;

    while (!vif.drv_if.WREADY)
      @(vif.drv_if);

    w_flag = 1;
    vif.drv_if.WVALID <= 0;
  end

  // ---------------- WRITE RESPONSE ----------------
  if (aw_flag && w_flag) begin
    vif.drv_if.BREADY <= 1;

    while (!vif.drv_if.BVALID)
      @(vif.drv_if);

    // BRESP is sampled by monitor/scoreboard
    vif.drv_if.BREADY <= 0;
  end

  // ---------------- READ ADDRESS ----------------
  if (d.ARVALID) begin
    vif.drv_if.ARADDR  <= d.ARADDR;
    vif.drv_if.ARVALID <= 1;

    while (!vif.drv_if.ARREADY)
      @(vif.drv_if);

    vif.drv_if.ARVALID <= 0;

    // ---------------- READ DATA ----------------
    vif.drv_if.RREADY <= 1;

    while (!vif.drv_if.RVALID)
      @(vif.drv_if);

    vif.drv_if.RREADY <= 0;
  end

endtask
*/
/*
task drive_in(trans d);

  bit aw_flag = 0;
  bit w_flag  = 0;
  int timeout;

  @(vif.drv_if);

  // ---------------- RESET ----------------
  if (!vif.drv_if.rst) begin
    vif.drv_if.AWVALID <= 0;
    vif.drv_if.WVALID  <= 0;
    vif.drv_if.ARVALID <= 0;
    vif.drv_if.BREADY  <= 0;
    vif.drv_if.RREADY  <= 0;
    vif.drv_if.AWADDR  <= 0;
    vif.drv_if.WDATA   <= 0;
    vif.drv_if.ARADDR  <= 0;
   
  end

  // Default outputs
  vif.drv_if.AWPROT <= d.AWPROT;
  vif.drv_if.ARPROT <= d.ARPROT;
  vif.drv_if.WSTRB  <= d.WSTRB;
  vif.drv_if.BREADY <= 0;
  vif.drv_if.RREADY <= 0;

  //========================================================
  // WRITE ADDRESS CHANNEL
  //========================================================
  if (d.AWVALID) begin
    vif.drv_if.AWADDR  <= d.AWADDR;
    vif.drv_if.AWVALID <= 1;

    timeout = 20;
    while (!vif.drv_if.AWREADY && timeout > 0) begin
      @(vif.drv_if);
      timeout--;
    end

    if (timeout == 0)
      `uvm_error("DRIVER","Timeout waiting for AWREADY")
    else 
      aw_flag = 1;

    vif.drv_if.AWVALID <= 0;
  end

  //========================================================
  // WRITE DATA CHANNEL
  //========================================================
  if (d.WVALID) begin
    vif.drv_if.WDATA  <= d.WDATA;
    vif.drv_if.WVALID <= 1;

    timeout = 20;
    while (!vif.drv_if.WREADY && timeout > 0) begin
      @(vif.drv_if);
      timeout--;
    end

    if (timeout == 0)
      `uvm_error("DRIVER","Timeout waiting for WREADY")
    else
      w_flag = 1;

    vif.drv_if.WVALID <= 0;
  end

  //========================================================
  // WRITE RESPONSE CHANNEL
  //========================================================
  if (aw_flag && w_flag) begin
    vif.drv_if.BREADY <= 1;

    timeout = 20;
    while (!vif.drv_if.BVALID && timeout > 0) begin
      @(vif.drv_if);
      timeout--;
    end

    if (timeout == 0)
      `uvm_error("DRIVER","Timeout waiting for BVALID")

    vif.drv_if.BREADY <= 0;
  end

  //========================================================
  // READ ADDRESS CHANNEL
  //========================================================
  if (d.ARVALID) begin
    vif.drv_if.ARADDR  <= d.ARADDR;
    vif.drv_if.ARVALID <= 1;

    timeout = 20;
    while (!vif.drv_if.ARREADY && timeout > 0) begin
      @(vif.drv_if);
      timeout--;
    end

    if (timeout == 0)
      `uvm_error("DRIVER","Timeout waiting for ARREADY")

    vif.drv_if.ARVALID <= 0;

    //====================================================
    // READ DATA CHANNEL
    //====================================================
    vif.drv_if.RREADY <= 1;

    timeout = 20;
    while (!vif.drv_if.RVALID && timeout > 0) begin
      @(vif.drv_if);
      timeout--;
    end

    if (timeout == 0)
      `uvm_error("DRIVER","Timeout waiting for RVALID")

    vif.drv_if.RREADY <= 0;
  end
`uvm_info ("axi_driver " , $sformatf("axi_in_monitor : awvalid=%d | awaddr=%d |  wvalid=%d  | wdata=%d | bready=%d | arvalid=%d | araddr=%d | rready=%d | arprot=%d | awprot=%d | wstrb=%d |",d.AWVALID , d.AWADDR ,d.WVALID ,d.WDATA ,d.BREADY ,d.ARVALID ,d.ARADDR ,d.RREADY ,d.ARPROT ,d.AWPROT ,d.WSTRB),UVM_NONE)
    
endtask
endclass
*/

task drive_in(trans d);


     if (!vif.drv_if.rst) begin

        vif.drv_if.AWVALID <= 0;
        vif.drv_if.WVALID  <= 0;
        vif.drv_if.ARVALID <= 0;

        vif.drv_if.BREADY  <= 0;
        vif.drv_if.RREADY  <= 0;

        vif.drv_if.AWADDR  <= 0;
        vif.drv_if.WDATA   <= 0;
        vif.drv_if.ARADDR  <= 0;

        vif.drv_if.AWPROT  <= 0;
        vif.drv_if.ARPROT  <= 0;
        vif.drv_if.WSTRB   <= 0;
  end

    
    else begin
    @(vif.drv_if) 
    vif.drv_if.AWVALID <= d.AWVALID;
    vif.drv_if.WVALID  <= d.WVALID;
    vif.drv_if.ARVALID <= d.ARVALID;
    vif.drv_if.RREADY  <= d.RREADY;

    vif.drv_if.ARPROT  <= d.ARPROT;
    vif.drv_if.WSTRB   <= d.WSTRB;
    vif.drv_if.AWPROT  <= d.AWPROT;


    //========================================
    // WRITE ADDRESS
    //========================================
    if (d.AWVALID && aw_flag == 0) begin

        vif.drv_if.AWADDR <= d.AWADDR;
        aw_flag = 1;

    end


    //========================================
    // WRITE DATA
    //========================================
    if (d.WVALID && w_flag == 0) begin

        vif.drv_if.WDATA <= d.WDATA;
        w_flag = 1;

    end


    //========================================
    // CHECK ADDRESS HANDSHAKE
    //========================================
    if (aw_flag == 1 &&d.AWVALID &&vif.drv_if.AWREADY) begin

        aw_flag = 0;
     //   vif.drv_if.AWVALID <= 0;

    end


    //========================================
    // CHECK DATA HANDSHAKE
    //========================================
    if (w_flag == 1 && d.WVALID&& vif.drv_if.WREADY) begin

        w_flag = 0;
      //  vif.drv_if.WVALID <= 0;

    end


    //========================================
    // WRITE RESPONSE
    //========================================
    if (aw_flag == 0 && w_flag == 0) begin
        vif.drv_if.BREADY <= d.BREADY;
    end


    //========================================
    // READ ADDRESS
    //========================================
    if (d.ARVALID) begin
        vif.drv_if.ARADDR <= d.ARADDR;
    end



    end
`uvm_info ("axi_driver " , $sformatf("axi_driver : awvalid=%d | awaddr=%d |  wvalid=%d  | wdata=%d | bready=%d | arvalid=%d | araddr=%d | rready=%d | arprot=%d | awprot=%d | wstrb=%d |",d.AWVALID , d.AWADDR ,d.WVALID ,d.WDATA ,d.BREADY ,d.ARVALID ,d.ARADDR ,d.RREADY ,d.ARPROT ,d.AWPROT ,d.WSTRB),UVM_NONE)
endtask

endclass


