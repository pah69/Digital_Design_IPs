class driver extends uvm_driver #(seq_item);
  //virtual add_if vif;
  `uvm_component_utils(driver)
  virtual alu_if alu_vif;
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_vif", alu_vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      // Driver to the DUT
      @(negedge alu_vif.clk);
      seq_item_port.get_next_item(req);
      //`uvm_info(get_type_name, $sformatf("ip1 = %0d, ip2 = %0d", req.ip1, req.ip2), UVM_LOW);
      alu_vif.opA <= req.opA;
      alu_vif.opB <= req.opB;
      alu_vif.opcode <= req.opcode;
      //@(posedge vif.clk);
      //req.out <= vif.out;
      seq_item_port.item_done();
    end
  endtask
endclass
