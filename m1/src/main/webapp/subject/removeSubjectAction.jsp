<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// controller

	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값 유효성 확인
	// SubjectDao.java에서 설정한 delete 쿼리문에 따라 subjectNo 값만 확인
	if (request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <-- subjectNo(removeSubjectAction)");

	// model
	SubjectDao subDao = new SubjectDao();
	
	int row = subDao.deleteSubject(subjectNo);
	System.out.println(row + " <-- row(remobeSubjectAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("삭제 성공");
		msg = URLEncoder.encode("과목 정보가 삭제되었습니다.", "UTF-8"); 
	} else {
		System.out.println("삭제 실패");
		msg = URLEncoder.encode("과목 정보 삭제에 실패했습니다.", "UTF-8"); 
	}
	
	// 삭제 성공 여부 관계없이 메시지와 함께 메인 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp?msg=" + msg);

	System.out.println("=============removeSubjectAction=============");
%>