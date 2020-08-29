package com.sbs.khr.memome.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Member;

@Mapper
public interface MemberDao {

	void join(Map<String, Object> param);

	int getLoginIdDupCount(@Param("loginId") String loginId);

	int getNicknameDupCount(@Param("nickname") String nickname);

	int getEmailDupCount(@Param("email") String email);

	Member getMemberById(@Param("id") int id);

	Member getMemberByLoginId(@Param("loginId") String loginId);

	Member getMemberByEmail(@Param("email") String email);

	Member getMemberByNameAndEmail(Map<String, Object> param);

	Member getMemberByLoginIdAndEmail(Map<String, Object> param);

	void memberDataUpdate(Map<String, Object> param);

	void passwordUpdate(Map<String, Object> param);

	void accountDelete(Map<String, Object> param);

}
