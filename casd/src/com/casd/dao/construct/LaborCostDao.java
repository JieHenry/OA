package com.casd.dao.construct;

import java.util.List;
import java.util.Map;

import com.casd.entity.construct.ApartyMaterial;
import com.casd.entity.construct.ApartyPur;
import com.casd.entity.construct.ApartyPurEntry;
import com.casd.entity.construct.Construct;
import com.casd.entity.construct.ConstructDep;
import com.casd.entity.construct.ProSch;

public interface  LaborCostDao {

	int getCount(Map<String, Object> param);

	List<Map<String, Object>> getList(Map<String, Object> param);





}


