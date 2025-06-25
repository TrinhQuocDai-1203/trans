package com.example.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.model.Ticket;
import com.example.model.Trip;
import com.example.services.TicketService;
import com.example.services.TripService;

@Controller
public class HomeController {

    private final TripService tripService;
    private final TicketService ticketService;
    
    @Autowired
    public HomeController(TripService tripService, TicketService ticketService) {
        this.tripService = tripService;
        this.ticketService = ticketService;
    }

    @GetMapping("/")
    public String homePage(Model model) {
        // Add current date for the date input min attribute
        model.addAttribute("now", java.time.LocalDate.now().toString());
        
        // Lấy danh sách địa điểm có sẵn
        List<String> locations = tripService.getAvailableLocations();
        model.addAttribute("locations", locations);
        
        return "index";
    }

    @PostMapping("/")
    public String searchTrips(
            @RequestParam String departureLocation,
            @RequestParam String destinationLocation,
            @RequestParam String departureDate,
            Model model) {

        model.addAttribute("departureLocation", departureLocation);
        model.addAttribute("destinationLocation", destinationLocation);
        model.addAttribute("departureDate", departureDate);
        
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            dateFormat.setLenient(false);
            Date parsedDate = dateFormat.parse(departureDate);
            
            List<Trip> trips = tripService.searchTrips(
                    departureLocation, 
                    destinationLocation, 
                    parsedDate);
            
            model.addAttribute("trips", trips);
            model.addAttribute("showResults", true);
            
        } catch (ParseException e) {
            System.out.println("ParseException: " + e);
            model.addAttribute("dateError", "Invalid date format. Please use YYYY-MM-DD format.");
        }
        
        return "index";
    }
    
    @RequestMapping(value = "/lich-trinh", method = RequestMethod.GET)
    public String scheduleList(Model model) {
        // Hiển thị tất cả các chuyến trong tương lai
        List<Trip> trips = tripService.getFutureTrips();
        model.addAttribute("trips", trips);
        
        return "schedule-list";
    }
    
    @GetMapping("/tra-cuu-ve")
    public String ticketLookup(Model model) {
        return "ticket-lookup";
    }
    
    @PostMapping("/tra-cuu-ve")
    public String searchTicket(@RequestParam String ticketId,
                              @RequestParam String phone,
                              Model model) {
        try {
            Long id = Long.parseLong(ticketId);
            Ticket ticket = ticketService.getTicketById(id);
            
            if (ticket != null && ticket.getUser().getNumberPhone().equals(phone)) {
                model.addAttribute("ticket", ticket);
                model.addAttribute("found", true);
            } else {
                model.addAttribute("error", "Không tìm thấy vé với thông tin đã nhập");
            }
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Mã vé không hợp lệ");
        }
        
        return "ticket-lookup";
    }

    @GetMapping("/search")
    public String search() {
        return "search";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
}