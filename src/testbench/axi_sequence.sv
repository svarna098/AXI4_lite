class axi_reset_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_reset_sequence)

  function new(string name="axi_reset_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 0; WVALID == 0; ARVALID == 0; BREADY == 0; RREADY == 0;});
    finish_item(req);
  endtask
  endclass


class axi_write_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_write_read_sequence)

  function new(string name="axi_write_read_sequence");
    super.new(name);
  endfunction

  task body();
   repeat(10) begin
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 1;RREADY==1; BREADY == 1; AWADDR == 32'h08; WDATA == 32'd20; WSTRB == 4'b1111;ARADDR == 32'h08;});
    finish_item(req);
end
  endtask
  endclass

class axi_write_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_write_sequence)

  function new(string name="axi_write_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; AWADDR == 32'h04; WDATA == 32'd10; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
  endclass

class axi_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_read_sequence)

  function new(string name="axi_read_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 0; WVALID == 0; ARVALID == 1; RREADY == 1; ARADDR == 32'h04;  WSTRB == 4'b1111;});
    finish_item(req);
  endtask
 endclass


class axi_write_read_sequence1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_write_read_sequence1)

  function new(string name="axi_write_read_sequence1");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 1; BREADY == 1;RREADY==1; AWADDR == 32'h24; WDATA == 32'd30; WSTRB == 4'b1111;ARADDR==32'h04;});
    finish_item(req);
  endtask
  endclass

class axi_aw_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_sequence)

  function new(string name="axi_aw_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 0; ARVALID == 1; BREADY == 0; AWADDR == 32'h04;WDATA==32'd70; ARADDR ==32'h04;RREADY==1;});
    finish_item(req);
  endtask
 endclass


class axi_w_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_w_sequence)

  function new(string name="axi_w_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 0; WVALID == 1; ARVALID == 0; BREADY == 1; WDATA == 32'd15; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
endclass

class axi_valid_write_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_valid_write_sequence)

  function new(string name="axi_valid_write_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; AWADDR == 32'd00; WDATA == 32'd30; WSTRB == 4'b1111;});
    finish_item(req);
  endtask
 endclass


class axi_invalid_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_invalid_sequence)

  function new(string name="axi_invalid_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
   /* start_item(req);
    assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; AWADDR == 32'd68; WDATA == 32'd17; WSTRB == 4'b1111;});
    finish_item(req);
*/
    start_item(req);
    assert(req.randomize() with {ARVALID == 1; AWVALID == 0; WVALID == 0; RREADY == 1; BREADY == 0; ARADDR == 32'd68;});
    finish_item(req);
  endtask
  endclass

class axi_invalid_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_invalid_read_sequence)

  function new(string name="axi_invalid_read_sequence");
    super.new(name);
  endfunction

  task body();
    req=trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {ARVALID == 1; AWVALID == 0; WVALID == 0; RREADY == 1; BREADY == 0; ARADDR == 32'd64;});
    finish_item(req);
  endtask
  endclass

class axi_ro_write_sequence1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_ro_write_sequence1)

  function new(string name="axi_ro_write_sequence1");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1;WVALID  == 1;ARVALID == 0; BREADY  == 1;RREADY  == 0;AWADDR  == 32'h28;WDATA   == 32'd11;WSTRB   == 4'b1111;});
    finish_item(req);
  endtask
 endclass

class axi_wo_read_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_wo_read_sequence)

  function new(string name="axi_wo_read_sequence");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'h34;});
    finish_item(req);
  endtask
 endclass

class axi_addr_not_word_align extends uvm_sequence #(trans);
  `uvm_object_utils(axi_addr_not_word_align)

  function new(string name="axi_addr_not_word_align");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {AWVALID == 1;WVALID  == 1;ARVALID == 0; BREADY  == 1;RREADY  == 0;AWADDR  == 32'h22;WDATA   == 32'd11;WSTRB   == 4'b1111;});
    finish_item(req);
  endtask
 endclass

class axi_coverage_sequence extends uvm_sequence #(trans);
  `uvm_object_utils(axi_coverage_sequence)

  function new(string name="axi_coverage_sequence");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
    for (int i=0;i<15;i++) begin
      start_item(req);
       assert(req.randomize() with {AWVALID == 1; WVALID == 1; ARVALID == 0; BREADY == 1; RREADY == 0;  WDATA == 32'd11; WSTRB == i; });
      finish_item(req);
    end
   
   
    for (int i=0;i<100;i++) begin
      start_item(req);
       assert(req.randomize() with {AWVALID == 1; WVALID == 0; BREADY == 0; RREADY == 1; AWADDR==i; });
      finish_item(req);
      start_item(req);
       assert(req.randomize() with {AWVALID == 0; WVALID == 1; ARVALID == 1; BREADY == 0; RREADY == 1; WDATA==i; });
      finish_item(req);
      
    end

    for (int i=0;i<100;i++) begin
      start_item(req);
       assert(req.randomize() with {ARVALID == 1; WVALID == 0; BREADY == 0; RREADY == 1; ARADDR==i; });
      finish_item(req);
    end

  endtask
endclass


class axi_aw_w_sequence1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_w_sequence1)

  function new(string name="axi_aw_w_sequence1");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd12;WSTRB==4'b1111;});
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 0;WVALID  == 1;RREADY  == 0;BREADY  == 1; WDATA  == 32'd30; AWADDR ==32'd12 ;WSTRB==4'b1111;});
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'd12;WSTRB==4'b1111;});
    finish_item(req);
  endtask
 endclass

