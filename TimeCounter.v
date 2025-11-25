///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: TimeCounter.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFireSoC> <Die::MPFS095T> <Package::FCSG325>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module TimeCounter(
    input wire clk,
    input wire reset,            // Active Low (0 là Reset)
    input wire [1:0] buttonState,// 0: Idle, 1: Short, 2: Long
    output reg [3:0] h1, h0,     // Giờ chục (0-2), Giờ đơn vị (0-9)
    output reg [3:0] m1, m0,     // Phút chục (0-5), Phút đơn vị (0-9)
    output reg [1:0] mode        // 0: Run, 1: Edit Min, 2: Edit Hour
);

    reg [25:0] counter;
    reg [6:0] second; // Giây giữ nguyên đếm thường (0-59) cho đơn giản

    always @(posedge clk) begin
        if (reset == 1'b0) begin
            h1 <= 0; h0 <= 0;
            m1 <= 0; m0 <= 0;
            second  <= 0;
            counter <= 0;
            mode    <= 0;
        end 
        else begin
            case (mode)
                // --- MODE 0: ĐANG CHẠY ---
                2'd0: begin
                    // Chuyển mode nếu nhấn giữ
                    if (buttonState == 2'd2) mode <= 2'd1;

                    // Bộ đếm giây
                    if (counter < 26'd49_999_999) begin
                        counter <= counter + 1;
                    end 
                    else begin
                        counter <= 0;
                        if (second < 59) begin
                            second <= second + 1;
                        end 
                        else begin
                            second <= 0;
                            
                            // --- LOGIC TĂNG PHÚT (TỰ ĐỘNG) ---
                            if (m0 < 9) begin
                                m0 <= m0 + 1;
                            end 
                            else begin // m0 = 9
                                m0 <= 0;
                                if (m1 < 5) begin
                                    m1 <= m1 + 1;
                                end 
                                else begin // m1 = 5 (tức là phút = 59)
                                    m1 <= 0;
                                    
                                    // --- LOGIC TĂNG GIỜ (TỰ ĐỘNG) ---
                                    if (h1 == 2 && h0 == 3) begin // Đang là 23 giờ
                                        h1 <= 0;
                                        h0 <= 0;
                                    end 
                                    else begin
                                        if (h0 < 9) begin
                                            h0 <= h0 + 1;
                                        end 
                                        else begin // h0 = 9
                                            h0 <= 0;
                                            h1 <= h1 + 1;
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                // --- MODE 1: CHỈNH PHÚT ---
                2'd1: begin
                    if (buttonState == 2'd2) mode <= 2'd2; // Sang chỉnh Giờ

                    if (buttonState == 2'd1) begin // Nhấn ngắn -> Tăng Phút
                        second <= 0; // Reset giây cho đẹp
                        
                        // Logic tăng phút BCD
                        if (m0 < 9) begin
                            m0 <= m0 + 1;
                        end 
                        else begin
                            m0 <= 0;
                            if (m1 < 5) m1 <= m1 + 1;
                            else m1 <= 0; // Quay về 00 (Không tăng giờ)
                        end
                    end
                end

                // --- MODE 2: CHỈNH GIỜ ---
                2'd2: begin
                    if (buttonState == 2'd2) begin // Sang Chạy
                        second <= 0;
                        mode <= 2'd0;
                    end

                    if (buttonState == 2'd1) begin // Nhấn ngắn -> Tăng Giờ
                        second <= 0;
                        
                        // Logic tăng giờ BCD (00->23->00)
                        if (h1 == 2 && h0 == 3) begin
                            h1 <= 0;
                            h0 <= 0;
                        end 
                        else begin
                            if (h0 < 9) h0 <= h0 + 1;
                            else begin
                                h0 <= 0;
                                h1 <= h1 + 1;
                            end
                        end
                    end
                end
            endcase
        end
    end

endmodule
