package dao;

import java.util.*;
import util.*;
import java.sql.*;
import vo.*;

public class TeacherDao {
	// 교과목이 연결되지 않은 강사는 출력 X: INNER JOIN -> OUTER JOIN
	/*
	SELECT t.teacher_no teacherNo, t.teacher_id teacherID, t.teacher_name teacherName, IFNULL(GROUP_CONCAT(ts.subject_no), 'X') teacherSubjectNo, IFNULL(GROUP_CONCAT(s.subject_name), 'X') subjectName 
	FROM teacher t LEFT OUTER JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no 
	LEFT OUTER JOIN subject s ON ts.subject_no=s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?, ?";
	 */
	// 여러 테이블을 조인한 결과를 다루기 위해 HashMap 타입 사용
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherID, t.teacher_name teacherName, IFNULL(GROUP_CONCAT(ts.subject_no), 'X') teacherSubjectNo, IFNULL(GROUP_CONCAT(s.subject_name), 'X') subjectName FROM teacher t LEFT OUTER JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no LEFT OUTER JOIN subject s ON ts.subject_no=s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("teacherNo", rs.getInt("teacherNo"));
			m.put("teacherID", rs.getString("teacherID"));
			m.put("teacherName", rs.getString("teacherName"));
			m.put("teacherSubjectNo", rs.getString("teacherSubjectNo"));
			m.put("subjectName", rs.getString("subjectName"));
			list.add(m);
		}
		return list;
	}
	
	// 2) 강사 1명 상세정보
	public Teacher selectTeacherOne(int teacherNo) throws Exception {
		Teacher teacher = new Teacher();
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "SELECT teacher_no teacherNo, teacher_id teacherID, teacher_name teacherName, teacher_history teacherHistory, updatedate, createdate FROM teacher WHERE teacher_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			teacher.setTeacherNo(rs.getInt("teacherNo"));
			teacher.setTeacherID(rs.getString("teacherID"));
			teacher.setTeacherName(rs.getString("teacherName"));
			teacher.setTeacherHistory(rs.getString("teacherHistory"));
			teacher.setCreatedate(rs.getString("createdate"));
			teacher.setUpdatedate(rs.getString("updatedate"));
		}
		return teacher;
	}
	
	// 3) 강사 삭제
	public int deleteTeacher(int teacherNo) throws Exception {
		int row = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return
		String sql = "DELETE FROM teacher WHERE teacher_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 4) 강사 수정
	public int updateTeacher(Teacher teacher) throws Exception {
		int row = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // conn이 return됨
		String sql = "UPDATE teacher SET teacher_id=?, teacher_name=?, teacher_history=?, updatedate=NOW() WHERE teacher_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, teacher.getTeacherID());
		stmt.setString(2, teacher.getTeacherName());
		stmt.setString(3, teacher.getTeacherHistory());
		stmt.setInt(4, teacher.getTeacherNo());
		row = stmt.executeUpdate();
		return row;
	}
	
	// 전체 강사 수(row)
	public int selectTeacherCnt() throws Exception {
		int row = 0;
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM teacher");
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			row = rs.getInt(1); // 반환할 행 1개
		}
		return row;
	}
}