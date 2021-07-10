package com.whut.service;

import com.whut.entity.Details;

import java.util.List;

public interface DetailsService {

    List<Details> findDetailsByBillId(Integer bill_id);

    void delDetailsById(Integer id);

    void addDetails(Details details);
}
