module FIR_TB;

parameter N = 16;

reg clk, reset;
reg [N-1:0] data_in;
wire [N-1:0] data_out;

// Address counter
reg [4:0] Address;

// Create the RAM
reg [N-1:0] RAMM [1499:0];

FIR_Filter inst0(clk, reset, data_in, data_out);

// input sine wave data
initial
  $readmemb("signal.data", RAMM);

// create a clock
initial
  clk = 0;
always
  #10 clk = ~clk;

// Read RAMM data and give to design
always@(posedge clk)
  data_in <= RAMM[Address];

// Initialize Address
initial
  Address = 1;
always@(posedge clk)
begin
  if (Address == 31)
    Address <= 0;
  else
    Address <= Address + 1;
end

endmodule
