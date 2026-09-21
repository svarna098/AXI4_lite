class axi_test extends uvm_test ;
  `uvm_component_utils (axi_test)

  axi_environment env;
  axi_config m_cfg;
  
  function new (string name =" axi_test" , uvm_component parent );
     super.new (name ,parent );
  endfunction

 function void build_phase (uvm_phase phase );
    super.build_phase (phase);
   
    m_cfg=axi_config::type_id::create("m_cfg");
  
    if(!uvm_config_db#(virtual axi_if)::get(this,"","axi_if",m_cfg.vif))
	`uvm_fatal(get_type_name(),"Can't get the interface")
         m_cfg.input_agent_is_active=UVM_ACTIVE;
         m_cfg.output_agent_is_active=UVM_PASSIVE;

    uvm_config_db#(axi_config)::set(this,"*","axi_config",m_cfg);

    env=axi_environment::type_id::create("env",this);

 endfunction

 function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
 endfunction

endclass

class test1_reset extends axi_test;

  `uvm_component_utils(test1_reset)

  axi_reset_sequence  reset_seq;
 /* axi_write_read_sequence s2;
  axi_write_sequence s3;
  axi_aw_sequence  s4;
  axi_w_sequence  s5;
  axi_read_sequence  s6;
  axi_valid_write_sequence s7;
  axi_invalid_sequence s8;
  axi_invalid_read_sequence s9;
  axi_ro_write_sequence1 s10;
  axi_wo_read_sequence s11;
  axi_coverage_sequence s12;
  axi_addr_not_word_align s13;
  axi_write_read_sequence1 s14;*/
  function new(string name="test1_reset", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    reset_seq = axi_reset_sequence::type_id::create("reset_seq");
  /*  s2 = axi_write_read_sequence::type_id::create("s2");
    s3 = axi_write_sequence::type_id::create("s3");
    s4 = axi_aw_sequence::type_id::create("s4");
    s5 = axi_w_sequence::type_id::create("s5");
    s6 = axi_read_sequence::type_id::create("s6");
    s7 = axi_valid_write_sequence::type_id::create("s7");
    s8 = axi_invalid_sequence::type_id::create("s8");
    s9 = axi_invalid_read_sequence::type_id::create("s9");
    s10 = axi_ro_write_sequence1::type_id::create("s10");
    s11 = axi_wo_read_sequence::type_id::create("s11");
    s12 = axi_coverage_sequence::type_id::create("s12");
    s13 = axi_addr_not_word_align::type_id::create("s13");
    s14 = axi_write_read_sequence1::type_id::create("s14");*/
begin
    reset_seq.start(env.in_agnt.seq);
  // s2.start(env.in_agnt.seq);
    //s3.start(env.in_agnt.seq);
   // s4.start(env.in_agnt.seq);
  //  s5.start(env.in_agnt.seq);
  //  s6.start(env.in_agnt.seq);
  //  s7.start(env.in_agnt.seq);
    //s8.start(env.in_agnt.seq);
   // s9.start(env.in_agnt.seq);
  //  s10.start(env.in_agnt.seq);
  //  s11.start(env.in_agnt.seq);
  //  s12.start(env.in_agnt.seq);
   // s13.start(env.in_agnt.seq);
    //  s14.start(env.in_agnt.seq);
     // s6.start(env.in_agnt.seq);

    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_write_read extends axi_test;

  `uvm_component_utils(test_write_read)


  axi_write_read_sequence s2;

  function new(string name="test_write_read", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

  
    s2 = axi_write_read_sequence::type_id::create("s2");
  
begin
   
   s2.start(env.in_agnt.seq);
    
    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_write_aw_w extends axi_test;

  `uvm_component_utils(test_write_aw_w)

 
  axi_write_sequence s3;

  function new(string name="test_write_aw_w", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

   
    s3 = axi_write_sequence::type_id::create("s3");
  
begin
   
    s3.start(env.in_agnt.seq);
   
    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_aw extends axi_test;

  `uvm_component_utils(test_aw)

  axi_aw_sequence  s4;

  function new(string name="test_aw", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s4 = axi_aw_sequence::type_id::create("s4");
   
begin
   
    s4.start(env.in_agnt.seq);

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_w extends axi_test;

  `uvm_component_utils(test_w)

 
  axi_w_sequence  s5;
  
  function new(string name="test_w", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s5 = axi_w_sequence::type_id::create("s5");
   
    s5.start(env.in_agnt.seq);
  
    #100;

    phase.drop_objection(this);

  endtask
endclass

class test_read extends axi_test;

  `uvm_component_utils(test_read)

  axi_read_sequence  s6;
  
  function new(string name="test_read", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);
 
    s6 = axi_read_sequence::type_id::create("s6");
    
    s6.start(env.in_agnt.seq);
 
    #100;

    phase.drop_objection(this);

  endtask
endclass

class test_write_valid extends axi_test;

  `uvm_component_utils(test_write_valid)

 
  axi_valid_write_sequence s7;
  
  function new(string name="test_write_valid", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

   
    s7 = axi_valid_write_sequence::type_id::create("s7");
   
begin
  
    s7.start(env.in_agnt.seq);
  

    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_invalid_w extends axi_test;

  `uvm_component_utils(test_invalid_w)

 
  axi_invalid_sequence s8;
 
  function new(string name="test_invalid_w", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

   
    s8 = axi_invalid_sequence::type_id::create("s8");
  
begin
   
    s8.start(env.in_agnt.seq);
  
    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_invalid_r extends axi_test;

  `uvm_component_utils(test_invalid_r)

  axi_invalid_read_sequence s9;
  
  function new(string name="test_invalid_r", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s9 = axi_invalid_read_sequence::type_id::create("s9");
    
begin
  
    s9.start(env.in_agnt.seq);

    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_ro_write extends axi_test;

  `uvm_component_utils(test_ro_write)

 
  axi_ro_write_sequence1 s10;
  
  function new(string name="test_ro_write", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);
   
    s10 = axi_ro_write_sequence1::type_id::create("s10");

begin
   
    s10.start(env.in_agnt.seq);
  

    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_wo_read extends axi_test;

  `uvm_component_utils(test_wo_read)

 
  axi_wo_read_sequence s11;
 
  function new(string name="test_wo_read", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

   
    s11 = axi_wo_read_sequence::type_id::create("s11");
    
begin
  
    s11.start(env.in_agnt.seq);
 
    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_coverage extends axi_test;

  `uvm_component_utils(test_coverage)


  axi_coverage_sequence s12;
 
  function new(string name="test_coverage", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

  
    s12 = axi_coverage_sequence::type_id::create("s12");
   
begin
   
    s12.start(env.in_agnt.seq);
   
    #100;
end
    phase.drop_objection(this);

  endtask
endclass

class test_addr_not_word_align extends axi_test;

  `uvm_component_utils(test_addr_not_word_align)


  axi_addr_not_word_align s13;
  
  function new(string name="test_addr_not_word_align", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

   
    s13 = axi_addr_not_word_align::type_id::create("s13");

begin
   
    s13.start(env.in_agnt.seq);
    
    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_write_read_1 extends axi_test;

  `uvm_component_utils(test_write_read_1)

 
  axi_write_read_sequence1 s14;
  function new(string name="test_write_read_1", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s14 = axi_write_read_sequence1::type_id::create("s14");
begin
   
    s14.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_aw_w_r extends axi_test;

  `uvm_component_utils(test_aw_w_r)

 
  axi_aw_w_sequence1 s15;
  axi_aw_w_r_sequence1 s16;
  function new(string name="test_aw_w_r", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s15 = axi_aw_w_sequence1::type_id::create("s15");
     s16 = axi_aw_w_r_sequence1::type_id::create("s16");
begin
   
    s15.start(env.in_agnt.seq);
    #40;
     s16.start(env.in_agnt.seq);

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_aw_w_r_1 extends axi_test;

  `uvm_component_utils(test_aw_w_r_1)

 
  axi_aw_w_r_sequence1 s16;
  function new(string name="test_aw_w_r_1", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s16 = axi_aw_w_r_sequence1::type_id::create("s16");
begin
   
    s16.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_strobe extends axi_test;

  `uvm_component_utils(test_strobe)

 
  axi_strobe s17;
  function new(string name="test_strobe", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s17 = axi_strobe::type_id::create("s17");
begin
   
    s17.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_mul_w_r extends axi_test;

  `uvm_component_utils(test_mul_w_r)

 
  axi_mul_w_r s18;
  function new(string name="test_mul_w_r", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s18 = axi_mul_w_r::type_id::create("s18");
begin
   
    s18.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass







class test_aw_w_r_11 extends axi_test;

  `uvm_component_utils(test_aw_w_r_11)

 
  axi_aw_w_sequence_11 s19;
  axi_aw_w_r_sequence_12 s20;
  axi_aw_w_r_sequence_13 s21;
axi_aw_w_r_sequence_14 s22;
  function new(string name="test_aw_w_r_11", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s19 = axi_aw_w_sequence_11::type_id::create("s19");
    s20 = axi_aw_w_r_sequence_12::type_id::create("s20");
    s21 = axi_aw_w_r_sequence_13::type_id::create("s21");
     s22 = axi_aw_w_r_sequence_14::type_id::create("s22");
begin
   
    s19.start(env.in_agnt.seq);
    s20.start(env.in_agnt.seq);
   //  s21.start(env.in_agnt.seq);
    s22.start(env.in_agnt.seq);

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_aw_w_r_22 extends axi_test;

  `uvm_component_utils(test_aw_w_r_22)

 
  axi_aw_w_r_sequence_12 s20;
  function new(string name="test_aw_w_r_22", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s20 = axi_aw_w_r_sequence_12::type_id::create("s20");
begin
   
    s20.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_aw_w_r_33 extends axi_test;

  `uvm_component_utils(test_aw_w_r_33)

 
  axi_aw_w_r_sequence_13 s21;
  function new(string name="test_aw_w_r_33", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s21 = axi_aw_w_r_sequence_13::type_id::create("s21");
begin
   
    s21.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_aw_w_r_14 extends axi_test;

  `uvm_component_utils(test_aw_w_r_14)

 
  axi_aw_w_r_sequence_14 s22;
  function new(string name="test_aw_w_r_14", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s22 = axi_aw_w_r_sequence_14::type_id::create("s22");
begin
   
    s22.start(env.in_agnt.seq);
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


class test_aw_aw_w extends axi_test;

  `uvm_component_utils(test_aw_aw_w)

 
  axi_aw_aw_w s23;
  axi_aw_aw_w_1 s25;
  function new(string name="test_aw_aw_w", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s23 = axi_aw_aw_w::type_id::create("s23");
    s25 = axi_aw_aw_w_1::type_id::create("s25");
begin
   
    s23.start(env.in_agnt.seq);
 #30;
    s25.start(env.in_agnt.seq);

    #100;
end
    phase.drop_objection(this);

  endtask
endclass



class test_unaligned_write extends axi_test;

  `uvm_component_utils(test_unaligned_write)

 
   axi_unaligned_write s24;
  function new(string name="test_unaligned_write", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s24 = axi_unaligned_write::type_id::create("s24");
begin
   
    s24.start(env.in_agnt.seq);
    

    #300;
end
    phase.drop_objection(this);

  endtask
endclass



class test_unaligned_write_1 extends axi_test;

  `uvm_component_utils(test_unaligned_write_1)

 
   axi_unaligned_write1 s26;
   axi_aw_w_r_sequence_12 s27;
  function new(string name="test_unaligned_write_1", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    s26 = axi_unaligned_write1::type_id::create("s26");
    s27 = axi_aw_w_r_sequence_12::type_id::create("s27");
begin
     s27.start(env.in_agnt.seq);
    // #40;
    s26.start(env.in_agnt.seq);
    
    

    #100;
end
    phase.drop_objection(this);

  endtask
endclass


