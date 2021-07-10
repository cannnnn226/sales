package com.whut.dao;

import com.whut.entity.Bill;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BillDao {

    List<Bill> findAll(@Param("code") String code,
                       @Param("user_id") Integer user_id);

    Bill getBillById(Integer id);

    void delBillById(Integer id);

    void updateBillsByUserId(Integer user_id);

    void addBill(Bill bill);
}
