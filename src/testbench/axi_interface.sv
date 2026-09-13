interface axi_if #(
parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 32,
   parameter MEM_DEPTH  = 16,
    parameter [2:0] DEFAULT_PROT = 3'b000
)
   (input clk ,input rst);

 
    logic [ADDR_WIDTH-1:0]      AWADDR;
    logic [2:0]                 AWPROT;
    logic                       AWVALID;
   logic                        AWREADY;

    logic [DATA_WIDTH-1:0]      WDATA;
    logic [(DATA_WIDTH/8)-1:0]  WSTRB;
    logic                       WVALID;
    logic                       WREADY;

    logic  [1:0]               BRESP;
    logic                      BVALID;
    logic                      BREADY;

    logic [ADDR_WIDTH-1:0]      ARADDR;
    logic [2:0]                 ARPROT;
    logic                       ARVALID;
    logic                       ARREADY;

    logic [DATA_WIDTH-1:0]      RDATA;
    logic  [1:0]                RRESP;
    logic                       RVALID;
    logic                       RREADY;

/*
clocking drv_if  @ (posedge clk );
  default input #1 output #1;

  input rst;
  output AWADDR , AWPROT ,AWVALID , WDATA,WSTRB,WVALID,BREADY,ARADDR,ARPROT,ARVALID ,RREADY;
  input AWREADY , WREADY , ARREADY ;
 
endclocking 
*/
clocking drv_if @(posedge clk);
  default input #1 output #1;

  input rst;

  // Master drives these
  output AWADDR, AWPROT, AWVALID;
  output WDATA, WSTRB, WVALID;
  output BREADY;
  output ARADDR, ARPROT, ARVALID;
  output RREADY;

  // Slave drives these (driver reads them)
  input AWREADY;
  input WREADY;
  input BRESP;
  input BVALID;
  input ARREADY;
  input RDATA;
  input RRESP;
  input RVALID;

endclocking

clocking in_mon_if @ (posedge clk);
  default input #1 output #1;
  
  input AWADDR , AWPROT ,AWVALID , WDATA,WSTRB,WVALID,BREADY,ARADDR,ARPROT,ARVALID ,RREADY , AWREADY , WREADY ,BRESP ,BVALID ,ARREADY ,RDATA ,RRESP ,RVALID;
  
endclocking

clocking out_mon_if @ (posedge clk);
  default input #1 output #1;

  input AWREADY , WREADY ,BRESP ,BVALID ,ARREADY ,RDATA ,RRESP ,RVALID;
endclocking 


modport drv (clocking drv_if);
modport in_mon (clocking in_mon_if );
modport out_mon (clocking out_mon_if );

endinterface






   
