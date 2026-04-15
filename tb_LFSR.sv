`timescale 1ns/1p

module tb_LFSR;

  logic clock;
  logic resetn;
  logic [3:0] in;
  logic [3:0] out;

  logic [3:0] ref_out;

  LFSR dut (
    .clock(clock),
    .resetn(resetn),
    .in(in),
    .out(out)
  );

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  always_ff @(posedge clock) begin
    if (resetn) begin
      ref_out <= in;  
    end else begin
      ref_out <= {ref_out[2:0], ref_out[3] ^ ref_out[2]};
    end
  end

  always_ff @(posedge clock) begin
    if (out !== ref_out) begin
      $error("Mismatch at time %0t: DUT out=%b, Expected=%b", $time, out, ref_out);
    end else begin
      $display("Match at time %0t: out=%b", $time, out);
    end
  end

  initial begin
    $display("Starting LFSR Testbench...");

    resetn = 1; in = 4'b1010; #10;   
    resetn = 0; #100;                

    resetn = 1; in = 4'b1100; #10;   
    resetn = 0; #100;                

    $display("Testbench completed.");
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule

