<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	System.out.println("=============addSubject=============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addSubject</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
 		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/subject/subjectList.jsp" class="btn btn-outline-secondary">메인 화면으로</a>
		<div class="text-center">
			<h1>과목 정보 추가</h1>
		</div>
		<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
			<table class="table table-hover text-center">
				<tr>
					<th>과목 이름</th>
					<td><input type="text" name="subjectName" class="form-control w-50" placeholder="과목 이름을 입력하세요."></td>
				</tr>
				<tr>
					<th>과목 시수</th>
					<td><input type="text" name="subjectTime" class="form-control w-50" placeholder="과목 시수를 입력하세요."></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-outline-secondary">과목 정보 추가</button>
		</form>
		</div>
	</body>
</html>