<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>

<%
	// controller
	
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	if (request.getParameter("subjectNo") == null
	|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp");
		return;
	}
	
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	// 입력값 유효성 검사
	String msg = "";
	if (request.getParameter("subjectName") == null
	|| request.getParameter("subjectName").equals("")
	|| request.getParameter("subjectTime") == null
	|| request.getParameter("subjectTime").equals("")) {
		msg = URLEncoder.encode("모든 값을 입력해주세요.", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/subject/modifySubject.jsp?subjectNo=" + subjectNo + "&msg=" + msg);
		return;
	}
	
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	System.out.println(subjectNo + " <-- subjectNo(modifySubjectAction)");
	System.out.println(subjectName + " <-- subjectName(modifySubjectAction)");
	System.out.println(subjectTime + " <-- subjectTime(modifySubjectAction)");
	
	// model
	SubjectDao subDao = new SubjectDao();
	
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo); // update문에서 subject_no=? 조건 사용
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	
	int row = subDao.updateSubject(subject);
	System.out.println(row + " <-- row(modifySubjectAction)");
	
	if (row == 1) {
		System.out.println("수정 성공");
		msg = URLEncoder.encode("과목 정보가 변경되었습니다.", "UTF-8"); 
	} else {
		System.out.println("수정 실패");
		msg = URLEncoder.encode("과목 정보 변경에 실패했습니다.", "UTF-8");
	}
	
	// 과목 정보 수정 여부 관계없이 메시지와 함께 메인 페이지로 이동
	response.sendRedirect(request.getContextPath() + "/subject/subjectList.jsp?msg=" + msg);
	
	System.out.println("=============modifySubjectAction=============");
%>