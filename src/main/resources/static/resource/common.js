function isCellphoneNo(str) {
	if ( str.substr(0, 1) != '0' ) {
		return false;
	}
	
	return isNumber(str);
}
function isNumber(n) {
	return /^-?[\d.]+(?:e-?\d+)?$/.test(n);
}