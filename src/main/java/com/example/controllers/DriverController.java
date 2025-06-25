package com.example.controllers;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.model.Seat;
import com.example.model.Ticket;
import com.example.model.Trip;
import com.example.model.User;
import com.example.services.SeatService;
import com.example.services.TicketService;
import com.example.services.TripService;

@Controller
@RequestMapping("/driver")
public class DriverController {
    
    private final TripService tripService;
    private final SeatService seatService;
    private final TicketService ticketService;
    
    @Autowired
    public DriverController(TripService tripService, SeatService seatService, TicketService ticketService) {
        this.tripService = tripService;
        this.seatService = seatService;
        this.ticketService = ticketService;
    }
    
    @GetMapping("/")
    public String driverDashboard(HttpSession session, Model model) {
        User driver = (User) session.getAttribute("user");
        if (driver == null || driver.getRole() != User.Role.DRIVER) {
            return "redirect:/login";
        }
        
        // Lấy chuyến đi được giao cho tài xế này
        List<Trip> driverTrips = tripService.getTripsByDriver(driver);
        model.addAttribute("upcomingTrips", driverTrips.stream()
                .filter(trip -> "SCHEDULED".equals(trip.getStatus()))
                .limit(5)
                .collect(Collectors.toList()));
        
        // Thêm một số thống kê cơ bản
        model.addAttribute("totalTrips", driverTrips.size());
        model.addAttribute("upcomingTripsCount", driverTrips.stream()
                .filter(trip -> "SCHEDULED".equals(trip.getStatus()))
                .count());
        
        return "driver/index";
    }
    
    @GetMapping("/trips")
    public String manageTrips(HttpSession session, Model model) {
        User driver = (User) session.getAttribute("user");
        if (driver == null || driver.getRole() != User.Role.DRIVER) {
            return "redirect:/login";
        }
        
        // Lấy tất cả chuyến đi được giao cho tài xế này
        List<Trip> driverTrips = tripService.getTripsByDriver(driver);
        model.addAttribute("trips", driverTrips);
        
        return "driver/trips";
    }
    
    @GetMapping("/schedule")
    public String manageSchedule(HttpSession session, Model model) {
        User driver = (User) session.getAttribute("user");
        if (driver == null || driver.getRole() != User.Role.DRIVER) {
            return "redirect:/login";
        }
        
        // Lấy lịch trình của tài xế này
        List<Trip> driverTrips = tripService.getTripsByDriver(driver);
        model.addAttribute("scheduledTrips", driverTrips);
        
        return "driver/schedule";
    }
    
    @GetMapping("/seats/{tripId}")
    public String viewSeatMap(@PathVariable Long tripId, HttpSession session, Model model) {
        User driver = (User) session.getAttribute("user");
        if (driver == null || driver.getRole() != User.Role.DRIVER) {
            return "redirect:/login";
        }
        
        Trip trip = tripService.getTripById(tripId);
        if (trip == null) {
            return "redirect:/driver/trips";
        }

        
        // Lấy tất cả ghế cho chuyến đi này
        List<Seat> allSeats = seatService.getSeatsByTrip(trip);
        
        // Lấy tất cả vé đã đặt cho chuyến đi này để lấy thông tin hành khách
        List<Ticket> tickets = ticketService.getTicketsByTrip(trip);
        
        // Tạo một bản đồ của ID ghế đến vé để tìm kiếm nhanh
        Map<Long, Ticket> seatTicketMap = tickets.stream()
                .collect(Collectors.toMap(
                        ticket -> ticket.getSeat().getId(), 
                        ticket -> ticket
                ));
        
        model.addAttribute("trip", trip);
        model.addAttribute("seats", allSeats);
        model.addAttribute("seatTicketMap", seatTicketMap);
        
        return "driver/seats";
    }
}