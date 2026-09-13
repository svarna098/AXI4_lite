class axi_scoreboard extends uvm_scoreboard ;
  `uvm_component_utils (axi_scoreboard)

  uvm_tlm_analysis_fifo # (trans) in_mon_scb;
  uvm_tlm_analysis_fifo # (trans) out_mon_scb;
 
  trans e;
  trans out_mon_t;
 //trans e;              
  bit [31:0] mem [0:15];

typedef enum {idle, w_both, w_addr, w_data, w_resp} state_t;
state_t state;

typedef enum {r_idle, r_data} r_state_t;
r_state_t r_state;

bit [31:0] addr;
bit [31:0] Rdata;
bit [3:0]  strb;
bit [1:0] Rresp;
bit [1:0]Bresp;
bit AWready;
bit ARready;
bit Wready;
bit Bvalid;
bit aw_flag;
bit w_flag;


/*
  bit [31:0] mem [0:15];
  typedef enum {idle ,w_both,w_addr,w_data ,w_resp} state_t;
  state_t state;
  typedef enum { r_idle , r_data } r_state_t;
  r_state_t r_state;
  reg n_state , r_n_state;
*/
  function new ( string name="axi_scoreboard" ,uvm_component parent);
       super.new (name,parent);
       in_mon_scb = new ("in_mon_scb",this);
       out_mon_scb =new ("out_mon_scb",this);
        // e = new("e");
   endfunction

 task run_phase (uvm_phase phase);
     super.run_phase (phase);
      
     forever begin
      in_mon_scb.get (e);
       reference ();
        `uvm_info ("axi_in_monitor_scb " , $sformatf("axi_in_monitor : awvalid=%d | awaddr=%d |  wvalid=%d  | wdata=%d | bready=%d | arvalid=%d | araddr=%d | rready=%d | arprot=%d |  awprot=%d | wstrb=%d |",e.AWVALID ,e.AWADDR ,e.WVALID ,e.WDATA ,e.BREADY ,e.ARVALID ,e.ARADDR ,e.RREADY ,e.ARPROT ,e.AWPROT ,e.WSTRB),UVM_NONE)
     
      out_mon_scb.get (out_mon_t);
       compare (out_mon_t );
      `uvm_info ("axi_out_monitor_scb" , $sformatf("axi_out_monitor : awready=%d | wready=%d |  bresp=%d  | bvalid=%d | arready=%d | rdata=%d | rresp=%d | rvalid=%d |",out_mon_t.AWREADY , out_mon_t.WREADY ,out_mon_t.BRESP ,out_mon_t.BVALID ,out_mon_t.ARREADY ,out_mon_t.RDATA ,out_mon_t.RRESP ,out_mon_t.RVALID ),UVM_NONE)
     end
 endtask
/*
 task compare(trans r);
 
  if (r.AWREADY == AWready)
      $display ( "pass  :: dut_awready = %d  |  e_awready =%d " , r.AWREADY ,AWready );
      else
      $display ( "fail  :: dut_awready = %d  |  e_awready =%d " , r.AWREADY ,AWready );
  
  if (r.WREADY ==Wready )
    $display ( "pass  :: dut_wready = %d  |  e_wready =%d " , r.WREADY ,Wready );
    else
    $display ( "fail  :: dut_wready = %d  |  e_wready =%d " , r.WREADY ,Wready );
       
  if (r.BRESP == e.BRESP )
    $display ( "pass  :: dut_bresp = %d  |  e_bresp =%d " , r.BRESP ,e.BRESP );
    else
    $display ( "fail  :: dut_bresp = %d  |  e_bresp =%d " , r.BRESP ,e.BRESP );


  if (r.BVALID == Bvalid )
   $display ( "pass  :: dut_valid = %d  |  e_valid =%d " , r.BVALID ,Bvalid );
   else
   $display ( "fail  :: dut_valid = %d  |  e_valid =%d " , r.BVALID ,Bvalid );
  
  if (r.ARREADY == ARready )
  $display ( "pass  :: dut_arready = %d  |  e_arready =%d " , r.ARREADY ,ARready );
  else
  $display ( "fail  :: dut_arready = %d  |  e_arready =%d " , r.ARREADY ,ARready );

 if (r.RDATA ==e.RDATA )
  $display ( "pass  :: dut_rdata = %d  |  e_rdata =%d " , r.RDATA ,e.RDATA );
  else
  $display ( "fail  :: dut_rdata = %d  |  e_rdata =%d " , r.RDATA ,e.RDATA );

 if (r.RRESP == e.RRESP)
  $display ( "pass  :: dut_rresp = %d  |  e_rresp =%d " , r.RRESP ,e.RRESP );
  else
  $display ( "fail  :: dut_rresp = %d  |  e_rresp =%d " , r.RRESP ,e.RRESP );

 if (r.RVALID == e.RVALID )
  $display ( "pass  :: dut_rvalid = %d  |  e_rvalid =%d " , r.RVALID ,e.RVALID );
  else
  $display ( "fail  :: dut_rvalid = %d  |  e_rvalid =%d " , r.RVALID ,e.RVALID );

endtask
*/
task compare(trans r);

  if(r.AWREADY === AWready)
    `uvm_info("AWREADY",$sformatf("PASS - DUT_AWREADY=%0d e_AWREADY=%0d",r.AWREADY, AWready), UVM_NONE)
  else
    `uvm_info("AWREADY",$sformatf("FAIL - DUT_AWREADY=%0d e_AWREADY=%0d",r.AWREADY, AWready), UVM_NONE)

  if(r.WREADY === Wready)
    `uvm_info("WREADY", $sformatf("PASS - DUT_WREADY=%0d e_WREADY=%0d",r.WREADY, Wready), UVM_NONE)
  else
    `uvm_info("WREADY",$sformatf("FAIL - DUT_WREADY=%0d e_WREADY=%0d",r.WREADY, Wready), UVM_NONE)

  if(r.BVALID === Bvalid)
    `uvm_info("BVALID",$sformatf("PASS - DUT_BVALID=%0d e_BVALID=%0d",r.BVALID, Bvalid), UVM_NONE)
  else
    `uvm_info("BVALID",$sformatf("FAIL - DUT_BVALID=%0d e_BVALID=%0d",r.BVALID, Bvalid), UVM_NONE)

  if(r.BRESP === e.BRESP)
    `uvm_info("BRESP", $sformatf("PASS - DUT_BRESP=%0d e_BRESP=%0d",r.BRESP, Bresp), UVM_NONE)
  else
    `uvm_info("BRESP",$sformatf("FAIL - DUT_BRESP=%0d e_BRESP=%0d",r.BRESP, Bresp), UVM_NONE)

  if(r.ARREADY === ARready)
    `uvm_info("ARREADY",$sformatf("PASS - DUT_ARREADY=%0d e_ARREADY=%0d",r.ARREADY, ARready), UVM_NONE)
  else
    `uvm_info("ARREADY",$sformatf("FAIL - DUT_ARREADY=%0d e_ARREADY=%0d",r.ARREADY, ARready), UVM_NONE)

  if(r.RVALID === e.RVALID)
    `uvm_info("RVALID",$sformatf("PASS - DUT_RVALID=%0d e_RVALID=%0d",r.RVALID, e.RVALID), UVM_NONE)
  else
    `uvm_info("RVALID", $sformatf("FAIL - DUT_RVALID=%0d e_RVALID=%0d",r.RVALID, e.RVALID), UVM_NONE)

  if(r.RRESP === e.RRESP)
    `uvm_info("RRESP", $sformatf("PASS - DUT_RRESP=%0d e_RRESP=%0d",r.RRESP, Rresp), UVM_NONE)
  else
    `uvm_info("RRESP",$sformatf("FAIL - DUT_RRESP=%0d e_RRESP=%0d",r.RRESP, Rresp), UVM_NONE)

  if(r.RDATA === e.RDATA)
    `uvm_info("RDATA",$sformatf("PASS - DUT_RDATA=%0d e_RDATA=%0d",r.RDATA, Rdata), UVM_NONE)
  else
    `uvm_info("RDATA",$sformatf("FAIL - DUT_RDATA=%0d e_RDATA=%0d",r.RDATA, Rdata), UVM_NONE)

   $display("----------------------------------------------------------------------------------");
endtask
/*
task reference (trans e);

//bit flag;

if(e.WVALID)
    Wready <= 1'b1;
if(e.AWVALID)
    AWready <= 1'b1;


case (state)
 idle: if( e.WVALID && e.AWVALID)
            n_state <= w_both;
        else
            n_state <= idle;
 w_both: if (Wready && AWready)
             n_state <= w_addr;
         else
             n_state <= w_both;
 w_addr : begin
            addr<=e.AWADDR;
            n_state <= w_data;
          end
 w_data : begin
            mem[addr] <= e.WDATA;
            n_state <= e_resp;
          end
 w_resp : begin
           if(Bvalid) begin
             if(e.BREADY) begin
                
                


case (r_state)
 r_idle : if (e.ARVALID) begin
            if (ARready) begin
              r_n_state <= r_data;
           end
          end
 r_data : if ( e.RVALID)begin
            if (e.RREADY) begin
              RDATA <= mem[addr];
            end
          end
 default : n_state <= r_idle;
 
*/
  /*     
  task reference(trans e);

 
  AWready = 0;
  Wready  = 0;
  Bvalid  = 0;
  e.BRESP   = 0;

  ARready = 0;
  e.RVALID  = 0;
  e.RRESP   = 0;
  e.RDATA   = 0;

 case(state)

      idle: begin
        aw_flag = 0;
        w_flag  = 0;

        if(e.AWVALID && e.WVALID)
          state = w_both;
      end


      w_both: begin

        AWready = 1;
        Wready  = 1;

        if(e.AWVALID && AWready && !aw_flag) begin
          addr    = e.AWADDR;
          aw_flag = 1;
          AWready = 0;
        end

        if(e.WVALID && Wready && !w_flag) begin
          data    = e.WDATA;
          strb    = e.WSTRB;
          w_flag  = 1;
          Wready = 0;
        end

        if(aw_flag && w_flag)
          state = w_resp;
        else if(aw_flag)
          state = w_data;
        else if(w_flag)
          state = w_addr;

      end


      w_addr: begin

        AWready = 1;

        if(e.AWVALID && AWready) begin
          addr    = e.AWADDR;
          aw_flag = 1;
          AWready = 0;

          if(w_flag)
            state = w_resp;
        end

      end


      w_data: begin

        Wready = 1;

        if(e.WVALID && Wready) begin
          data    = e.WDATA;
          strb    = e.WSTRB;
          w_flag  = 1;
          Wready = 0;

          if(aw_flag)
            state = w_resp;
        end

      end


      w_resp: begin

        Bvalid = 1;

        if(addr > 32'h3C)
          e.BRESP = 2'b11;

        else if(addr[5:2] >= 10 && addr[5:2] <= 12)
          e.BRESP = 2'b10;

        else begin
          e.BRESP = 2'b00;

          if(strb[0]) mem[addr[5:2]][7:0]   = data[7:0];
          if(strb[1]) mem[addr[5:2]][15:8]  = data[15:8];
          if(strb[2]) mem[addr[5:2]][23:16] = data[23:16];
          if(strb[3]) mem[addr[5:2]][31:24] = data[31:24];
        end

        if(e.BREADY)
          state = idle;

      end

    endcase
  
  case(r_state)

  r_idle : begin
    ARready = 1;

    if(e.ARVALID) begin
      addr = e.ARADDR;
      r_state = r_data;
    end
  end


  r_data : begin

    e.RVALID = 1;

    
    if(addr [5:2]>15) begin
      e.RRESP = 2'b11;      
      e.RDATA = 32'd0;
    end
 
    else if(addr[5:2] >= 13 && addr[5:2] <= 14) begin
      e.RRESP = 2'b10;     
      e.RDATA = 32'd0;
    end

    
    else begin
      e.RRESP = 2'b00;     
      e.RDATA = mem[addr[5:2]];
    end

    
    if(e.RREADY)
      r_state = r_idle;

  end

endcase

endtask
endclass
*/

task reference();

  

 case(state)

  idle : begin

    AWready = 1;
    Wready  = 1;
    Bvalid  = 0;

    aw_flag = 0;
    w_flag  = 0;

    if(e.AWVALID && e.WVALID)
      state = w_both;

  end


  w_both : begin

    AWready = 1;
    Wready  = 1;

    if(e.AWVALID && AWready && !aw_flag) begin
      addr    = e.AWADDR;
      aw_flag = 1;
    end

    if(e.WVALID && Wready && !w_flag) begin
      Rdata    = e.WDATA;
      strb    = e.WSTRB;
      w_flag  = 1;
    end

    if(aw_flag && w_flag)
      state = w_resp;
    else if(aw_flag)
      state = w_data;
    else if(w_flag)
      state = w_addr;

  end


  w_addr : begin

    AWready = 1;
    Wready  = 0;

    if(e.AWVALID && AWready) begin
      addr    = e.AWADDR;
      aw_flag = 1;

      if(w_flag)
        state = w_resp;
    end

  end


  w_data : begin

    AWready = 0;
    Wready  = 1;

    if(e.WVALID && Wready) begin
      Rdata    = e.WDATA;
      strb    = e.WSTRB;
      w_flag  = 1;

      if(aw_flag)
        state = w_resp;
    end

  end


  w_resp : begin

    AWready = 0;
    Wready  = 0;
    Bvalid  = 1;

    if(addr > 32'h3C)
      Bresp = 2'b11;
    else if((addr/4) >= 10 && (addr/4) <= 12)
      Bresp = 2'b10;
    else begin
      Bresp = 2'b00;

      if(strb[0]) mem[addr/4][7:0]   = Rdata[7:0];
      if(strb[1]) mem[addr/4][15:8]  = Rdata[15:8];
      if(strb[2]) mem[addr/4][23:16] = Rdata[23:16];
      if(strb[3]) mem[addr/4][31:24] = Rdata[31:24];
    end

    if(e.BREADY)
      state = idle;

  end

endcase

  case(r_state)

    r_idle: begin

      ARready = 1;

      if(e.ARVALID &&ARready) begin
        addr    = e.ARADDR;
        r_state = r_data;
      end

    end

    r_data: begin

      if(e.RVALID == 1)begin

      if(addr > 32'h3C) begin
        Rresp = 2'b11;
        Rdata = 32'd0;
      end

      else if((addr/4) >= 13 && (addr/4) <= 14) begin
        Rresp = 2'b10;
        Rdata = 32'd0;
      end

      else begin
        Rresp = 2'b00;
        Rdata = mem[addr/4];
      end

      if(e.RREADY)
        r_state = r_idle;

    end
end
  endcase

endtask
endclass
   

