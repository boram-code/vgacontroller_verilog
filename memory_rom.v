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

    // ROM �迭 ����, �� �ȼ� �����ʹ� 4��Ʈ��(gray scale)
    reg [3:0] rom [0:2**depth-1];

    // �ʱ� �޸� �ε�
    initial
        $readmemb("inverted_cameraman_binary.mem", rom);

    // Ŭ�� ��� �������� ������ �б�
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
