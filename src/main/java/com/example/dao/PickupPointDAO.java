package com.example.dao;

import com.example.model.PickupPoint;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PickupPointDAO {
    
    private final SessionFactory sessionFactory;
    
    @Autowired
    public PickupPointDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    
    public void savePickupPoint(PickupPoint pickupPoint) {
        getCurrentSession().saveOrUpdate(pickupPoint);
    }
    
    public PickupPoint getPickupPointById(Long id) {
        return getCurrentSession().get(PickupPoint.class, id);
    }
    
    public List<PickupPoint> getAllPickupPoints() {
        Query<PickupPoint> query = getCurrentSession().createQuery("FROM PickupPoint ORDER BY city, name", PickupPoint.class);
        return query.getResultList();
    }
    
    public List<PickupPoint> getPickupPointsByCity(String city) {
        Query<PickupPoint> query = getCurrentSession().createQuery(
                "FROM PickupPoint WHERE city = :city ORDER BY name", PickupPoint.class);
        query.setParameter("city", city);
        return query.getResultList();
    }
    
    public void deletePickupPoint(Long id) {
        PickupPoint pickupPoint = getPickupPointById(id);
        if (pickupPoint != null) {
            getCurrentSession().delete(pickupPoint);
        }
    }
}