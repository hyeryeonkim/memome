package com.sbs.khr.memome.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.MemoDao;
import com.sbs.khr.memome.dto.Board;
import com.sbs.khr.memome.dto.Memo;

@Service
public class MemoService {
	
	@Autowired
	private MemoDao memoDao;

	public Board getBoardByCode(String boardCode) {
		return memoDao.getBoardByCode(boardCode);
	}
	
	// id = boardId
	public List<Memo> getForPrintMemos( int memberId) {
		return memoDao.getForPrintMemos( memberId);
	}
	
	public List<Memo> getForAllPrintMemos() {
		return memoDao.getForAllPrintMemos();
	}

	public List<Memo> makeCateForMemo() {
		return memoDao.makeCateForMemo();
	}

	public int makeMemoCate(Map<String, Object> newParam) {
		return memoDao.makeMemoCate(newParam);
	}

	
	

	

	

	
}
