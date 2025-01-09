`timescale 1ns / 1ps

module VGA_controller(
input clk, reset_n,
output video_on,
output [9:0] pixel_x, pixel_y,
output hsync, vsync
);

wire done_y, done_x;

//localparam 
			  //horizontal parameters / 2.5 to fit the Cyclone IV memory
			  //horizontal_display = 640,
			  //horizontal_back_porch = 16,
			  //horizontal_retrace = 96,
			  //horizontal_front_porch = 48,
			  
			  //vertical parameters
			  
			  //vertical_display = 480,
			  //vertical_back_porch = 33,
			  //vertical_retrace = 2,
			  //vertical_front_porch = 10;
			  
horizontal_counter U1(
  .clk(clk),
  .reset_n(reset_n),
  .done_x(done_x),
  .pixel_x(pixel_x)
);

vertical_counter U2(
  .clk(clk),
  .reset_n(reset_n),
  .enable(done_x),
  .done_y(done_y),
  .pixel_y(pixel_y)    
);

assign hsync = (pixel_x >= 556) && (pixel_x <= 624) ? 1'b1 : 1'b0;

assign vsync = (pixel_y >= 413) && (pixel_y <=  414) ? 1'b1 : 1'b0;

assign video_on = (pixel_x < 640) && (pixel_y < 480) ? 1'b1 : 1'b0;


endmodule