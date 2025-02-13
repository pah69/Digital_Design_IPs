// `include "package.sv"
class base_test extends uvm_test;

  `uvm_component_utils(base_test)
  my_env env_o;
  base_seq bseq;
  virtual alu_if alu_vif;
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = my_env::type_id::create("env_o", this);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vif", alu_vif))
      `uvm_fatal("TEST", "Did not get vif")
    //       uvm_config_db#(virtual alu_if)::set(this, "*", "alu_vif", alu_vif);
    //bseq = base_seq::type_id::create("bseq");
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq = base_seq::type_id::create("bseq");

    repeat (20) begin
      #5;
      bseq.start(env_o.agt.seqr);
    end

    phase.drop_objection(this);
    `uvm_info(get_type_name, "End of testcase", UVM_LOW);
  endtask
endclass
