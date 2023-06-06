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
	System.out.println(subjectNo + " <-- subjectNo(subjectOne)");

	// subDao()
	SubjectDao subDao = new SubjectDao();
	
	Subject sub = new Subject();
	sub = subDao.selectSubjectOne(subjectNo);
	
	System.out.println("=============subjectOne=============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>subjectOne</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>과목 상세정보</h1>
		</div>
		<table class="table table-hover">
			<tr>
				<th class="text-center">과목 번호</th>
				<td><%=sub.getSubjectNo()%></td>
			</tr>
			<tr>
				<th class="text-center">과목 이름</th>
				<td><%=sub.getSubjectName()%></td>
			</tr>
			<tr>
				<th class="text-center">과목 시수</th>
				<td><%=sub.getSubjectTime()%></td>
			</tr>
			<tr>
				<th class="text-center">생성일자</th>
				<td><%=sub.getCreatedate()%></td>
			</tr>
			<tr>
				<th class="text-center">수정일자</th>
				<td><%=sub.getCreatedate()%></td>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=sub.getSubjectNo()%>" class="btn btn-outline-secondary">수정</a>
		<a href="<%=request.getContextPath()%>/subject/removeSubject.jsp?subjectNo=<%=sub.getSubjectNo()%>" class="btn btn-outline-secondary">삭제</a>
		</div>
	</body>
</html>