// 범용성 있는 자바스크립트
String.prototype.replaceAll = function(org, dest) {
	return this.split(org).join(dest);
}

function isCellphoneNo(str) {
	if (str.substr(0, 1) != '0') {

		return false;

	}

	return isNumber(str);
}
function isNumber(n) {

	return /^-?[\d.]+(?:e-?\d+)?$/.test(n);
}

function CheckLoginId(str) {
	var valid1 = /^[a-z0-9]{4,12}$/; // a-z 0-9 중에 7자리 부터 14자리만 허용 한다는 뜻이구요
	var valid2 = /[a-z]/g;
	var valid3 = /[0-9]/g;
	return (valid1.test(str) && valid2.test(str) && valid3.test(str));
};


// 토스트 에디터 관련(toast editor)
function jq_attr($el, attrName, elseValue) {
	var value = $el.attr(attrName);

	if (value === undefined || value === "") {
		return elseValue;
	}

	return value;
}	

// 토스트 에디터 관련(toast editor)
function getUriParams(uri) {
	uri = uri.trim();
	uri = uri.replaceAll('&amp;', '&');
	if (uri.indexOf('#') !== -1) {
		var pos = uri.indexOf('#');
		uri = uri.substr(0, pos);
	}

	var params = {};

	uri.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) {
		params[key] = value;
	});
	return params;
}

// 댓글 수정 관련 
function getHtmlEncoded(raw) {
	return raw.replace(/[\u00A0-\u9999<>\&]/gim, function(i) {
		return '&#' + i.charCodeAt(0) + ';';
	});
}