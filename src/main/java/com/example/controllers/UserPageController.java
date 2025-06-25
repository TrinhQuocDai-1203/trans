package com.example.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.model.Seat;
import com.example.model.Ticket;
import com.example.model.Trip;
import com.example.model.User;
import com.example.services.PickupPointService;
import com.example.services.SeatService;
import com.example.services.TicketService;
import com.example.services.TripService;
import com.example.services.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/user")
public class UserPageController {
    
    private final TripService tripService;
    private final SeatService seatService;
    private final TicketService ticketService;
    private final UserService userService;
    private final PickupPointService pickupPointService;
    
    @Autowired
    public UserPageController(TripService tripService, SeatService seatService, 
                             TicketService ticketService, UserService userService,
                             PickupPointService pickupPointService) {
        this.tripService = tripService;
        this.seatService = seatService;
        this.ticketService = ticketService;
        this.userService = userService;
        this.pickupPointService = pickupPointService;
    }
    // xem danh sách vé đã đặt
    @GetMapping("/bookings")
    public String viewBookings(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");// lấy thog tin của user từ session
        if (user == null) {
            return "redirect:/login";// chưa đăng nhập thì bị đưa ra trang login
        }
        
        List<Ticket> tickets = ticketService.getTicketsByUser(user);//gọi Service để lấy tất cả vé của user
        model.addAttribute("tickets", tickets);// gửi danh sách vé  tới trang web
        return "user/bookings";
    }
    // xem lịch sử đặt vé
    @GetMapping("/history")
    public String viewTicketHistory(
            @RequestParam(required = false) String status,
            HttpSession session, 
            Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login?redirectUrl=/user/history";// kiểm tra nếu chưa log thì đá login xong vô lại
        }
        
        List<Ticket> tickets = ticketService.getTicketsByUser(user);// lấy tất cả vé  người dùng
        
        // Lọc theo trạng thái nếu được chỉ định
        if (status != null && !status.isEmpty()) {
            List<Ticket> filteredTickets = new ArrayList<>();
            for (Ticket ticket : tickets) {
                if (status.equalsIgnoreCase(ticket.getStatus())) {
                    filteredTickets.add(ticket);
                }
            }
            tickets = filteredTickets;
            model.addAttribute("selectedStatus", status);
        }
        
        model.addAttribute("tickets", tickets);//gửi danh sách vé
        return "user/ticket-history";//hiển thị trang lịch sử vé
    }
    // hồ sơ cá nhân
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("user", user);//gửi thông tin user
        return "user/profile";
    }

    // hiển thị trang đặt vé xe cho chuyến xe
    @GetMapping("/book-trip/{id}")
    public String bookTripPage(@PathVariable("id") Long tripId, Model model) {
        Trip trip = tripService.getTripById(tripId);
        //ko có chuyến nào thì tự quay về home
        if (trip == null) {
            return "redirect:/";
        }
        
        // Lấy tất cả danh sách ghế đã đặt cho chuyến đi này
        List<Seat> bookedSeats = seatService.getBookedSeatsByTrip(trip);
        List<String> bookedSeatNumbers = new ArrayList<>();
        
        for (Seat seat : bookedSeats) {
            bookedSeatNumbers.add(seat.getSeatNumber());
        }
        
        // Chuyển đổi thành JSON cho JavaScript 
        ObjectMapper objectMapper = new ObjectMapper();
        String bookedSeatsJson = "[]";
        try {
            bookedSeatsJson = objectMapper.writeValueAsString(bookedSeatNumbers);
        } catch (Exception e) {
            e.printStackTrace();
            bookedSeatsJson = "[]"; 
        }
        
        model.addAttribute("trip", trip);// thông tin chuyến đi
        model.addAttribute("bookedSeatsJson", bookedSeatsJson);//gửi dánh sách  ghế đã đặt
        model.addAttribute("maxSeats", 3); // chỉ đc chọn max là 3
        
        return "user/book-trip";// sơ đồ ghế
    }
    // gửi yêu cầu đặt ghế
    @PostMapping("/book-seat")
    public String bookSeat(@RequestParam("tripId") Long tripId,
                          @RequestParam("seatNumbers") String[] seatNumbers,
                          HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");//kiểm tra đã log chưa
        if (user == null) {
            return "redirect:/login";
        }
        
        Trip trip = tripService.getTripById(tripId);//lấy thông tin của chuyến xe
        
        if (trip == null) {
            model.addAttribute("error", "Invalid trip selection.");
            return "redirect:/";// ko có thì báo lỗi rồi về trang home
        }
        
        // Giới hạn tối đa 3 ghế
        int maxSeats = 3;
        int seatsToBook = Math.min(seatNumbers.length, maxSeats);
        
        List<Ticket> bookedTickets = new ArrayList<>();
        String pickupLocation = trip.getDeparturePoint().getName();
        
        for (int i = 0; i < seatsToBook; i++) {
            String seatNumber = seatNumbers[i];
            
            // Kiểm tra xem ghế đã được đặt chưa
            Seat existingSeat = seatService.getSeatByTripAndNumber(trip, seatNumber);
            
            if (existingSeat != null && existingSeat.isBooked()) {
                model.addAttribute("error", "Seat " + seatNumber + " is already booked. Please select another seat.");
                return "redirect:/user/book-trip/" + tripId;// có rồi thì báo  chọn cái khác
            }
            
            // Tạo ghế mới hoặc sử dụng ghế tồn tại
            Seat seat;
            if (existingSeat == null) {
                seat = new Seat(seatNumber, trip);
                seatService.saveSeat(seat);
            } else {
                seat = existingSeat;
            }
            
            // Đặt vé
            Ticket ticket = ticketService.bookTicket(user, trip, seat, pickupLocation);
            bookedTickets.add(ticket);
        }
        
        if (bookedTickets.size() == 1) {
            // Nếu chỉ có một vé, chuyển hướng đến trang thanh toán
            return "redirect:/user/payment/" + bookedTickets.get(0).getId();
        } else {
            // Nếu nhiều vé, chuyển hướng đến trang đặt vé
            return "redirect:/user/bookings";
        }
    }
    //thanh toán vé xe
    @GetMapping("/payment/{ticketId}")
    public String paymentPage(@PathVariable("ticketId") Long ticketId, Model model) {
        Ticket ticket = ticketService.getTicketById(ticketId);
        if (ticket == null) {
            return "redirect:/user/bookings";//ko có vé thì quay lại trang danh sách vé xe
        }
        
        model.addAttribute("ticket", ticket);//gửi thoog tin vé
        return "user/payment";//hiện trang thanh toán
    }
    // xác nhận thanh toán
    @PostMapping("/confirm-payment")
    public String confirmPayment(@RequestParam("ticketId") Long ticketId, RedirectAttributes redirectAttributes) {
        ticketService.updateTicketStatus(ticketId, "PAID");//chuyển trạng thái vé thành paid (đã thanh toán)
        redirectAttributes.addFlashAttribute("successMessage", "Thanh toán vé thành công!");
        return "redirect:/user/history";
    }
    //hủy vé xe
    @GetMapping("/cancel-ticket/{ticketId}")
    public String cancelTicket(@PathVariable("ticketId") Long ticketId, RedirectAttributes redirectAttributes) {
        ticketService.cancelTicket(ticketId);
        redirectAttributes.addFlashAttribute("successMessage", "Hủy vé thành công!");
        return "redirect:/user/history";
    }
}