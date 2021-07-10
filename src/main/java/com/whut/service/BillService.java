package com.whut.service;

import com.whut.entity.Bill;

import java.util.List;

public interface BillService {

    List<Bill> findAll(Integer page, Integer size, String code, Integer searchId);

    Bill getBillById(Integer id);

    void delBillById(Integer id);

    void updateBillsByUserId(Integer user_id);

    void addBill(Bill bill);
}
