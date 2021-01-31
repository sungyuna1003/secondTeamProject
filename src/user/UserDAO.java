package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mysql.jdbc.Statement;

public class UserDAO {
	DataSource dataSource;
	public UserDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/UserChat");
		}catch (Exception e) {
		}
	}
	//회원 데이터 베이스 처리용 함수
	public int login(String uid, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT*FROM USER WHERE uid = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				//입력 pw와 db pw가 동일하다면
				if(rs.getString("pwd").equals(pwd)) {
					return 1; //로그인 성공
				}
					return 2;//비밀번호 오류
			}else {
				return 0; //해당 사용자가 존재하지 않음
			}
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	//아이디 중복 체크
	public int registerCheck(String uid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT*FROM USER WHERE uid = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()||uid.equals("")) {
				return 0; //이미 존재하는 회원
				}else {
					return 1; //가입가능 아이디
			}
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public UserDTO getUser(String uid) {
		UserDTO user = new UserDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT*FROM USER WHERE uid = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				user.setUid(uid);
				user.setPwd(rs.getString("pwd"));
				user.setName(rs.getString("name"));
				user.setNickname(rs.getString("nickname"));
				user.setBirth(rs.getString("birth"));
				user.setGender(rs.getString("gender"));
				user.setEmail(rs.getString("email"));
				user.setGrade(rs.getInt("grade"));
				user.setRid(rs.getInt("rid"));
				user.setEdit_resume(rs.getString("edit_resume"));
				user.setEdit_interview(rs.getString("edit_interview"));
				user.setCompany(rs.getString("company"));
			}
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return user;
	}
	//회원가입 시도
	public int register(String uid, String pwd,String name,String nickname,String birth,String gender,String email,String img) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "INSERT INTO USER (uid,pwd,name,nickname,birth,gender,email,img)  VALUES(?,?,?,?,?,?,?,?)";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, nickname);
			pstmt.setString(5, birth);
			pstmt.setString(6, gender);
			pstmt.setString(7, email);
			pstmt.setString(8, img);
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public int update(String uid, String pwd,String nickname,String birth,String gender,String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "update user set pwd = ? , nickname = ? ,birth = ? ,gender=?, email = ? where uid=?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, pwd);
			pstmt.setString(2, nickname);
			pstmt.setInt(3, Integer.parseInt(birth));
			pstmt.setString(4, gender);
			pstmt.setString(5, email);
			pstmt.setString(6, uid);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public int profile(String uid, String img) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String SQL = "update user set img = ? where uid=?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, img);
			pstmt.setString(2, uid);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			//오류출력
			e.printStackTrace();
		} finally {
			//sql 실행 종료
			try {
				//리소스 반납
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //db오류
	}
	public String getProfile(String uid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT img FROM USER WHERE uid = ?";
		try {
			//db 커넥션 풀 접근
			conn = dataSource.getConnection();
			pstmt= conn.prepareStatement(SQL);
			pstmt.setString(1, uid);
			rs=pstmt.executeQuery();
			//결과가 존재한다면
			if(rs.next()) {
				if(rs.getString("img").equals("")||rs.getString("img")==null) {
					//기본 아이콘 
					return "../images/icon.jpg";
				}
				return "../images/" + rs.getString("img");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				//리소스 반납
				if(rs != null) rs.close();
				if(pstmt != null)pstmt.close();
				if(conn != null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return  "../images/icon.jpg";
	}

}
