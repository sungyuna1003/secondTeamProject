package Community;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Vector;


public class CommunitiyMgr {
	
	private DBConnectionMgr pool;
	
	public CommunitiyMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//작성일자 메소드
	public String getDate() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select now()";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ""; //데이터 베이스 오류
	}
	//게시글 번호 부여 메소드
	public int getNext() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select  cid from community order by cid desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1; //데이터 베이스 오류
	}
	public int write(String c_title,String c_content,String uid_seeker,String tab,String files) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert community (cid,uid_seeker,c_title,c_content,date,available,tab,hit,files)"
					+"values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,getNext());
			pstmt.setString(2, uid_seeker);
			pstmt.setString(3, c_title);
			pstmt.setString(4, c_content);
			pstmt.setString(5, getDate());
			pstmt.setInt(6,1);
			pstmt.setString(7,tab);
			pstmt.setInt(8, 0);
			pstmt.setString(9, files);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	public Vector<CommunityBean> getList(int pageNumber){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommunityBean> vlist = new Vector<CommunityBean>();
		try {
			con = pool.getConnection();
			sql = "select * from community where cid < ? and available = 1 "
					+ "order by cid desc limit 10";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommunityBean Cbean = new CommunityBean();
				Cbean.setCid(rs.getInt(1));
				Cbean.setUid_seeker(rs.getString(2));
				Cbean.setC_title(rs.getString(3));
				Cbean.setC_content(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				Cbean.setTab(rs.getString(7));
				Cbean.setHit(rs.getInt(8));
				Cbean.setFiles(rs.getString(9));
				
				vlist.add(Cbean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public Vector<CommunityBean> getListAll(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommunityBean> vlist = new Vector<CommunityBean>();
		try {
			con = pool.getConnection();
			sql = "select * from community where available = 1 "
					+ "order by cid desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommunityBean Cbean = new CommunityBean();
				Cbean.setCid(rs.getInt(1));
				Cbean.setUid_seeker(rs.getString(2));
				Cbean.setC_title(rs.getString(3));
				Cbean.setC_content(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				Cbean.setTab(rs.getString(7));
				Cbean.setHit(rs.getInt(8));
				Cbean.setFiles(rs.getString(9));
				
				vlist.add(Cbean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//admin
	public Vector<CommunityBean> getListAdmin(int pageNumber){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommunityBean> vlist = new Vector<CommunityBean>();
		try {
			con = pool.getConnection();
			sql = "select * from community where cid < ? "
					+ "order by cid desc limit 10";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10); 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommunityBean Cbean = new CommunityBean();
				Cbean.setCid(rs.getInt(1));
				Cbean.setUid_seeker(rs.getString(2));
				Cbean.setC_title(rs.getString(3));
				Cbean.setC_content(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				Cbean.setTab(rs.getString(7));
				Cbean.setHit(rs.getInt(8));
				Cbean.setFiles(rs.getString(9));
				
				vlist.add(Cbean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//페이징 처리 메소드
	public boolean nextPage(int pageNumber) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from community where cid < ? and available = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return false;
		}
	//게시글 한개
	public CommunityBean getRow(int cid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			hit(cid);
			con = pool.getConnection();
			sql = "select * from community where cid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				CommunityBean Cbean = new CommunityBean();
				Cbean.setCid(rs.getInt(1));
				Cbean.setUid_seeker(rs.getString(2));
				Cbean.setC_title(rs.getString(3));
				Cbean.setC_content(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				Cbean.setTab(rs.getString(7));
				Cbean.setHit(rs.getInt(8));
				Cbean.setFiles(rs.getString(9));
				return Cbean;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	//게시글 한개
	public CommunityBean getBestRow() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM community ORDER BY hit DESC LIMIT 1";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				CommunityBean Cbean = new CommunityBean();
				Cbean.setCid(rs.getInt(1));
				Cbean.setUid_seeker(rs.getString(2));
				Cbean.setC_title(rs.getString(3));
				Cbean.setC_content(rs.getString(4));
				Cbean.setDate(rs.getString(5));
				Cbean.setAvailable(rs.getInt(6));
				Cbean.setTab(rs.getString(7));
				Cbean.setHit(rs.getInt(8));
				Cbean.setFiles(rs.getString(9));
				return Cbean;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	public int update(int cid,String c_title,String c_content) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update community set c_title = ?, c_content = ? where cid = ?";
			//게시글 번호는 1번부터 2번, 3, 4, ... 올라가서 마지막의 번호를 가져와서 +1 해준다
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, c_title);
			pstmt.setString(2, c_content);
			pstmt.setInt(3, cid);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	//삭제하지만 서버에는 보관!
	public int delete(int cid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update community set available = 0 where cid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cid);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	public int hit(int cid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update community set hit = hit +1 where cid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cid);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	public int alter() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "ALTER TABLE community AUTO_INCREMENT=1;";
			pstmt = con.prepareStatement(sql);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	public int setCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SET @COUNT = 0;";
			pstmt = con.prepareStatement(sql);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	public int resetCid() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			alter();
			setCount();
			
			con = pool.getConnection();
			sql = "UPDATE community SET cid = @COUNT:=@COUNT+1;";
			pstmt = con.prepareStatement(sql);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	//일괄 공개
	public int pub(int[] ids) {
		int result = 0;
		
		String params = "";
		
		//정수형 배열을 스트링으로
		for(int i=0; i<ids.length; i++) {
			params += ids[i];
			//마지막 전까지 쉼표 붙이기 ?,?,?...?,?
			if(i < ids.length-1)
				params +=",";
		}
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			alter();
			setCount();
			
			con = pool.getConnection();
			sql = "UPDATE community SET available = 1 where cid  in ("+params+")";
			pstmt = con.prepareStatement(sql);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
	//일괄 공개
	public int NotPub(int[] ids) {
		int result = 0;
		
		String params = "";
		
		//정수형 배열을 스트링으로
		for(int i=0; i<ids.length; i++) {
			params += ids[i];
			//마지막 전까지 쉼표 붙이기 ?,?,?...?,?
			if(i < ids.length-1)
				params +=",";
		}
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			alter();
			setCount();
			
			con = pool.getConnection();
			sql = "UPDATE community SET available = 0 where cid  in ("+params+")";
			pstmt = con.prepareStatement(sql);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return -1; //db오류
	}
public int removeNoticeAll(int[] ids){
		
		int result = 0;
		
		String params = "";
		
		//정수형 배열을 스트링으로
		for(int i=0; i<ids.length; i++) {
			params += ids[i];
			//마지막 전까지 쉼표 붙이기 ?,?,?...?,?
			if(i < ids.length-1)
				params +=",";
		}
		
		CommunityBean Cbean = null;
		
		String sql ="delete from community where cid  in ("+params+")";
		
		String url = "jdbc:mysql://127.0.0.1:3306/jobproject?useUnicode=true&characterEncoding=UTF-8";

		try {
			Class.forName("org.gjt.mm.mysql.Driver");
			Connection con = DriverManager.getConnection(url,"root","1234");
			Statement st = con.createStatement();
			
			result = st.executeUpdate(sql);

			st.close();
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
public List<CommunityBean> getCommunityList(String field/*title writer_id*/,String query/*A*/,int pageNumber){
	
	List<CommunityBean> vlist = new ArrayList<CommunityBean>();
	
	String sql ="SELECT n.* FROM ("
			+ "	SELECT * from community where  available = 1 AND "+field+" LIKE ? order by date desc) n "
			+ " limit ? offset ?";
	
	// 1 11 21 31 -> an = a1 + (n-1)*d // an = 1 +(page-1)*10
	// 10 20 30 40 -> page * 10
	
	String url = "jdbc:mysql://127.0.0.1:3306/jobproject?useUnicode=true&characterEncoding=EUC_KR";
	try {
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(url,"root","1234");
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1,"%"+query+"%");
		st.setInt(2, (pageNumber*10)/pageNumber); 
		st.setInt(3,((pageNumber-1)*10) );
		ResultSet rs = st.executeQuery();

		while(rs.next()) {
			CommunityBean Cbean = new CommunityBean();
			Cbean.setCid(rs.getInt(1));
			Cbean.setUid_seeker(rs.getString(2));
			Cbean.setC_title(rs.getString(3));
			Cbean.setC_content(rs.getString(4));
			Cbean.setDate(rs.getString(5).substring(0, 19));
			Cbean.setAvailable(rs.getInt(6));
			Cbean.setTab(rs.getString(7));
			Cbean.setHit(rs.getInt(8));
			Cbean.setFiles(rs.getString(9));
			
			vlist.add(Cbean);
		}

		rs.close();
		st.close();
		con.close();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return  vlist;
}
public List<CommunityBean> getCommunityListAdmin(String field/*title writer_id*/,String query/*A*/,int pageNumber){
	
	List<CommunityBean> vlist = new ArrayList<CommunityBean>();
	
	String sql ="SELECT n.* FROM ("
			+ "	SELECT * from community where  "+field+" LIKE ? order by date desc) n "
			+ " limit ? offset ?";
	
	
	String url = "jdbc:mysql://127.0.0.1:3306/jobproject?useUnicode=true&characterEncoding=EUC_KR";
	try {
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(url,"root","1234");
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1,"%"+query+"%");
		st.setInt(2, (pageNumber*10)/pageNumber); 
		st.setInt(3,((pageNumber-1)*10) );
		ResultSet rs = st.executeQuery();
		
		while(rs.next()) {
			CommunityBean Cbean = new CommunityBean();
			Cbean.setCid(rs.getInt(1));
			Cbean.setUid_seeker(rs.getString(2));
			Cbean.setC_title(rs.getString(3));
			Cbean.setC_content(rs.getString(4));
			Cbean.setDate(rs.getString(5));
			Cbean.setAvailable(rs.getInt(6));
			Cbean.setTab(rs.getString(7));
			Cbean.setHit(rs.getInt(8));
			Cbean.setFiles(rs.getString(9));
			
			vlist.add(Cbean);
		}
		
		rs.close();
		st.close();
		con.close();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	return  vlist;
}

public int getCommunityCount(String field, String query) {
	int count = 0;
	
	String sql ="SELECT COUNT(n.cid) count FROM (SELECT * from community where available = 1 AND "+field+" LIKE ?) n order by date";
	
	String url = "jdbc:mysql://127.0.0.1:3306/jobproject?useUnicode=true&characterEncoding=EUC_KR";
	
	try {
		Class.forName("org.gjt.mm.mysql.Driver");
		Connection con = DriverManager.getConnection(url,"root","1234");
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1,"%"+query+"%");
		ResultSet rs = st.executeQuery();
	
		if(rs.next()) {
		count = rs.getInt("count");
		}
		rs.close();
		st.close();
		con.close();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	return count;
}
}
