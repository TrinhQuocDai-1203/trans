package com.example.dao;

import com.example.model.Ticket;
import com.example.model.Trip;
import com.example.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public class TicketDAO {
    
    private final SessionFactory sessionFactory;
    
    @Autowired
    public TicketDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    
    public void saveTicket(Ticket ticket) {
        getCurrentSession().saveOrUpdate(ticket);
    }
    
    public Ticket getTicketById(Long id) {
        return getCurrentSession().get(Ticket.class, id);
    }
    
    public List<Ticket> getAllTickets() {
        Query<Ticket> query = getCurrentSession().createQuery("FROM Ticket", Ticket.class);
        return query.getResultList();
    }
    
    public List<Ticket> getTicketsByUser(User user) {
        Query<Ticket> query = getCurrentSession().createQuery(
                "FROM Ticket WHERE user = :user ORDER BY bookingDate DESC", Ticket.class);
        query.setParameter("user", user);
        return query.getResultList();
    }
    
    public List<Ticket> getTicketsByTrip(Trip trip) {
        Query<Ticket> query = getCurrentSession().createQuery(
                "FROM Ticket WHERE trip = :trip", Ticket.class);
        query.setParameter("trip", trip);
        return query.getResultList();
    }
    
    public List<Ticket> getTicketsByStatus(String status) {
        Query<Ticket> query = getCurrentSession().createQuery(
                "FROM Ticket WHERE status = :status", Ticket.class);
        query.setParameter("status", status);
        return query.getResultList();
    }
    
    public void deleteTicket(Long id) {
        Ticket ticket = getTicketById(id);
        if (ticket != null) {
            getCurrentSession().delete(ticket);
        }
    }
    
    public Long countTicketsByTrip(Trip trip) {
        Query<Long> query = getCurrentSession().createQuery(
                "SELECT COUNT(t) FROM Ticket t WHERE t.trip = :trip", Long.class);
        query.setParameter("trip", trip);
        return query.getSingleResult();
    }
    
    public Long countTicketsByUserAndTrip(User user, Trip trip) {
        Query<Long> query = getCurrentSession().createQuery(
                "SELECT COUNT(t) FROM Ticket t WHERE t.user = :user AND t.trip = :trip", Long.class);
        query.setParameter("user", user);
        query.setParameter("trip", trip);
        return query.getSingleResult();
    }
    

    public List<Ticket> searchTickets(String customerName, String phoneNumber, java.util.Date bookingDate) {
        StringBuilder queryString = new StringBuilder("FROM Ticket t JOIN FETCH t.user u WHERE 1=1");
        
        if (customerName != null && !customerName.trim().isEmpty()) {
            queryString.append(" AND LOWER(u.fullName) LIKE LOWER(:customerName)");
        }
        
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            queryString.append(" AND u.numberPhone LIKE :phoneNumber");
        }
        
        if (bookingDate != null) {
            queryString.append(" AND DATE(t.bookingDate) = DATE(:bookingDate)");
        }
        
        // Sắp xếp theo trạng thái (PENDING và PAID lên trên), sau đó theo ngày đặt giảm dần
        queryString.append(" ORDER BY CASE WHEN t.status IN ('PENDING', 'PAID') THEN 0 ELSE 1 END, t.bookingDate DESC");
        
        Query<Ticket> query = getCurrentSession().createQuery(queryString.toString(), Ticket.class);
        
        if (customerName != null && !customerName.trim().isEmpty()) {
            query.setParameter("customerName", "%" + customerName.trim() + "%");
        }
        
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            query.setParameter("phoneNumber", "%" + phoneNumber.trim() + "%");
        }
        
        if (bookingDate != null) {
            query.setParameter("bookingDate", bookingDate);
        }
        
        return query.getResultList();
    }
    
    public List<Ticket> getTicketsByDate(java.util.Date date) {
        Query<Ticket> query = getCurrentSession().createQuery(
                "FROM Ticket t WHERE DATE(t.bookingDate) = DATE(:date) " +
                "ORDER BY CASE WHEN t.status IN ('PENDING', 'PAID') THEN 0 ELSE 1 END, t.bookingDate DESC", Ticket.class);
        query.setParameter("date", date);
        return query.getResultList();
    }
    
    public List<Ticket> getExpiredPendingTickets() {
        Date now = new Date();
        Query<Ticket> query = getCurrentSession().createQuery(
                "FROM Ticket t WHERE t.status = 'PENDING' AND t.paymentDeadline < :now", 
                Ticket.class);
        query.setParameter("now", now);
        return query.getResultList();
    }
} 