<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<% 
	// post 방식 인코딩 설정
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

	// SubjectDao 클래스 객체 생성 -> SQL 메소드 이용
	SubjectDao subDao = new SubjectDao();
	Subject sub = new Subject();
	sub = subDao.selectSubjectOne(subjectNo);

	System.out.println("=============removeSubject=============");	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>removeSubject</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>과목 정보 삭제</h1>
		</div>
		<form action="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp" method="post">
			<input type="hidden" name="subjectNo" value="<%=sub.getSubjectNo()%>">
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
			</table>
			<button type="submit" class="btn btn-outline-secondary">과목 정보 삭제</button>
		</form>
		</div>
	</body>
</html>