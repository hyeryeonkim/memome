package com.sbs.khr.memome.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface HashtagDao {
	
	void tagWrite(@Param("relId") int relId, @Param("tag") String hashTag, @Param("memberId") int memberId, @Param("relTypeCode") String relTypeCode);

}
