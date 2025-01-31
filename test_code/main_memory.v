`timescale 1ns / 1ps


module main_memory#( 
// Parameters
parameter AWIDTH		= 9,	//Address Bus width
parameter DWIDTH		= 8	    //Data Bus Width
)(
input clk,
input reset_n,
input rd_mem,
input wr_mem,
input [DWIDTH-1:0] data_in,
input [AWIDTH-1:0] addr_mem,
output reg ready_mem,
output reg [DWIDTH-1:0] data_out
    );
    
   reg [31:0] ram_block [0:511];
   reg [8:0] address;
  // Memory initialization
initial
begin
	$readmemb("/home/debleena/Thales/Ditty_systems/RTL_code/test_code/memory.txt",ram_block );
end
  
   always @(posedge clk) begin
   if (!reset_n)
   begin
   data_out<='b0;
   ready_mem <= 1'b1;
   end
   else if (wr_mem)
   begin
       ram_block[addr_mem] <= data_in;
       ready_mem <= 1'b0;
   end     
   
   else if (rd_mem)
   begin
       ready_mem <= 1'b0;
       address <= {addr_mem[8:2],2'd01};
       data_out <= ram_block[address];
       //data_out <= ram_block[{addr_mem[8:2],2'd01}];
       //data_out <= ram_block[{addr_mem[8:2],2'd10}];
       //data_out <= ram_block[{addr_mem[8:2],2'd11}];
       
   end 
   
   else    
       ready_mem <= 1'b1;
   end    
endmodule