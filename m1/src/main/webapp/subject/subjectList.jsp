<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>    
    
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// SubjectDao 클래스 객체 생성 -> SQL 메소드 이용
	SubjectDao subDao = new SubjectDao();
	
	// 현재 페이지 번호
	// currentPage가 null값이 아니면서 공백값이 아닌 경우 (유효값이 있는 경우)가 아닐 시 기본 1페이지 설정
	int currentPage = 1;
	if (request.getParameter("currentPage") != null
	&& !request.getParameter("currentPage").equals("")) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage + " <-- currentPage(subjectList)");
	
	// 페이징 당 출력 행 수 
	int rowPerPage = 5;
	
	// 시작 행 번호 - 0, 5, 10
	// ... LIMIT (beginRow, rowPerPage)
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 전체 행 수 
	int totalRow = subDao.selectSubjectCnt();
	
	// 마지막 페이지 번호
	int lastPage = totalRow / rowPerPage;
	if (totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}
	
	System.out.println(totalRow + " <-- totalRow(subjectList)");
	System.out.println(lastPage + " <-- lastPage(subjectList)");
	
	// [이전] [다음] 탭 사이 출력 행 수 
	int pagePerPage = 5;
	
	// [이전] 1 2 3 4 5 [다음]
	// [이전] 6 7 8 9 10 [다음]
	// [이전] 11 12 13 14 15 [다음]	
			
	// currentPage = 1;
	// 0 * 5 + 1 = 1
	// currentPage = 2;
	// (2 - 1) / 5 * 5 + 1 = 1
	// currentPage = 3;
	// (3 - 1) / 5 * 5 + 1 = 1
	// currentPage = 9
	// (9 - 1) / 5 * 5 + 1 = 6
	
	// [이전] [다음] 탭 사이 최소, 최대값
	int minPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
	int maxPage = minPage + (pagePerPage - 1);
	
	// maxPage가 lastPage보다 클 수 없음
	if (maxPage > lastPage) {
		maxPage = lastPage;
	}
	
	// ArrayList<Subject> list 생성 후 값 추가 
	ArrayList<Subject> list = new ArrayList<>();
	list = subDao.selectSubjectListByPage(beginRow, rowPerPage);
	// System.out.println(subDao.selectSubjectListByPage(beginRow, rowPerPage));
	
	System.out.println("=============subjectList=============");
%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>subjectList</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
			<style>	/* 페이징 버튼 회색으로 설정 */
			.page-link {
			  color: #000; 
			  background-color: #fff;
			  border: 1px solid #ccc; 
			}
			
			.page-item.active .page-link {
			 z-index: 1;
			 color: #555;
			 font-weight:bold;
			 background-color: #f1f1f1;
			 border-color: #ccc;
			}
			
			.page-link:focus, .page-link:hover {
			  color: #000;
			  background-color: #fafafa; 
			  border-color: #ccc;
			}
		</style>
	</head>
	<body>
		<div class="container mt-3">
		<a href="<%= request.getContextPath()%>/teacher/teacherList.jsp" class="btn btn-outline-secondary">강사 리스트</a>
		<div class="text-center">
			<h1>과목 리스트</h1>
		</div>
		<br>
		<%
			if (request.getParameter("msg") != null) {
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		<br>
		<table class="table table-hover text-center">
			<tr>
				<th>과목 번호</th>
				<th>과목 이름</th>
				<th>과목 시수</th>
				<th>생성일자</th>
				<th>수정일자</th>
			</tr>
		<%
			for (Subject s : list) {
		%>
			<tr>
				<td><%=s.getSubjectNo()%></td>
				<td><a href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=s.getSubjectNo()%>" class="btn"><%=s.getSubjectName()%></a></td>
				<td><%=s.getSubjectTime()%></td>
				<td><%=s.getCreatedate().substring(0, 10)%></td>
				<td><%=s.getUpdatedate().substring(0, 10)%></td>
			</tr>	
		<%
			}
		%>
		</table>
		<a href="<%=request.getContextPath()%>/subject/addSubject.jsp" class="btn btn-outline-secondary">새 과목 입력</a>
		<br>
		
		<ul class="pagination justify-content-center">
		<%
			// minPage가 1보다 클 때만 [이전] 탭 출력
			if (minPage > 1) {
		%>
		
				<li class="page-item"><a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=minPage - pagePerPage%>" class="page-link">이전</a></li>
		<%
			}
		%>		
		
		<%
			// [이전] [다음] 탭 내에서 반복
			for (int i = minPage; i <= maxPage; i++) {
				if (i == currentPage) { // 현재 페이지의 번호를 진하게 표시
		%>
					<li class="page-item active"><a class="page-link"><%=i%></a></li>
		<%
				} else { // 현재 페이지가 아닌 페이지 번호는 이동 링크와 함께 표시
		%>
					<li class="page-item"><a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a></li>
		<%
				}
			}
		%>
		
		<%
			// maxPage가 lastPage보다 작은 경우에만 [다음] 탭 출력
			if (maxPage < lastPage) {
 		%>
				<li class="page-item"><a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=minPage + pagePerPage%>" class="page-link">다음</a></li>
		<%
			}
		%>
		</ul>
		</div>
	</body>
</html>