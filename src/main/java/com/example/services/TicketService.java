package com.example.services;

import com.example.dao.TicketDAO;
import com.example.model.Seat;
import com.example.model.Ticket;
import com.example.model.Trip;
import com.example.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class TicketService {
    
    private final TicketDAO ticketDAO;
    private final SeatService seatService;
    private final TripService tripService;
    
    @Autowired
    public TicketService(TicketDAO ticketDAO, SeatService seatService, TripService tripService) {
        this.ticketDAO = ticketDAO;
        this.seatService = seatService;
        this.tripService = tripService;
    }
    
    public void saveTicket(Ticket ticket) {
        ticketDAO.saveTicket(ticket);
    }
    
    public Ticket getTicketById(Long id) {
        return ticketDAO.getTicketById(id);
    }
    
    public List<Ticket> getAllTickets() {
        return ticketDAO.getAllTickets();
    }
    
    public List<Ticket> getTicketsByUser(User user) {
        return ticketDAO.getTicketsByUser(user);
    }
    
    public List<Ticket> getTicketsByTrip(Trip trip) {
        return ticketDAO.getTicketsByTrip(trip);
    }
    
    public List<Ticket> getTicketsByStatus(String status) {
        return ticketDAO.getTicketsByStatus(status);
    }
    
    public void deleteTicket(Long id) {
        Ticket ticket = getTicketById(id);
        if (ticket != null) {
            // Bỏ ghế
            Seat seat = ticket.getSeat();
            seatService.unbookSeat(seat);
            
            // Cập nhật số ghế còn lại
            Trip trip = ticket.getTrip();
            trip.setAvailableSeats(trip.getAvailableSeats() + 1);
            tripService.saveTrip(trip);
            
            ticketDAO.deleteTicket(id);
        }
    }
    
    public Long countTicketsByTrip(Trip trip) {
        return ticketDAO.countTicketsByTrip(trip);
    }
    
    public Long countTicketsByUserAndTrip(User user, Trip trip) {
        return ticketDAO.countTicketsByUserAndTrip(user, trip);
    }
    
    public Ticket bookTicket(User user, Trip trip, Seat seat, String pickupLocation) {
        // Tạo vé mới
        Ticket ticket = new Ticket(user, trip, seat, pickupLocation);
        
        // Đặt ghế
        seatService.bookSeat(seat);
        
        // Cập nhật số ghế còn lại
        trip.setAvailableSeats(trip.getAvailableSeats() - 1);
        tripService.saveTrip(trip);
        
        // Lưu vé
        ticketDAO.saveTicket(ticket);
        
        return ticket;
    }
    
    public void updateTicketStatus(Long ticketId, String status) {
        Ticket ticket = getTicketById(ticketId);
        if (ticket != null) {
            ticket.setStatus(status);
            ticketDAO.saveTicket(ticket);
        }
    }

    public List<Ticket> searchTickets(String customerName, String phoneNumber) {
        return ticketDAO.searchTickets(customerName, phoneNumber, null);
    }
    
    public List<Ticket> searchTickets(String customerName, String phoneNumber, java.util.Date bookingDate) {
        return ticketDAO.searchTickets(customerName, phoneNumber, bookingDate);
    }
    
    public List<Ticket> getTicketsByDate(java.util.Date date) {
        return ticketDAO.getTicketsByDate(date);
    }
    
    /**
     * Kiểm tra và hủy các vé quá hạn thanh toán
     * Phương thức này sẽ được gọi định kỳ bởi một scheduler
     */
    public void cancelExpiredTickets() {
        // Lấy tất cả vé có trạng thái PENDING và đã quá hạn thanh toán
        List<Ticket> expiredTickets = ticketDAO.getExpiredPendingTickets();
        
        for (Ticket ticket : expiredTickets) {
            // Hủy vé quá hạn
            cancelTicket(ticket.getId());
        }
    }
    
    /**
     * Hủy vé và cập nhật trạng thái ghế
     */
    public void cancelTicket(Long ticketId) {
        Ticket ticket = getTicketById(ticketId);
        if (ticket != null) {
            // Bỏ ghế
            Seat seat = ticket.getSeat();
            seatService.unbookSeat(seat);
            
            // Cập nhật số ghế còn lại
            Trip trip = ticket.getTrip();
            trip.setAvailableSeats(trip.getAvailableSeats() + 1);
            tripService.saveTrip(trip);
            
            // Xóa vé thay vì chỉ thay đổi trạng thái
            ticketDAO.deleteTicket(ticketId);
        }
    }
} 