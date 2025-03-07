module ahb_slave(
    input logic hclk,
    input logic hresetn,

    input logic [11:2] haddr, // system address bus
    input logic hready,
    input logic hsel,
    input logic [2:0] hsize,
    input logic htrans,
    input logic [31:0] hwdata,
    input logic hwrite,

    output logic [31:0] hrdata,
    output logic hready_o;
    output logic [1:0] hresp,

);