package com.whut.dao;

import com.whut.entity.Details;

import java.util.List;

public interface DetailsDao {

    List<Details> findDetailsByBillId(Integer bill_id);

    void delDetailsById(Integer id);

    void addDetails(Details details);
}
