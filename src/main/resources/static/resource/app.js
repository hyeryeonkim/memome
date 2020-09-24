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


function click__big() {
	$(".memo-table-box").removeClass("memo-table-box-none");
	$(".onclick-list-big").removeClass("onclick-list-big-block");
	$(".onclick-list-small").removeClass("onclick-list-small-none");
	$(".memo-table-list").removeClass("memo-table-list-block");
}

function click__small() {
	$(".memo-table-box").addClass("memo-table-box-none");
	$(".onclick-list-big").addClass("onclick-list-big-block");
	$(".onclick-list-small").addClass("onclick-list-small-none");
	$(".memo-table-list").addClass("memo-table-list-block");

}