class axi_aw_w_r_sequence1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_w_r_sequence1)

  function new(string name="axi_aw_w_r_sequence1");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
repeat(20)begin
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd12;WSTRB==4'b1111;});
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 0;WVALID  == 1;RREADY  == 0;BREADY  == 1; WDATA  == 32'd40;AWADDR ==32'd12;WSTRB==4'b1111; });
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'd12;WSTRB==4'b1111;});
    finish_item(req);
end
  endtask
 endclass

class axi_strobe extends uvm_sequence #(trans);
  `uvm_object_utils(axi_strobe)

  function new(string name="axi_strobe");
    super.new(name);
  endfunction

  task body();
     req = trans::type_id::create("req");

     start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd12;WSTRB==4'b0010;});
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 0;WVALID  == 1;RREADY  == 0;BREADY  == 1; WDATA  == 32'h001250;WSTRB==4'b0010;AWADDR==32'd0; });
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'd12;WSTRB==4'b0010;});
    finish_item(req);

  endtask
 endclass



class axi_aw_w_sequence_11 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_w_sequence_11)

  function new(string name="axi_aw_w_sequence_11");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");
  
  start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd0;WSTRB==4'b1111;});
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 0;WVALID  == 1;RREADY  == 0;BREADY  == 1; WDATA  == 32'd10;AWADDR  == 32'd0;WSTRB==4'b1111;});
    finish_item(req);

  endtask
 endclass

class axi_aw_w_r_sequence_12 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_w_r_sequence_12)

  function new(string name="axi_aw_w_r_sequence_12");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd12;WSTRB==4'b1111;});
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 0;WVALID  == 1;RREADY  == 0;BREADY  == 1; WDATA  == 32'd20;AWADDR  == 32'd12;WSTRB==4'b1111; });
    finish_item(req);
 
     start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'd12;WSTRB==4'b1111;});
   finish_item(req);   

  endtask
 endclass

class axi_aw_w_r_sequence_13 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_w_r_sequence_13)

  function new(string name="axi_aw_w_r_sequence_13");
    super.new(name);
  endfunction

  task body();
   req = trans::type_id::create("req");
  
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'd0;WSTRB==4'b1111;});
    finish_item(req);

  endtask
 endclass

class axi_aw_w_r_sequence_14 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_w_r_sequence_14)

  function new(string name="axi_aw_w_r_sequence_14");
    super.new(name);
  endfunction

  task body();

    req = trans::type_id::create("req");
 
    start_item(req);
    assert(req.randomize() with { ARVALID == 1;AWVALID == 0;WVALID  == 0;RREADY  == 1;BREADY  == 0; ARADDR  == 32'd12;WSTRB==4'b1111;});
   finish_item(req);

  endtask
 endclass

class axi_mul_w_r extends uvm_sequence #(trans);
  `uvm_object_utils(axi_mul_w_r)

  function new(string name="axi_mul_w_r");
    super.new(name);
  endfunction

  task body();
    req = trans::type_id::create("req");

   repeat(10) begin
    start_item(req);
    assert(req.randomize() with { ARVALID == 0; AWVALID == 1; WVALID == 0; RREADY == 0; BREADY == 1; AWADDR == 32'd0;  WSTRB == 4'b1111; });
    finish_item(req);
    start_item(req);
    assert(req.randomize() with { ARVALID == 0; AWVALID == 0; WVALID == 1; RREADY == 0; BREADY == 1; WDATA  == 32'd10; WSTRB == 4'b1111; AWADDR == 32'd0; });
    finish_item(req);

    start_item(req);
    assert(req.randomize() with { ARVALID == 0; AWVALID == 0; WVALID == 1; RREADY == 0; BREADY == 1; WDATA  == 32'd20; WSTRB == 4'b1111; AWADDR == 32'd12; });
    finish_item(req);
    
   
    start_item(req);
    assert(req.randomize() with { ARVALID == 1; AWVALID == 0; WVALID == 0; RREADY == 1; BREADY == 0; ARADDR == 32'd12; });
    finish_item(req);

    
    start_item(req);
    assert(req.randomize() with { ARVALID == 1; AWVALID == 0; WVALID == 0; RREADY == 1; BREADY == 0; ARADDR == 32'd0; });
    finish_item(req);
end
  endtask
endclass


class axi_aw_aw_w extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_aw_w)

  function new(string name="axi_aw_aw_w");
    super.new(name);
  endfunction

  task body();
   req = trans::type_id::create("req");
  
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd12;WSTRB==4'b1111;});
    finish_item(req);

  endtask
 endclass


class axi_aw_aw_w_1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_aw_aw_w_1)

  function new(string name="axi_aw_aw_w_1");
    super.new(name);
  endfunction

  task body();
   repeat(10) begin
   req = trans::type_id::create("req");
 
   
    start_item(req);
     assert(req.randomize() with { ARVALID == 0;AWVALID == 1;WVALID  == 0;RREADY  == 0;BREADY  == 1; AWADDR  == 32'd04;WSTRB==4'b1111;});
    finish_item(req);
   
    start_item(req);
    assert(req.randomize() with { ARVALID == 0;AWVALID == 0;WVALID  == 1;RREADY  == 0;BREADY  == 1; WDATA  == 32'd20;AWADDR ==32'd08;WSTRB==4'b1111; });
    finish_item(req);
    
     start_item(req);
    assert(req.randomize() with { ARVALID == 1; AWVALID == 0; WVALID == 0; RREADY == 1; BREADY == 0; ARADDR == 32'd08; });
    finish_item(req);
   end
  endtask
 endclass

class axi_unaligned_write extends uvm_sequence #(trans);
  `uvm_object_utils(axi_unaligned_write)

  function new(string name="axi_unaligned_write");
    super.new(name);
  endfunction

  task body();
    repeat(30) begin
    req = trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {ARVALID==0; AWVALID==1; WVALID==0; RREADY==0; BREADY==1; AWADDR==32'h06; WDATA==32'd60; WSTRB==4'b1111;});
    finish_item(req);
    start_item(req);
    assert(req.randomize() with {ARVALID==0; AWVALID==0; WVALID==1; RREADY==0; BREADY==1; AWADDR==32'h06; WDATA==32'h60; WSTRB==4'b1111;});
    finish_item(req);
    start_item(req);
    assert(req.randomize() with {ARVALID==1; AWVALID==0; WVALID==0; RREADY==1; BREADY==0; ARADDR==32'h04;});
    finish_item(req);
end
  endtask
endclass


class axi_unaligned_write1 extends uvm_sequence #(trans);
  `uvm_object_utils(axi_unaligned_write1)

  function new(string name="axi_unaligned_write1");
    super.new(name);
  endfunction

  task body();
   repeat(10) begin
    req = trans::type_id::create("req");

    start_item(req);
    assert(req.randomize() with {ARVALID==0; AWVALID==1; WVALID==0; RREADY==0; BREADY==1; AWADDR==32'd15; WDATA==32'd60; WSTRB==4'b1111;});
    finish_item(req);
    start_item(req);
    assert(req.randomize() with {ARVALID==0; AWVALID==0; WVALID==1; RREADY==0; BREADY==1; AWADDR==32'd15; WDATA==32'd60; WSTRB==4'b1111;});
    finish_item(req);
    start_item(req);
    assert(req.randomize() with {ARVALID==1; AWVALID==0; WVALID==0; RREADY==1; BREADY==0; ARADDR==32'd12;});
    finish_item(req);
end
  endtask
endclass
