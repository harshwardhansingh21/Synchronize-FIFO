module FIFO_sync(
input clk,
  input reset,
  input wr_en,
  input rd_en,
  input [7:0]din,
  output reg [7:0]dout,
  output full,
  output  empty
);
  reg [7:0] memory [0:15];
  reg [4:0] write_pointer,read_pointer;
  
  always@(posedge clk) begin
    if(reset)
      begin
        write_pointer<=0;
        dout<=0;
      end
    else if(wr_en && !full)
    begin
      memory[write_pointer[3:0]]<=din;
      write_pointer<=write_pointer+1'b1;
    end
  end
  
   always@(posedge clk) begin
    if(reset)
      begin
        read_pointer<=0;
        dout<=0;
      end
     else if(rd_en && !empty)
    begin
      dout<=memory[read_pointer[3:0]];
      read_pointer<=read_pointer+1'b1;
    end
  end
 
  
    assign empty=(write_pointer==read_pointer);
     assign full = (write_pointer[3:0]==read_pointer[3:0]) && (write_pointer[4]!= read_pointer[4]);
            

  

endmodule //FIFO
