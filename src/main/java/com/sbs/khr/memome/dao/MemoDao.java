package com.sbs.khr.memome.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.khr.memome.dto.Board;
import com.sbs.khr.memome.dto.Memo;

@Mapper
public interface MemoDao {

	Board getBoardByCode(@Param("boardCode") String boardCode);

	List<Memo> getForPrintMemos( @Param("memberId") int memberId);
	
	List<Memo> getForAllPrintMemos();

	List<Memo> makeCateForMemo();

	int makeMemoCate(Map<String, Object> param);

	void memoModify(Map<String, Object> param);

	void memoDelete(Map<String, Object> newParam);

	
	
}
