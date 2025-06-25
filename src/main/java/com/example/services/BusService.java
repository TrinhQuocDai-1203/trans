package com.example.services;

import com.example.dao.BusDAO;
import com.example.model.Bus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class BusService {
    
    private final BusDAO busDAO;
    
    @Autowired
    public BusService(BusDAO busDAO) {
        this.busDAO = busDAO;
    }
    
    public void saveBus(Bus bus) {
        busDAO.saveBus(bus);
    }
    
    public Bus getBusById(Long id) {
        return busDAO.getBusById(id);
    }
    
    public List<Bus> getAllBuses() {
        return busDAO.getAllBuses();
    }
    
    public List<Bus> getBusesByCapacity(Integer capacity) {
        return busDAO.getBusesByCapacity(capacity);
    }
    
    public void deleteBus(Long id) {
        busDAO.deleteBus(id);
    }
    
    public List<Bus> searchBusesByLicensePlate(String licensePlate) {
        List<Bus> allBuses = busDAO.getAllBuses();
        if (licensePlate == null || licensePlate.trim().isEmpty()) {
            return allBuses;
        }
        
        String licensePlateLower = licensePlate.toLowerCase();
        return allBuses.stream()
                .filter(bus -> bus.getLicensePlate().toLowerCase().contains(licensePlateLower))
                .collect(Collectors.toList());
    }
} 