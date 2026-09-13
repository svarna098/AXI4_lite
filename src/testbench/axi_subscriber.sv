class axi_subscriber extends uvm_subscriber # (trans);
 `uvm_component_utils (axi_subscriber)

  trans sub;
 

  covergroup cg ;
    a:coverpoint sub.AWADDR ;
    b:coverpoint sub.AWPROT ;
    c:coverpoint sub.AWVALID;
    d:coverpoint sub.WDATA;
    e:coverpoint sub.WSTRB ;
    f:coverpoint sub.WVALID;
    g :coverpoint sub.BREADY;
    h:coverpoint sub.ARADDR;
   
    j:coverpoint sub.ARVALID;
    k:coverpoint sub.RREADY;
   cross a,h;
  
  endgroup
 
 function new(string name="axi_subscriber",uvm_component parent);
super.new(name,parent);
 cg=new();
`uvm_info(get_name,"[subscriber]:INPUT RECIEVED",UVM_NONE)
endfunction
 
function void report_phase(uvm_phase phase);
super.report_phase(phase);
    `uvm_info(get_name,$sformatf(" COVERAGE = %0f",cg.get_coverage()),UVM_NONE);
endfunction
 
function void write(trans t);
sub=t;
cg.sample();
endfunction
endclass


