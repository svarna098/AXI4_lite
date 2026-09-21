class trans extends uvm_sequence_item ;
	`uvm_object_utils(trans)
        bit rst;
	rand bit AWVALID;
 	rand bit WVALID;
 	rand bit ARVALID;
 	rand bit [31:0] AWADDR;
 	rand bit [31:0] WDATA;
 	rand bit [31:0] ARADDR;
 	rand bit BREADY;
        rand bit RREADY;
       rand bit [2:0] AWPROT;
       rand bit [2:0] ARPROT;
       rand bit [3:0] WSTRB;
        logic  AWREADY;
        logic  WREADY;
        logic  [1:0]BRESP;
        logic  BVALID;
        logic  ARREADY;
        logic  [31:0] RDATA;
        logic  [1:0]RRESP;
        logic  RVALID;
 
 // constraint c { AWADDR inside {32'h04,32'd00,32'h40,32'h28,32'h34,32'd10,32'h08,32'h22,32'h24,32'd61};}
  //constraint c1 { WDATA inside {[0:50]};}
 // constraint c2 {ARADDR inside {32'h04,32'd00,32'h40,32'h28,32'h34,32'd10,32'h08,32'h22,32'h24,32'd61};}
        
  
 function new(string name="trans");
	super.new(name);
 endfunction

 endclass
 
