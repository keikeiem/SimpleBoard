<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.DataAccessObject" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 
	WEB-INF/classes/user 에 안 넣으면 안되네...
	심지어 집어넣고나서 이클립스에서 리프레시 안하면 인식을 못함...
-->

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="password" />
    
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>JSP SimpleBoard</title>
	</head>
	<body>
		<%
			DataAccessObject daObject = new DataAccessObject();		
			int result = daObject.login(user.getId(), user.getPassword());
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			switch (result) {
				case 1: {
					// 정상 로그인
					script.println("location.href = 'main.jsp'");										
				} break;
				case 0: {
					// 로그인 실패
					script.println("alert('비밀번호가 틀립니다.')");
					script.println("history.back()");	
				} break;
				case -1: {
					// 아이디 없음
					script.println("alert('존재하지 않는 아이디입니다.')");
					script.println("history.back()");
				} break;
				case -2: {
					// DB 오류
					script.println("alert('DB오류가 발생했습니다.')");
					script.println("history.back()");
				} break;
				default: break;
			}
			script.println("</script>");
		%>
	</body>
</html>