package com.example.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Calendar;

@Entity
@Table(name = "tickets")
public class Ticket implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "trip_id")
    private Trip trip;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "seat_id")
    private Seat seat;
    
    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date bookingDate;
    
    @Column(nullable = false)
    private String pickupLocation;
    
    @Column
    private String status; // "CONFIRMED", "CANCELLED", "PENDING", "PAID"
    
    @Column
    private Double price;
    
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date paymentDeadline;
    
    // Constructors
    public Ticket() {}
    
    public Ticket(User user, Trip trip, Seat seat, String pickupLocation) {
        this.user = user;
        this.trip = trip;
        this.seat = seat;
        this.bookingDate = new Date();
        this.pickupLocation = pickupLocation;
        this.status = "PENDING";
        this.price = trip.getPrice();
        
        // Đặt thời hạn thanh toán là 10 phút sau khi đặt vé
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(this.bookingDate);
        calendar.add(Calendar.MINUTE, 10);
        this.paymentDeadline = calendar.getTime();
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Trip getTrip() {
        return trip;
    }
    
    public void setTrip(Trip trip) {
        this.trip = trip;
    }
    
    public Seat getSeat() {
        return seat;
    }
    
    public void setSeat(Seat seat) {
        this.seat = seat;
    }
    
    public Date getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public String getPickupLocation() {
        return pickupLocation;
    }
    
    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public Date getPaymentDeadline() {
        return paymentDeadline;
    }
    
    public void setPaymentDeadline(Date paymentDeadline) {
        this.paymentDeadline = paymentDeadline;
    }
} 