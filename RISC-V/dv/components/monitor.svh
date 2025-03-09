class monitor extends uvm_monitor;
  // virtual add_if vif;
  uvm_analysis_port #(seq_item) item_collect_port;
  seq_item mon_item;
  `uvm_component_utils(monitor)

  virtual alu_if alu_vif;
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collect_port = new("item_collect_port", this);
    mon_item = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vif", alu_vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      wait (!alu_vif.reset);
      @(negedge alu_vif.clk);
      mon_item.opA = alu_vif.opA;
      mon_item.opB = alu_vif.opB;
      mon_item.opcode = alu_vif.opcode;
      `uvm_info(get_type_name, $sformatf("opA = %0d, opB = %0d", mon_item.opA, mon_item.opB),
                UVM_HIGH);
      //@(posedge alu_vif.clk);
      mon_item.out = alu_vif.out;
      item_collect_port.write(mon_item);
    end
  endtask
endclass
