package com.whut.service.impl;

import com.whut.dao.DetailsDao;
import com.whut.entity.Details;
import com.whut.service.DetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetailsServiceImpl implements DetailsService {

    private final DetailsDao detailsDao;

    public DetailsServiceImpl(DetailsDao detailsDao) {
        this.detailsDao = detailsDao;
    }

    @Override
    public List<Details> findDetailsByBillId(Integer bill_id) {
        return detailsDao.findDetailsByBillId(bill_id);
    }

    @Override
    public void delDetailsById(Integer id) {
        detailsDao.delDetailsById(id);
    }

    @Override
    public void addDetails(Details details) {
        detailsDao.addDetails(details);
    }
}
