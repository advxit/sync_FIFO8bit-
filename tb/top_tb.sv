module top_tb;

  logic clk, rst;
  logic [7:0] data_in;
  logic [7:0] data_out;

  top dut (
    .clk(clk),
    .rst(rst),
    .data_top(data_in),
    .data_out_top(data_out)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  class transaction;
    rand bit [7:0] data;
    constraint c1 { data > 0; } // Ensure we don't send 0
  endclass

  class generator;
    task make(output transaction t);
      t = new();
      void'(t.randomize()); 
    endtask
  endclass

  class driver;
    task send(transaction t);
      @(posedge top_tb.clk);
      top_tb.data_in = t.data;    
      $display("STEP 1: Driver applied %d", t.data);
      
      repeat(2) @(posedge top_tb.clk); // Give moda time to capture
      top_tb.data_in = 0;             // Clear input so FIFO doesn't overflow
    endtask
  endclass

  class monitor;
    task check(int expected_val);
      // 1. Wait until the output wire is no longer zero
      // This solves the "Got 0" error you see in your Tcl console
      wait(top_tb.data_out != 0); 
      
      // 2. Sample it on the next clock edge
      @(posedge top_tb.clk);

      if (top_tb.data_out == expected_val)
        $display("RESULT: SUCCESS! Sent %d, Received %d", expected_val, top_tb.data_out);
      else
        $display("RESULT: FAILURE! Sent %d, Received %d", expected_val, top_tb.data_out);
      
      // 3. Wait for it to go back to zero/IDLE so we are ready for next loop
      wait(top_tb.dut.mod2.ps == 2'b00);
      repeat(5) @(posedge top_tb.clk); 
    endtask
  endclass

  initial begin
    generator g = new();
    driver    d = new();
    monitor   m = new();
    transaction my_data;

    rst = 1; data_in = 0;
    #50; // Long reset
    rst = 0;
    $display("--- Reset Done ---");

    repeat(5) begin
      g.make(my_data);
      d.send(my_data);
      m.check(my_data.data); // This now waits as long as needed
      $display("---------------------------------");
    end

    $finish;
  end

endmodule