//  Class: seq_item

class seq_item extends uvm_sequence_item;
  typedef seq_item this_type_t;
  `uvm_object_utils(seq_item)

  //  Group: Variables
  // Random Input 
  rand logic [7:0] opA;
  rand logic [7:0] opB;
  rand bit [2:0] opcode;
  logic [7:0] out;


  //  Group: Constraints
  // constraint  {
  //     /*  solve order constraints  */

  //     /*  rand variable constraints  */

  // }


  //  Group: Functions

  //  Constructor: new
  function new(string name = "seq_item");
    super.new(name);
  endfunction : new

  //  Function: do_copy
  // extern function void do_copy(uvm_object rhs);
  //  Function: do_compare
  // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  //  Function: convert2string
  // extern function string convert2string();
  //  Function: do_print
  // extern function void do_print(uvm_printer printer);
  //  Function: do_record
  // extern function void do_record(uvm_recorder recorder);
  //  Function: do_pack
  // extern function void do_pack();
  //  Function: do_unpack
  // extern function void do_unpack();

  /*----------------------------------------------------------------------------*/
  /*  Constraints                                                               */
  /*----------------------------------------------------------------------------*/




  /*----------------------------------------------------------------------------*/
  /*  Functions                                                                 */
  /*----------------------------------------------------------------------------*/

endclass : seq_item
