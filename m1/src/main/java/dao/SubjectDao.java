package dao; // 모델 계층(Layer)

import util.*;
import java.sql.*;
import java.util.ArrayList;
import vo.*;

public class SubjectDao {
	// 모델 1
	// 1) 과목 목록
	// beginRow, rowPerPage를 입력받는 메소드
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception { 
		ArrayList<Subject> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, updatedate, createdate FROM subject LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Subject s = new Subject();
			s.setSubjectNo(rs.getInt("subjectNo"));
			s.setSubjectName(rs.getString("subjectName"));
			s.setSubjectTime(rs.getInt("subjectTime"));
			s.setCreatedate(rs.getString("createdate"));
			s.setUpdatedate(rs.getString("updatedate"));
			list.add(s);
		}
		return list;
	}
	
	// 2) 과목 추가
	// 값 가져올 때 getter 사용
	public int insertSubject(Subject subject) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "INSERT INTO subject(subject_name, subject_time, updatedate, createdate) VALUES (?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, subject.getSubjectName());
		stmt.setInt(2, subject.getSubjectTime());
		row = stmt.executeUpdate(); 
		return row;
	}
	
	// 3) 과목 삭제
	public int deleteSubject(int subjectNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "DELETE FROM subject WHERE subject_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		row = stmt.executeUpdate(); 
		return row;
	}
	
	// 4) 과목 수정
	public int updateSubject(Subject subject) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "UPDATE subject SET subject_name=?, subject_time=?, updatedate=now() WHERE subject_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, subject.getSubjectName());
		stmt.setInt(2, subject.getSubjectTime());
		stmt.setInt(3, subject.getSubjectNo());
		row = stmt.executeUpdate(); 	
		return row;
	}
	
	// 5) 과목 1개 상세정보
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, updatedate, createdate FROM subject WHERE subject_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		ResultSet rs = stmt.executeQuery();
		subject = new Subject();
		while (rs.next()) {
			subject.setSubjectNo(rs.getInt("subjectNo"));
			subject.setSubjectName(rs.getString("subjectName"));
			subject.setSubjectTime(rs.getInt("subjectTime"));
			subject.setCreatedate(rs.getString("createdate"));
			subject.setUpdatedate(rs.getString("updatedate"));
		}
		return subject;
	}
	
	// 6) 전체 과목 수(row)
	public int selectSubjectCnt() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM subject");
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			row = rs.getInt(1); // 반환할 행 1개
		}
		return row;
	}
}