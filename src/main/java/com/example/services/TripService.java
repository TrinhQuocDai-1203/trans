package com.example.services;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.TripDAO;
import com.example.model.Bus;
import com.example.model.PickupPoint;
import com.example.model.Trip;
import com.example.model.User;

@Service
@Transactional
public class TripService {
    
    private final TripDAO tripDAO;
    private final SeatService seatService;
    
    @Autowired
    public TripService(TripDAO tripDAO, SeatService seatService) {
        this.tripDAO = tripDAO;
        this.seatService = seatService;
    }
    
    public void saveTrip(Trip trip) {
        tripDAO.saveTrip(trip);
    }
    
    public Trip getTripById(Long id) {
        return tripDAO.getTripById(id);
    }
    
    public List<Trip> getAllTrips() {
        return tripDAO.getAllTrips();
    }
    
    public List<Trip> getTripsByPrimaryDriver(User driver) {
        return tripDAO.getTripsByPrimaryDriver(driver);
    }
    
    public List<Trip> getTripsBySecondaryDriver(User driver) {
        return tripDAO.getTripsBySecondaryDriver(driver);
    }
    
    public List<Trip> getTripsByDriver(User driver) {
        return tripDAO.getTripsByDriver(driver);
    }
    
    public List<Trip> getTripsByStatus(String status) {
        return tripDAO.getTripsByStatus(status);
    }
    
    public void deleteTrip(Long id) {
        tripDAO.deleteTrip(id);
    }
    
    public List<Trip> getTripsByDate(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        Date startDate = calendar.getTime();
        
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        Date endDate = calendar.getTime();
        
        return tripDAO.getTripsByDate(startDate, endDate);
    }
    
    public Long countTripsByDate(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        Date startDate = calendar.getTime();
        
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        Date endDate = calendar.getTime();
        
        return tripDAO.countTripsByDate(startDate, endDate);
    }
    
    public List<Trip> getTripsByDateRange(Date startDate, Date endDate) {
        // Điều chỉnh ngày bắt đầu đến đầu ngày
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        Date adjustedStartDate = calendar.getTime();
        
        // Điều chỉnh ngày kết thúc đến cuối ngày
        calendar.setTime(endDate);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        Date adjustedEndDate = calendar.getTime();
        
        return tripDAO.getTripsByDate(adjustedStartDate, adjustedEndDate);
    }
    
    // Tạo một chuyến mới với ghế
    public Trip createTrip(String departureLocation, String destinationLocation, Date departureTime,
                         User primaryDriver, User secondaryDriver, Bus bus, Double price, PickupPoint departurePoint, PickupPoint destinationPoint) {
        Trip trip = new Trip(departurePoint, destinationPoint, departureTime, 
                           primaryDriver, secondaryDriver, bus, bus.getCapacity(), price);
        saveTrip(trip);

        return trip;
    }
    
    // Tìm kiếm chuyến đi với tiêu chí
    public List<Trip> searchTrips(String departureLocation, String destinationLocation, Date departureDate) {
        if (departureDate == null) {
            // Nếu không có ngày, tìm tất cả các chuyến trong tương lai
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            Date startDate = calendar.getTime();
            
            return tripDAO.searchTrips(departureLocation, destinationLocation, startDate, null);
        } else {
            // Tính toán ngày bắt đầu và kết thúc
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(departureDate);
            calendar.set(Calendar.HOUR_OF_DAY, 0);
            calendar.set(Calendar.MINUTE, 0);
            calendar.set(Calendar.SECOND, 0);
            Date startDate = calendar.getTime();
            
            calendar.set(Calendar.HOUR_OF_DAY, 23);
            calendar.set(Calendar.MINUTE, 59);
            calendar.set(Calendar.SECOND, 59);
            Date endDate = calendar.getTime();
            
            // Tìm chuyến trực tiếp
            return tripDAO.searchTrips(departureLocation, destinationLocation, startDate, endDate);
        }
    }

    // Lấy danh sách tất cả các địa điểm có sẵn
    public List<String> getAvailableLocations() {
        return tripDAO.getAllLocations();
    }

    // Lấy danh sách tất cả các chuyến trong tương lai
    public List<Trip> getFutureTrips() {
        // Lấy ngày hiện tại
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        Date today = calendar.getTime();
        
        return tripDAO.getFutureTrips(today);
    }

    public List<Trip> getTripsByCurrentDate() {
        return tripDAO.getTripsByCurrentDate();
    }
    
    public List<Trip> getAllTripsOrderedByDepartureDate() {
        return tripDAO.getAllTripsOrderedByDepartureDate();
    }
} 