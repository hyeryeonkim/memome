package com.sbs.khr.memome.service;

	
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.HashtagDao;

@Service
public class HashtagService {
	
	@Autowired
	private HashtagDao hashTagDao;

	

	// 필요한거 relId, hashTag, relTypeCode, memberId
	public void tagWrite(int relId, String hashTag, int memberId, String relTypeCode) {
		
		String[] hashTagBits = hashTag.split("#");
		
		System.out.println("hashTagBits의 길이 : " + hashTagBits.length);
		System.out.println("hashTagBits 그대로 : " + hashTagBits);
		
		
		for ( int i = 0; i < hashTagBits.length; i++ ) {
			//hashTagBits[i + 1]. =  
		}
		
		
		hashTagDao.tagWrite(relId, hashTagBits[1], memberId, relTypeCode);
	}
	
	
	
	
}
