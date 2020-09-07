package com.sbs.khr.memome.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Hashtag;

@Mapper
public interface HashtagDao {
	
	void tagWrite(@Param("relId") int relId, @Param("tag") String hashTag, @Param("memberId") int memberId, @Param("relTypeCode") String relTypeCode);

	List<Hashtag> getForPrintHashtags(@Param("relId") int id, @Param("relTypeCode") String relTypeCode);

	List<Hashtag> getForPrintAllHashtags();

	List<Hashtag> getForPrintHashtagsByRelId(@Param("relId") int relId);
	List<String> getForPrintHashtagsByRelIdStr(@Param("relId") int relId);

	String getForPrintOriginHashtagByRelId(int relId);

	int getOriginTagByTagNo(@Param("tagNo") int tagNo,@Param("relId") int relId);

	void update(@Param("tag") String tag, @Param("relId") int relId, @Param("tagNo") int tagNo);

	void delete(@Param("relId") int relId, @Param("tag") String tag, @Param("memberId") int memberId);

	void hashtagDelete(@Param("relId") int relId, @Param("memberId") int memberId);

	List<String> getForPrintHashtagsById(@Param("id") int id);

	Integer getForPrintHashtagBytag(@Param("tag") String tag);


	

}
