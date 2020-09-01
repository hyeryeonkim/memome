// 오직 이 프로그램에서만 사용되는 자바스크립트
var $html = $('html');

var nowLoading = false;

function startLoading() {
	nowLoading = true;
	
	$html.addClass('loading-box-actived');
}

function endLoading() {
	nowLoading = false;
	
	$html.removeClass('loading-box-actived');
	
}

function isNowLoading() {
	return nowLoading;
}