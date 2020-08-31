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