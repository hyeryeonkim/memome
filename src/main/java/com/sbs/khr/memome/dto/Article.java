package com.sbs.khr.memome.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private boolean displayStatus;
	private String title;
	private String body;
	private int memberId;
	private int boardId;
	private Map<String, Object> extra;
	
	
	public String getDetailLink(String boardCode) {
		return "/usr/article/" + boardCode + "-detail?id=" + id;
	}
	
	public String getBodyForXTemplate() {
		return body.replaceAll("(?i)script", "<!--REPLACE:script-->").trim();
	}
	
}
