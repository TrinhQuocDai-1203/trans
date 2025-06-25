package com.example.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "pickup_points")
public class PickupPoint implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column
    private String address;
    
    @Column
    private String description;
    
    @Column(nullable = false)
    private String city;
    
    // Constructors
    public PickupPoint() {}
    
    public PickupPoint(String name, String address, String description, String city) {
        this.name = name;
        this.address = address;
        this.description = description;
        this.city = city;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
}
