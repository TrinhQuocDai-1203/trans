package com.example.dao;

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
public class TripDAO {
    
    private final SessionFactory sessionFactory;
    
    @Autowired
    public TripDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    
    public void saveTrip(Trip trip) {
        getCurrentSession().saveOrUpdate(trip);
    }
    
    public Trip getTripById(Long id) {
        return getCurrentSession().get(Trip.class, id);
    }
    
    public List<Trip> getAllTrips() {
        Query<Trip> query = getCurrentSession().createQuery("FROM Trip ORDER BY departureTime", Trip.class);
        return query.getResultList();
    }
    
    public List<Trip> getTripsByPrimaryDriver(User driver) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip WHERE primaryDriver = :driver ORDER BY departureTime", Trip.class);
        query.setParameter("driver", driver);
        return query.getResultList();
    }
    
    public List<Trip> getTripsBySecondaryDriver(User driver) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip WHERE secondaryDriver = :driver ORDER BY departureTime", Trip.class);
        query.setParameter("driver", driver);
        return query.getResultList();
    }
    
    public List<Trip> getTripsByDriver(User driver) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip WHERE primaryDriver = :driver OR secondaryDriver = :driver ORDER BY departureTime", Trip.class);
        query.setParameter("driver", driver);
        return query.getResultList();
    }
    
    public List<Trip> getTripsByStatus(String status) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip WHERE status = :status ORDER BY departureTime", Trip.class);
        query.setParameter("status", status);
        return query.getResultList();
    }
    
    public List<Trip> getTripsByDate(Date startDate, Date endDate) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip WHERE departureTime BETWEEN :startDate AND :endDate ORDER BY departureTime", Trip.class);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getResultList();
    }
    
    public void deleteTrip(Long id) {
        Trip trip = getTripById(id);
        if (trip != null) {
            getCurrentSession().delete(trip);
        }
    }
    
    public Long countTripsByDate(Date startDate, Date endDate) {
        Query<Long> query = getCurrentSession().createQuery(
                "SELECT COUNT(*) FROM Trip WHERE departureTime BETWEEN :startDate AND :endDate", Long.class);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        return query.getSingleResult();
    }
    
    public List<Trip> searchTrips(String departureLocation, String destinationLocation, Date startDate, Date endDate) {
        StringBuilder queryBuilder = new StringBuilder("FROM Trip t WHERE ");
        
        if (departureLocation != null && !departureLocation.isEmpty()) {
            queryBuilder.append("(t.departureLocation = :departureLocation OR t.departureLocation LIKE :departureName) AND ");
        }
        
        if (destinationLocation != null && !destinationLocation.isEmpty()) {
            queryBuilder.append("(t.destinationLocation = :destinationLocation OR t.destinationLocation LIKE :destinationName) AND ");
        }
        
        queryBuilder.append("t.departureTime >= :startDate ");
        
        if (endDate != null) {
            queryBuilder.append("AND t.departureTime <= :endDate ");
        }
        
        queryBuilder.append("AND t.status = 'SCHEDULED' AND t.availableSeats > 0 ORDER BY t.departureTime");
        
        Query<Trip> query = getCurrentSession().createQuery(queryBuilder.toString(), Trip.class);
        
        if (departureLocation != null && !departureLocation.isEmpty()) {
            query.setParameter("departureLocation", departureLocation);
            query.setParameter("departureName", "%" + departureLocation + "%");
        }
        
        if (destinationLocation != null && !destinationLocation.isEmpty()) {
            query.setParameter("destinationLocation", destinationLocation);
            query.setParameter("destinationName", "%" + destinationLocation + "%");
        }
        
        query.setParameter("startDate", startDate);
        
        if (endDate != null) {
            query.setParameter("endDate", endDate);
        }
        
        return query.getResultList();
    }
    
    public List<Trip> findPotentialIndirectTrips(String departureLocation, Date startDate, Date endDate) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip t WHERE " +
                "(t.departurePoint.city = :departureLocation OR t.departurePoint.name LIKE :departureName) AND " +
                "t.departureTime BETWEEN :startDate AND :endDate AND " +
                "t.status = 'SCHEDULED' AND " +
                "t.availableSeats > 0 " +
                "ORDER BY t.departureTime", Trip.class);
        
        query.setParameter("departureLocation", departureLocation);
        query.setParameter("departureName", "%" + departureLocation + "%");
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
        
        return query.getResultList();
    }
    
    public List<String> getAllLocations() {
        // Lấy danh sách các điểm đi
        Query<String> departureQuery = getCurrentSession().createQuery(
                "SELECT DISTINCT t.departureLocation FROM Trip t ORDER BY t.departureLocation", String.class);
        List<String> departureLocations = departureQuery.getResultList();
        
        // Lấy danh sách các điểm đến
        Query<String> destinationQuery = getCurrentSession().createQuery(
                "SELECT DISTINCT t.destinationLocation FROM Trip t ORDER BY t.destinationLocation", String.class);
        List<String> destinationLocations = destinationQuery.getResultList();
        
        // Kết hợp và loại bỏ trùng lặp
        List<String> allLocations = new java.util.ArrayList<>(departureLocations);
        for (String location : destinationLocations) {
            if (!allLocations.contains(location)) {
                allLocations.add(location);
            }
        }
        
        // Sắp xếp kết quả
        java.util.Collections.sort(allLocations);
        
        return allLocations;
    }
    
    public List<Trip> getFutureTrips(Date startDate) {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip t WHERE " +
                "t.departureTime >= :startDate AND " +
                "t.status = 'SCHEDULED' " +
                "ORDER BY t.departureTime", Trip.class);
        
        query.setParameter("startDate", startDate);
        
        return query.getResultList();
    }
    
    public List<Trip> getTripsByCurrentDate() {
        Date currentDate = new Date();
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip t WHERE DATE(t.departureTime) = DATE(:currentDate) " +
                "ORDER BY t.departureTime ASC", Trip.class);
        query.setParameter("currentDate", currentDate);
        return query.getResultList();
    }
    
    public List<Trip> getAllTripsOrderedByDepartureDate() {
        Query<Trip> query = getCurrentSession().createQuery(
                "FROM Trip t ORDER BY " +
                "CASE WHEN DATE(t.departureTime) = DATE(CURRENT_DATE()) THEN 0 ELSE 1 END, " +
                "t.departureTime ASC", Trip.class);
        return query.getResultList();
    }
} 