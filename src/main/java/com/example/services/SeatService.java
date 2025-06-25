package com.example.services;

import com.example.dao.SeatDAO;
import com.example.model.Seat;
import com.example.model.Trip;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SeatService {
    
    private final SeatDAO seatDAO;
    
    @Autowired
    public SeatService(SeatDAO seatDAO) {
        this.seatDAO = seatDAO;
    }
    
    public void saveSeat(Seat seat) {
        seatDAO.saveSeat(seat);
    }
    
    public Seat getSeatById(Long id) {
        return seatDAO.getSeatById(id);
    }
    
    public List<Seat> getAllSeats() {
        return seatDAO.getAllSeats();
    }
    
    public List<Seat> getSeatsByTrip(Trip trip) {
        return seatDAO.getSeatsByTrip(trip);
    }
    
    public List<Seat> getAvailableSeatsByTrip(Trip trip) {
        return seatDAO.getAvailableSeatsByTrip(trip);
    }
    
    public Seat getSeatByTripAndNumber(Trip trip, String seatNumber) {
        return seatDAO.getSeatByTripAndNumber(trip, seatNumber);
    }
    
    public void deleteSeat(Long id) {
        seatDAO.deleteSeat(id);
    }
    
    
    public void bookSeat(Seat seat) {
        seat.setBooked(true);
        seatDAO.saveSeat(seat);
    }
    
    public void unbookSeat(Seat seat) {
        seat.setBooked(false);
        seatDAO.saveSeat(seat);
    }
    
    public List<Seat> getBookedSeatsByTrip(Trip trip) {
        return seatDAO.getBookedSeatsByTrip(trip);
    }
} 