<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*" %>    
<%
	// controller
	
	// 과목 중복값 입력 방지 설정하기
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");

	// 입력값 유효성 확인
	// 과목 이름, 과목 시수 값 중 하나라도 null 또는 공백값이 입력되면 subjectList.jsp로 이동
	if (request.getParameter("subjectName") == null
	|| request.getParameter("subjectName").equals("")
	|| request.getParameter("subjectTime") == null
	|| request.getParameter("subjectTime").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}

	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));

	// 디버깅
	System.out.println(subjectName + " <-- subjectName(addSubjectAction)");
	System.out.println(subjectTime + " <-- subjectTime(addSubjectAction)");
	
	// model
	SubjectDao subDao = new SubjectDao();
	
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	// 쿼리 실행
	int row = subDao.insertSubject(subject);
	System.out.println(row + " <-- row(addSubjectAction)");
	
	String msg = "";
	if (row == 1) {
		System.out.println("입력 성공");
		msg = URLEncoder.encode("새 과목이 입력되었습니다.", "UTF-8"); 
	} else {
		System.out.println("입력 실패");
		msg = URLEncoder.encode("새 과목 입력에 실패했습니다.", "UTF-8"); 
	}
	
	// 입력 성공 여부 관계없이 메인 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp?msg=" + msg);
	
	System.out.println("=============addSubjectAction=============");
%>