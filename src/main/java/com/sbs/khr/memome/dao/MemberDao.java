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

	void memberDataUpdate(Map<String, Object> param);

	void passwordUpdate(Map<String, Object> param);

	Member getMemberByNameAndEmail(Map<String, Object> param);

	int getNicknameDupCount(@Param("nickname") String nickname);

	int getEmailDupCount(@Param("email") String email);

	Member getMemberByLoginIdAndEmail(Map<String, Object> param);

	Member getMemberByEmail(@Param("email") String email);

	void saveTempPassword(Map<String, Object> param);

	void accountDelete(Map<String, Object> param);

}
