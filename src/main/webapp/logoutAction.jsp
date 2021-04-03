<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>JSP SimpleBoard</title>
	</head>
	<body>
		<%
			session.invalidate(); // 접속한 회원의 세션을 제거
		%>
		<script>	//메인으로 이동
			location.href = 'main.jsp';
		</script>
	</body>
</html>