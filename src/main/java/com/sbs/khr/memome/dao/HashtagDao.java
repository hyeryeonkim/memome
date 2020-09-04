package com.sbs.khr.memome.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Hashtag;

@Mapper
public interface HashtagDao {
	
	void tagWrite(@Param("relId") int relId, @Param("tag") String hashTag, @Param("memberId") int memberId, @Param("relTypeCode") String relTypeCode, 
			@Param("tagNo") int tagNo);

	List<Hashtag> getForPrintHashtags(@Param("relId") int id, @Param("relTypeCode") String relTypeCode);

	List<Hashtag> getForPrintAllHashtags();

	List<Hashtag> getForPrintHashtagsByRelId(@Param("relId") int relId);

}
