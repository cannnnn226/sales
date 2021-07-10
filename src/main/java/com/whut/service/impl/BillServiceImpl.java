package com.whut.service.impl;

import com.github.pagehelper.PageHelper;
import com.whut.dao.BillDao;
import com.whut.entity.Bill;
import com.whut.service.BillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillServiceImpl implements BillService {

    private final BillDao billDao;

    public BillServiceImpl(BillDao billDao) {
        this.billDao = billDao;
    }

    @Override
    public List<Bill> findAll(Integer page, Integer size, String code, Integer searchId) {
        PageHelper.startPage(page, size);
        return billDao.findAll(code, searchId) ;
    }

    @Override
    public Bill getBillById(Integer id) {
        return billDao.getBillById(id);
    }

    @Override
    public void delBillById(Integer id) {
        billDao.delBillById(id);
    }

    @Override
    public void updateBillsByUserId(Integer user_id) {
        billDao.updateBillsByUserId(user_id);
    }

    @Override
    public void addBill(Bill bill) {
        billDao.addBill(bill);
    }
}
