<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	// post 방식 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 요청값 유효성 확인
	if (request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	
	// 요청값 디버깅
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <-- subjectNo(removeSubject)");

	// SubDao 
	SubjectDao subDao = new SubjectDao();

	Subject sub = new Subject();
	sub = subDao.selectSubjectOne(subjectNo);
		
	System.out.println("=============modifySubject=============");	
%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modifySubject</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>과목 정보 수정</h1>
		</div>
		<%
			if (request.getParameter("msg") != null) {	
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<form action="<%=request.getContextPath()%>/subject/modifySubjectAction.jsp" method="post">
			<input type="hidden" name="subjectNo" value="<%=sub.getSubjectNo()%>">
			<table class="table table-hover">
				<tr>
					<th class="text-center">과목번호</th>
					<td><%=sub.getSubjectNo()%></td>
				</tr>
				<tr class="text-center"> 
					<th>과목이름</th>
					<td><input type="text" name="subjectName" value="<%=sub.getSubjectName()%>" class="form-control w-50"></td>
				</tr>
				<tr class="text-center">
					<th>과목 시수</th>
					<td><input type="text" name="subjectTime" value="<%=sub.getSubjectTime()%>" class="form-control w-50"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-secondary">과목 정보 수정</button>
		</form>
		</div>
	</body>
</html>