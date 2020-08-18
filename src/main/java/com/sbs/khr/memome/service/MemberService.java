package com.sbs.khr.memome.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.MemberDao;

@Service
public class MemberService {

	@Autowired
	private MemberDao memberDao;

	public int join(Map<String, Object> param) {
		return memberDao.join(param);
	}
	
}
