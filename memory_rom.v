`timescale 1ns / 1ps

module memory_rom
#(parameter depth = 16)
(
    input clk,
    input rd_ena,
    input [depth-1:0] addr,
    input [2:0] one,
    output reg [3:0] VGA_R,
    output reg [3:0] VGA_G,
    output reg [3:0] VGA_B
);

    // ROM 배열 선언, 각 픽셀 데이터는 4비트로(gray scale)
    reg [3:0] rom [0:2**depth-1];

    // 초기 메모리 로드
    initial
        $readmemb("inverted_cameraman_binary.mem", rom);

    // 클럭 상승 엣지에서 데이터 읽기
    always @(posedge clk) begin
        if (rd_ena) begin
            if(one == 000) begin
                VGA_R <= rom[addr];
                VGA_G <= rom[addr];
                VGA_B <= rom[addr];
            end
            else begin
                VGA_R <= 4'b0;
                VGA_G <= 4'b0;
                VGA_B <= 4'b0;
            end
       end
       else begin
            VGA_R <= 4'b0;
            VGA_G <= 4'b0;
            VGA_B <= 4'b0;
       end
    end
endmodule
