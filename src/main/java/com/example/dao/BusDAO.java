package com.example.dao;

import com.example.model.Bus;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BusDAO {
    
    private final SessionFactory sessionFactory;
    
    @Autowired
    public BusDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    
    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }
    
    public void saveBus(Bus bus) {
        getCurrentSession().saveOrUpdate(bus);
    }
    
    public Bus getBusById(Long id) {
        return getCurrentSession().get(Bus.class, id);
    }
    
    public List<Bus> getAllBuses() {
        Query<Bus> query = getCurrentSession().createQuery("FROM Bus", Bus.class);
        return query.getResultList();
    }
    
    public List<Bus> getBusesByCapacity(Integer capacity) {
        Query<Bus> query = getCurrentSession().createQuery(
                "FROM Bus WHERE capacity = :capacity", Bus.class);
        query.setParameter("capacity", capacity);
        return query.getResultList();
    }
    
    public void deleteBus(Long id) {
        Bus bus = getBusById(id);
        if (bus != null) {
            getCurrentSession().delete(bus);
        }
    }
} 