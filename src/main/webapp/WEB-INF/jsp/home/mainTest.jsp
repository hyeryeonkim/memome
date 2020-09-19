<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />
<%@ include file="../part/head.jspf"%>
<h1> 페이지 이동 테스트 </h1>
<div class="pc ">
<script>
setTimeout(function(){
	location.href='../home/main';
	
}, 2000);

</script>
</div>

<style>
.remove {
	display:none;
}
</style>

<%@ include file="../part/foot.jspf"%>