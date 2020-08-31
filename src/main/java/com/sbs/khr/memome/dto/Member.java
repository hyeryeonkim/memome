package com.sbs.khr.memome.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String passwordUpdateDate;
	private boolean delStatus;
	private String delDate;
	private boolean authStatus;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickname;
	private String email;
	private Map<String, Object> extra;
	private String cellphoneNo;
}
