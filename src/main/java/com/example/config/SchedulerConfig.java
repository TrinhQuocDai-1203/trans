package com.example.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.example.services.TicketService;

@Configuration
@EnableScheduling
@ComponentScan(basePackages = "com.example.services")
public class SchedulerConfig {

    private final TicketService ticketService;

    @Autowired
    public SchedulerConfig(TicketService ticketService) {
        this.ticketService = ticketService;
    }

    /**
     * Lịch trình kiểm tra và hủy vé quá hạn thanh toán
     * Chạy mỗi phút một lần
     */
    @Scheduled(fixedRate = 60000) // 60 giây = 1 phút
    public void scheduleTicketExpirationCheck() {
        ticketService.cancelExpiredTickets();
    }
} 