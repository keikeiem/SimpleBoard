<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.DataAccessObject" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="password" /> 
<jsp:setProperty name="user" property="name" />
<jsp:setProperty name="user" property="gender" />
<jsp:setProperty name="user" property="email" />

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>JSP SimpleBoard</title>
	</head>
	<body>
		<%		
			//라긴된 회원들은 페이지에 접속 할 수 없도록
			String userID = null;
			if (session.getAttribute("userID") != null ) {
				userID = (String) session.getAttribute("userID");
			}

			if (userID != null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인 되어있습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");	
			}

			if (user.getId() == null || user.getPassword() == null || user.getName() == null
				|| user.getGender() == null || user.getEmail() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				DataAccessObject daObject = new DataAccessObject(); //인스턴스생성
				int result = daObject.join(user);				
			
				if (result == -1) {
					// 아이디가 기본키기. 중복되면 오류.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디 입니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					//가입성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}
		%>
	</body>
</html>