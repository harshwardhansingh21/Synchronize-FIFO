`timescale 1ns/1ps

module tb_FIFO_sync;

  reg clk;
  reg reset;
  reg wr_en;
  reg rd_en;
  reg [7:0] din;
  wire [7:0] dout;
  wire full;
  wire empty;

  // DUT instantiation
  FIFO_sync dut (
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );


  always #5 clk = ~clk;

  //write
  task write_fifo(input [7:0] data);
    begin
      @(posedge clk);
      wr_en = 1'b1;
      rd_en = 1'b0;
      din   = data;
      @(posedge clk);
      wr_en = 1'b0;
    end
  endtask

  // Read 
  task read_fifo;
    begin
      @(posedge clk);
      wr_en = 1'b0;
      rd_en = 1'b1;
      @(posedge clk);
      rd_en = 1'b0;
    end
  endtask

  integer i;

  initial begin
    
    clk   = 0;
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    din   = 0;

    
    #20;
    reset = 0;

    $display("---- FIFO TEST START ----");

  //write all values
    for (i = 0; i < 16; i = i + 1) begin
      write_fifo(i);
      $display("WRITE: %0d | full=%b empty=%b", i, full, empty);
    end

    if (full)
      $display("FIFO FULL flag working correctly");
    else
      $display("FIFO FULL flag ERROR");

    
    write_fifo(8'hAA);
    $display("Attempted write when FULL | full=%b", full);

    //read all values
    for (i = 0; i < 16; i = i + 1) begin
      read_fifo();
      $display("READ: %0d | full=%b empty=%b", dout, full, empty);
    end

    if (empty)
      $display("FIFO EMPTY flag working correctly");
    else
      $display("FIFO EMPTY flag ERROR");

    // Try read when empty
    read_fifo();
    $display("Attempted read when EMPTY | empty=%b", empty);

    $display("---- FIFO TEST END ----");

    #20;
    $stop;
  end

endmodule
