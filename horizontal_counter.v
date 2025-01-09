module horizontal_counter(
input clk, reset_n,
output [9:0] pixel_x,
output done_x 
);
reg [9:0] pixel_reg, pixel_next;


always@(posedge clk ,negedge reset_n)
begin
  if(~reset_n)
   pixel_reg <= 10'b0;
  else
   pixel_reg <= pixel_next; 
end

always@(*)
begin
    if (done_x)
       pixel_next = 10'b0; // 카운트가 끝나면 다시 0으로
    else
       pixel_next = pixel_reg + 1; // 계속 증가
end

assign pixel_x = pixel_reg;
assign done_x = (pixel_reg == 10'd799);
endmodule