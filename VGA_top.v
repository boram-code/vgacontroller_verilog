`timescale 1ns / 1ps

module VGA_top(
    input clk,           // System clock
    input reset_n,         // Active-low reset
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output wire hsync,         // Horizontal sync signal for VGA
    output wire vsync          // Vertical sync signal for VGA
);

    wire [9:0] pixel_x;
    wire [9:0] pixel_y;
    
    clk_wiz_0 c1 (
        .resetn(reset_n),
        .clk_in1(clk),
        .clk_out1(clk_25)
        );

    wire video_on;         // Signal indicating if current pixel is within display area
    wire [15:0] address;   // Memory address derived from pixel coordinates
    
    wire [2:0] one;
    assign one = {pixel_y[8], pixel_x[9:8]};
    
    // Generate memory address based on pixel coordinates
    assign address = {pixel_y[7:0], pixel_x[7:0]};

    // Instantiate VGA Controller
    VGA_controller U1 (
        .clk(clk_25),           // Direct system clock (assumes it's compatible with VGA timing)
        .reset_n(reset_n),
        .video_on(video_on),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .hsync(hsync),
        .vsync(vsync)
    );

    // Instantiate Memory ROM
    memory_rom U2 (
        .clk(clk_25),           // System clock
        .rd_ena(video_on),     // Enable read only when pixel is within display area
        .addr(address),
        .one(one),
        .VGA_R(VGA_R),
        .VGA_G(VGA_G),
        .VGA_B(VGA_B)
    );

endmodule
