package com.sbs.khr.memome.service;

	
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.HashtagDao;
import com.sbs.khr.memome.dto.Hashtag;

@Service
public class HashtagService {
	
	@Autowired
	private HashtagDao hashtagDao;

	

	// 필요한거 relId, hashTag, relTypeCode, memberId
	public void tagWrite(int relId, String hashTag, int memberId, String relTypeCode) {
		
		if ( hashTag.length() == 0 ) {
			return;
		}
		
		String[] hashTagBits = hashTag.split("#");
		System.out.println("length가 뭔데? : " + hashTagBits.length);
		
		for ( int tagNo = 1; tagNo < hashTagBits.length; tagNo++ ) {
			hashtagDao.tagWrite(relId, hashTagBits[tagNo], memberId, relTypeCode, tagNo);
		}
		
		
		/*
		 * if ( hashTagBits.length > 2 ) { for ( int i = 3; i <= hashTagBits.length; i++
		 * ) { hashTagDao.tagUpdate(relId, hashTagBits[i], memberId, relTypeCode); } }
		 */
		
		System.out.println("hashTagBits의 길이 : " + hashTagBits.length);
		System.out.println("hashTagBits 그대로 : " + hashTagBits);
		
		/*
		 * for ( int i = 0; i < hashTagBits.length; i++ ) { //hashTagBits[i + 1]. = }
		 */
		
		
		
	}


	// id = articleId
	public List<Hashtag> getForPrintHashtags(int id, String relTypeCode) {
		
		List<Hashtag> hashtags = hashtagDao.getForPrintHashtags(id, relTypeCode);
		return hashtags;
	}


	public List<Hashtag> getForPrintAllHashtags() {
		return hashtagDao.getForPrintAllHashtags();
	}
	
	
	
	
}
