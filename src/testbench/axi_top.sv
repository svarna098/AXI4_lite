`include "axi_package.sv"
`include "axi_interface.sv"
`include "axi_design.sv"
module axi_top ();
  import uvm_pkg ::*;
  import axi_package ::*;
  
   bit clk;
bit rst;
   axi_if inf (clk ,rst);

 axi4_lite_slave dut (
    .ACLK    (clk),
    .ARESETn (rst),

    .AWADDR  (inf.AWADDR),
    .AWPROT  (inf.AWPROT),
    .AWVALID (inf.AWVALID),
    .AWREADY (inf.AWREADY),

    .WDATA   (inf.WDATA),
    .WSTRB   (inf.WSTRB),
    .WVALID  (inf.WVALID),
    .WREADY  (inf.WREADY),

    .BRESP   (inf.BRESP),
    .BVALID  (inf.BVALID),
    .BREADY  (inf.BREADY),

    .ARADDR  (inf.ARADDR),
    .ARPROT  (inf.ARPROT),
    .ARVALID (inf.ARVALID),
    .ARREADY (inf.ARREADY),

    .RDATA   (inf.RDATA),
    .RRESP   (inf.RRESP),
    .RVALID  (inf.RVALID),
    .RREADY  (inf.RREADY)
  );

   

   initial begin
      uvm_config_db # (virtual axi_if) :: set (null,"*","axi_if",inf);
       run_test ("test1");
   end

   initial begin
     rst =1'b0;
      # 12;
     rst =1'b1;
   end

   initial begin
       clk=1'b0;
       
         forever
 #5 clk=~clk;
   end

endmodule
