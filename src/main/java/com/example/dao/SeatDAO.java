package com.example.dao;

import com.example.model.Seat;
import com.example.model.Trip;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SeatDAO {
    
    private final SessionFactory sessionFactory;
    
    @Autowired
    public SeatDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    
    public void saveSeat(Seat seat) {
        getCurrentSession().saveOrUpdate(seat);
    }
    
    public Seat getSeatById(Long id) {
        return getCurrentSession().get(Seat.class, id);
    }
    
    public List<Seat> getAllSeats() {
        Query<Seat> query = getCurrentSession().createQuery("FROM Seat", Seat.class);
        return query.getResultList();
    }
    
    public List<Seat> getSeatsByTrip(Trip trip) {
        Query<Seat> query = getCurrentSession().createQuery(
                "FROM Seat WHERE trip.id = :tripId", Seat.class);
        query.setParameter("tripId", trip.getId());
        return query.getResultList();
    }
    
    public List<Seat> getAvailableSeatsByTrip(Trip trip) {
        Query<Seat> query = getCurrentSession().createQuery(
                "FROM Seat WHERE trip.id = :tripId AND isBooked = false", Seat.class);
        query.setParameter("tripId", trip.getId());
        return query.getResultList();
    }
    
    public Seat getSeatByTripAndNumber(Trip trip, String seatNumber) {
        Query<Seat> query = getCurrentSession().createQuery(
                "FROM Seat WHERE trip.id = :tripId AND seatNumber = :seatNumber", Seat.class);
        query.setParameter("tripId", trip.getId());
        query.setParameter("seatNumber", seatNumber);
        return query.uniqueResult();
    }
    
    public void deleteSeat(Long id) {
        Seat seat = getSeatById(id);
        if (seat != null) {
            getCurrentSession().delete(seat);
        }
    }
    
    
    public List<Seat> getBookedSeatsByTrip(Trip trip) {
        Query<Seat> query = getCurrentSession().createQuery(
                "FROM Seat WHERE trip.id = :tripId AND isBooked = true", Seat.class);
        query.setParameter("tripId", trip.getId());
        return query.getResultList();
    }
} 