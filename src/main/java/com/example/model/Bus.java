package com.example.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "buses")
public class Bus implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String licensePlate;
    
    @Column(nullable = false)
    private Integer capacity; // Number of seats
    
    @Column(nullable = false)
    private String busType; // Type of bus
    
    // Constructors
    public Bus() {}
    
    public Bus(String licensePlate, Integer capacity, String busType) {
        this.licensePlate = licensePlate;
        this.capacity = capacity;
        this.busType = busType;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getLicensePlate() {
        return licensePlate;
    }
    
    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }
    
    public Integer getCapacity() {
        return capacity;
    }
    
    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }
    
    public String getBusType() {
        return busType;
    }
    
    public void setBusType(String busType) {
        this.busType = busType;
    }
} 