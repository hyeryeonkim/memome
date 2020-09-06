package com.sbs.khr.memome.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.khr.memome.dao.HashtagDao;
import com.sbs.khr.memome.dto.Hashtag;
import com.sbs.khr.memome.dto.ResultData;
import com.sbs.khr.memome.util.Util;

@Service
public class HashtagService {

	@Autowired
	private HashtagDao hashtagDao;

	// 필요한거 relId, hashTag, relTypeCode, memberId
	public void tagWrite(int relId, String hashTag, int memberId, String relTypeCode) {

		if (hashTag.length() == 0) {
			return;
		}

		String[] hashTagBits = hashTag.split("#");
		System.out.println("length가 뭔데? : " + hashTagBits.length);

		for (int i = 1; i < hashTagBits.length; i++) {
			hashtagDao.tagWrite(relId, hashTagBits[i], memberId, relTypeCode);
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

	public String getForPrintHashtagsByRelId(int relId) {

		List<Hashtag> hashtags = hashtagDao.getForPrintHashtagsByRelId(relId);

		System.out.println("hashtags 는? : " + hashtags);

		String tag = hashtags.toString();
		tag = tag.replace("[", "");
		tag = tag.replace("]", "");

		System.out.println("tag는? : " + tag);
		String[] tagBits = tag.split(",");
		System.out.println("tabBits는? : " + tagBits.toString());

		List<String> tagStr = new ArrayList<>();
		// String tag는 tag는!! String 이라서 null 일 수가 없지ㅠㅠ   length()가 0이 아니면이지!!!! 
		if (tag.length() != 0) {
			for (int i = 0; i < tagBits.length; i++) {

				tagBits[i] = "#" + tagBits[i].trim() + " ";
				tagStr.add(tagBits[i]);

				System.out.println("tagBits[" + i + "] " + tagBits[i]);

			}

		}

		String hashtag = tagStr.toString();
		System.out.println("tagStr : " + tagStr);

		hashtag = hashtag.replace("[", "");
		hashtag = hashtag.replace("]", "");
		hashtag = hashtag.replace(",", "");
		System.out.println(hashtag);

		return hashtag;
	}

	public ResultData getChechTagDup(String hashtag) {

		System.out.println("hashtag : " + hashtag);

		String[] arr = hashtag.split("#");

		List<String> arr2 = new ArrayList<>();

		/*
		 * for ( int i = 1; i < arr.length; i++ ) { arr2.add(i-1, arr[i]); }
		 */

		System.out.println("arr2 : " + arr2);

		for (int i = 0; i < arr.length; i++) {
			if (arr2.contains(arr[i]) == false) {
				arr2.add(i, arr[i]);
			} else {
				return new ResultData("F-1", "태그를 중복 사용할 수 없습니다.");
			}

		}

		System.out.println("만들어진 arr2 : " + arr2);

		return new ResultData("S-1", "태그가 중복되지 않습니다.");

	}

	// ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	// 새로운 태그를 입력받아서 #으로 split를 하면 index = 0 에는 공백이 입력.. 왜지?
	// 그래서 새로운 태그는 index = 1부터 값을 가지고 있다!
	// 그리고 DB에서 꺼내올때는 index = 0부터 값이 저장되어 있으니 참고해야 한다!
	public void hashtagModify(Map<String, Object> param, int memberId) {
		String[] tag = Util.getAsStr(param.get("tag")).split("#");

		int relId = Util.getAsInt(param.get("id"));

		List<Hashtag> origintag = hashtagDao.getForPrintHashtagsByRelId(relId);
		List<String> origintagStr = hashtagDao.getForPrintHashtagsByRelIdStr(relId);

		List<String> newTag = new ArrayList<>();

		for (String tagStr : tag) {
			newTag.add(tagStr);
		}
		System.out.println("origintag : " + origintag);

		for (int i = 0; i < origintagStr.size(); i++) {
			System.out.println(origintagStr.get(i));
		}

		System.out.println("tag[0] : " + tag[0]);
		System.out.println("tag.length" + tag.length);

		// System.out.println("tag[1] : " + tag[1]);
		System.out.println("tag.length" + tag.length);
		System.out.println("다지웠을때는 newTag.size()는? : " + newTag.size());
		// System.out.println("다지웠을때는 origintagStr.get(0)? : " + origintagStr.get(0));

		/*
		 * for (String newTag : tag) { if (origintagStr.contains(newTag) == false) {
		 * hashtagDao.tagWrite(relId, newTag, memberId, "article"); } }
		 */
		if (newTag.size() == 1) {
			for (int i = 0; i < origintagStr.size(); i++) {
				System.out.println("다지웠을때는 newTag.size()는? : " + newTag.size());

				hashtagDao.delete(relId, origintagStr.get(i), memberId);
			}
		}

		for (int i = 1; i < newTag.size(); i++) {
			if (origintagStr.contains(newTag.get(i)) == false) {
				hashtagDao.tagWrite(relId, newTag.get(i), memberId, "article");
				System.out.println("내가 INSERT(만든) 것은?0번 : " + newTag.get(i));
			}
		}

		/*
		 * if (newTagStr.length() > origintagStr.size()) { for (int i = 0; i <
		 * newTagStr.length(); i++) { if (newTagStr.contains(origintagStr.get(i + 1)) ==
		 * false) { hashtagDao.delete(relId, origintagStr.get(i + 1), memberId); } } }
		 */
		if (newTag.size() <= origintagStr.size()) {
			for (int i = 0; i < origintagStr.size(); i++) {
				if (newTag.contains(origintagStr.get(i)) == false) {
					hashtagDao.delete(relId, origintagStr.get(i), memberId);
					System.out.println("새로운 태그 newTagStr은? : " + newTag);
					System.out.println("저장되어 있던 태그 originTagStr은? : " + origintagStr);
					System.out.println("내가 삭제한 것은(index " + i + "? 1번 : " + origintagStr.get(i));
				}
			}
		}

		if (newTag.size() > origintagStr.size()) {
			for (int i = 0; i < origintagStr.size(); i++) {
				if (newTag.contains(origintagStr.get(i)) == false) {
					hashtagDao.delete(relId, origintagStr.get(i), memberId);
					System.out.println("새로운 태그 newTagStr은? : " + newTag.toString());
					System.out.println("저장되어 있던 태그 originTagStr은? : " + origintagStr);
					System.out.println("내가 삭제한 것은?2번 : " + origintagStr.get(i));
				}
			}
		}

		/*
		 * if (origintagStr.size() > tag.length) { for (String originTag : origintagStr)
		 * { if (newTagStr.contains(originTag) == false) { hashtagDao.delete(relId,
		 * originTag, memberId); } } }
		 */
		/*
		 * if (origintagStr.size() == 0) { for (int i = 0; i < tag.length; i++) {
		 * hashtagDao.tagWrite(relId, tag[i + 1], memberId, "article"); } }
		 */

		/*
		 * if (origintagStr.size() > 0) { for (int i = 0; i < tag.length; i++) {
		 * //System.out.println("tag[" + (i + 1) + "] : " + tag[i + 1]);
		 * 
		 * if (newTagStr.contains(origintagStr.get(i)) == false) {
		 * System.out.println("다르다"); System.out.println("newTagStr : " +
		 * newTagStr.toString()); System.out.println("tag[ " + i + "] : " + tag[i + 1]);
		 * hashtagDao.tagWrite(relId, tag[i + 1], memberId, "article"); } } }
		 */

		/*
		 * if ( tag.length > origintagStr.size()) { for ( int i = 0; i <
		 * origintagStr.size(); i++ ) { if ( tag[i].equals(origintagStr.get(i)) ==
		 * false) { hashtagDao.tagWrite(relId, tag[i], memberId, "article"); } } for (
		 * int i = origintagStr.size(); i < newTagStr.length(); i++ ) {
		 * hashtagDao.tagWrite(relId, tag[i], memberId, "article"); } }
		 */

		/*
		 * for ( int i = origintagStr.size(); i > newTagStr.length(); i-- ) { if (
		 * tag[i].equals(origintagStr.get(i)) == false) { hashtagDao.tagWrite(relId,
		 * tag[i], memberId, "article"); }
		 * 
		 * }
		 */

	}

	public void hashtagDelete(Map<String, Object> newParam) {
		
		int relId = Util.getAsInt(newParam.get("id"));
		int memberId = Util.getAsInt(newParam.get("memberId"));
		
		System.out.println("relId 과연 : " + relId);
		System.out.println("memberId 과연 : " + memberId);
		
		hashtagDao.hashtagDelete(relId, memberId);
		
	}


}
