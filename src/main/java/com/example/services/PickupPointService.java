package com.example.services;

import com.example.dao.PickupPointDAO;
import com.example.model.PickupPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class PickupPointService {
    
    private final PickupPointDAO pickupPointDAO;
    
    @Autowired
    public PickupPointService(PickupPointDAO pickupPointDAO) {
        this.pickupPointDAO = pickupPointDAO;
    }
    
    public void savePickupPoint(PickupPoint pickupPoint) {
        pickupPointDAO.savePickupPoint(pickupPoint);
    }
    
    public PickupPoint getPickupPointById(Long id) {
        return pickupPointDAO.getPickupPointById(id);
    }
    
    public List<PickupPoint> getAllPickupPoints() {
        return pickupPointDAO.getAllPickupPoints();
    }
    
    public List<PickupPoint> getPickupPointsByCity(String city) {
        return pickupPointDAO.getPickupPointsByCity(city);
    }
    
    public void deletePickupPoint(Long id) {
        pickupPointDAO.deletePickupPoint(id);
    }
    
    public List<PickupPoint> searchPickupPoints(String keyword) {
        List<PickupPoint> allPoints = pickupPointDAO.getAllPickupPoints();
        if (keyword == null || keyword.trim().isEmpty()) {
            return allPoints;
        }
        
        String keywordLower = keyword.toLowerCase();
        return allPoints.stream()
                .filter(point -> 
                    point.getName().toLowerCase().contains(keywordLower) || 
                    point.getCity().toLowerCase().contains(keywordLower) ||
                    (point.getAddress() != null && point.getAddress().toLowerCase().contains(keywordLower))
                )
                .collect(Collectors.toList());
    }
}