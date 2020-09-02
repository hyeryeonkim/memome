package com.sbs.khr.memome.dto;


import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Hashtag {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private int relId;
	private String tag;
	private int memberId;
}
