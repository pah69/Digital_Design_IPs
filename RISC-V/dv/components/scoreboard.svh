class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  //     `uvm_analysis_imp_decl(_mon2scb)

  // Analysis Imp
  uvm_analysis_imp #(seq_item, scoreboard) from_mon2scb;

  seq_item item_queue[$];

  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    from_mon2scb = new("item_collect_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(seq_item req);
    item_queue.push_back(req);
  endfunction

  task run_phase(uvm_phase phase);
    seq_item expected_item;
    forever begin
      wait (item_queue.size > 0);
      if (item_queue.size > 0) begin
        expected_item = item_queue.pop_front();
        $display("------------------------------------------");
        // Comparison condition with If/Else
        if (expected_item.opA + expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else if (expected_item.opA - expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else if (expected_item.opA * expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else if (expected_item.opA & expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else if (expected_item.opA | expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else if (expected_item.opA ^ expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end
        else if ( ((expected_item.opA == expected_item.opB) ? 1'b1 : 1'b0 )== expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else if (expected_item.opA << expected_item.opB == expected_item.out) begin
          `uvm_info(get_type_name(), $sformatf(
                    "Matched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                    expected_item.opA,
                    expected_item.opB,
                    expected_item.opcode,
                    expected_item.out
                    ), UVM_LOW);
        end else begin
          `uvm_error(get_type_name(), $sformatf(
                     "MisMatched : opA = %0h, opB = %0h, opcode = %0d, out = %0h",
                     expected_item.opA,
                     expected_item.opB,
                     expected_item.opcode,
                     expected_item.out
                     ))
        end
        $display("------------------------------------------");
      end
    end
  endtask

endclass
