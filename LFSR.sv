module LFSR(
  input logic clock,
  input logic resetn,
  input logic [3:0]in,
  output logic [3:0]out);
  
  always_ff @(posedge clock)
    begin
      if(resetn)
        out <= in;
      else
        out <= {out[2:0],(out[3]^out[2])};
    end
endmodule
