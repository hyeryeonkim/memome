package com.sbs.khr.memome.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDao {

	int join(Map<String, Object> param);

}
