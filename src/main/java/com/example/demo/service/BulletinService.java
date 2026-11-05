package com.example.demo.service;

import com.example.demo.dao.BulletinDao;
import com.example.demo.model.Bulletin;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class BulletinService {

    @Autowired
    private BulletinDao bulletinDao;

    public List<Bulletin> getAllBulletins() {
        return bulletinDao.getAllBulletins();
    }

    public Bulletin getBulletinById(Integer id) {
        return bulletinDao.getBulletinById(id);
    }

    public void saveBulletin(Bulletin bulletin) {
        bulletinDao.saveBulletin(bulletin);
    }

    public void deleteBulletin(Integer id) {
        bulletinDao.deleteBulletin(id);
    }
    public List<Bulletin> findPaginated(int page) {
       return bulletinDao.findPaginated(page);
    }

    public long countTotal() {
        return bulletinDao.countTotal();
    }
}
