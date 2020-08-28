<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	var historyBack = '${historyBack}' == 'true';
	var alertMsg = '${alertMsg}'.trim();
	if (alertMsg) {
		alert(alertMsg);
	}
	var alertMsg2 = '${alertMsg2}'.trim();
	if (alertMsg2) {
		alert(alertMsg2);
	}
	if (historyBack) {
		history.back();
	}
	var redirectUri = '${redirectUri}'.trim();
	if (redirectUri) {
		location.replace(redirectUri);
	}


	
</script>