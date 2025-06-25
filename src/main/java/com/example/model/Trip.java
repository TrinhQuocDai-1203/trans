package com.example.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "trips")
public class Trip implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "departure_point_id")
    private PickupPoint departurePoint;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "destination_point_id")
    private PickupPoint destinationPoint;
    
    @Column(nullable = false)
    private String departureLocation;
    
    @Column(nullable = false)
    private String destinationLocation;
    
    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date departureTime;
    
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date arrivalTime;
    
    @Column
    private String status; // SCHEDULED, IN_PROGRESS, COMPLETED, CANCELLED
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "primary_driver_id")
    private User primaryDriver;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "secondary_driver_id")
    private User secondaryDriver;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "bus_id")
    private Bus bus;
    
    @Column
    private Integer availableSeats;
    
    @Column
    private Double price;
    
    // Constructors
    public Trip() {}
    
    public Trip(PickupPoint departurePoint, PickupPoint destinationPoint, Date departureTime, 
                User primaryDriver, User secondaryDriver, Bus bus, Integer availableSeats, 
                Double price) {
        this.departurePoint = departurePoint;
        this.destinationPoint = destinationPoint;
        this.departureTime = departureTime;
        this.primaryDriver = primaryDriver;
        this.secondaryDriver = secondaryDriver;
        this.bus = bus;
        this.availableSeats = availableSeats;
        this.price = price;
        this.status = "SCHEDULED";
        
        // Set the location strings
        if (departurePoint != null) {
            this.departureLocation = departurePoint.getName() + " (" + departurePoint.getCity() + ")";
        }
        if (destinationPoint != null) {
            this.destinationLocation = destinationPoint.getName() + " (" + destinationPoint.getCity() + ")";
        }
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public PickupPoint getDeparturePoint() {
        return departurePoint;
    }
    
    public void setDeparturePoint(PickupPoint departurePoint) {
        this.departurePoint = departurePoint;
    }
    
    public PickupPoint getDestinationPoint() {
        return destinationPoint;
    }
    
    public void setDestinationPoint(PickupPoint destinationPoint) {
        this.destinationPoint = destinationPoint;
    }
    
    public String getDepartureLocation() {
        return departureLocation;
    }
    
    public void setDepartureLocation(String departureLocation) {
        this.departureLocation = departureLocation;
    }
    
    public String getDestinationLocation() {
        return destinationLocation;
    }
    
    public void setDestinationLocation(String destinationLocation) {
        this.destinationLocation = destinationLocation;
    }
    
    public Date getDepartureTime() {
        return departureTime;
    }
    
    public void setDepartureTime(Date departureTime) {
        this.departureTime = departureTime;
    }
    
    public Date getArrivalTime() {
        return arrivalTime;
    }
    
    public void setArrivalTime(Date arrivalTime) {
        this.arrivalTime = arrivalTime;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public User getPrimaryDriver() {
        return primaryDriver;
    }
    
    public void setPrimaryDriver(User primaryDriver) {
        this.primaryDriver = primaryDriver;
    }
    
    public User getSecondaryDriver() {
        return secondaryDriver;
    }
    
    public void setSecondaryDriver(User secondaryDriver) {
        this.secondaryDriver = secondaryDriver;
    }
    
    public Bus getBus() {
        return bus;
    }
    
    public void setBus(Bus bus) {
        this.bus = bus;
    }
    
    public Integer getAvailableSeats() {
        return availableSeats;
    }
    
    public void setAvailableSeats(Integer availableSeats) {
        this.availableSeats = availableSeats;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
} 