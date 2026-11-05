package com.example.demo.dao;

import com.example.demo.model.Bulletin;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BulletinDao {

    @Autowired
    private SessionFactory sessionFactory;

    private final String GET_ALL_BULLETINS = "FROM Bulletin b ORDER BY b.publishDate DESC";
    private  final String GET_ALL_COUNT = "SELECT COUNT(b) FROM Bulletin b";

    public List<Bulletin> getAllBulletins() {
        return sessionFactory.getCurrentSession().createQuery(GET_ALL_BULLETINS, Bulletin.class).list();
    }

    public Bulletin getBulletinById(Integer id) {
        return sessionFactory.getCurrentSession().get(Bulletin.class, id);
    }

    public void saveBulletin(Bulletin bulletin) {
        sessionFactory.getCurrentSession().saveOrUpdate(bulletin);
    }

    public void deleteBulletin(Integer id) {
        Bulletin bulletin = getBulletinById(id);
        if (bulletin != null) {
            bulletin.setDeleted(true);
            sessionFactory.getCurrentSession().update(bulletin);
        }
    }

    public List<Bulletin> findPaginated(int page) {
        Query<Bulletin> query = sessionFactory.getCurrentSession().createQuery(GET_ALL_BULLETINS, Bulletin.class);
        query.setFirstResult(page * 5);
        query.setMaxResults(5);
        return query.getResultList();
    }

    public long countTotal() {
        Query<Long> query = sessionFactory.getCurrentSession().createQuery(GET_ALL_COUNT, Long.class);
        return query.getSingleResult();
    }
}
