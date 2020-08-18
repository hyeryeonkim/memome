package com.sbs.khr.memome.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Member;

@Mapper
public interface MemberDao {

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);

	Member getMemberByLoginId(@Param("loginId") String loginId);

	Member getMemberById(@Param("id") int id);

}
