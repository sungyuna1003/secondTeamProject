package chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ChatDAO {
		DataSource dataSource;
	public ChatDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/UserChat");
		}catch (Exception e) {
		}
	}
	public ArrayList<ChatDTO> getChatListbyID(String fromID,String toID,String chatID){
		ArrayList<ChatDTO> chatList= null;
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String SQL = "SELECT * FROM CHAT WHERE ((fromID=? and toID=?) or (fromID= ? and toID =?)) and chatID >  ? order by chatTime";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+ " " + timeType + chatTime + ":" + rs.getString("chatTime").substring(14,16)+ "");
				chatList.add(chat);
			}
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	//최근 대화 몇개만 뽑기
	public ArrayList<ChatDTO> getChatListbyRecent(String fromID,String toID,int number){
		ArrayList<ChatDTO> chatList= null;
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String SQL = "SELECT * FROM CHAT WHERE ((fromID=? and toID=?) or (fromID= ? and toID =?)) and chatID >  (select max(chatID) - ? from chat where(fromID = ? and toID = ? ) or( fromID = ? and toID=?)) order by chatTime";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, number);
			pstmt.setString(6, fromID);
			pstmt.setString(7, toID);
			pstmt.setString(8, toID);
			pstmt.setString(9, fromID);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<ChatDTO>();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+ " " + timeType + chatTime + ":" + rs.getString("chatTime").substring(14,16)+ "");
				chatList.add(chat);
			}
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	//
	public ArrayList<ChatDTO> getBox(String userID){
		ArrayList<ChatDTO> chatList= null;
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String SQL = "SELECT * FROM chat WHERE chatID IN (SELECT MAX(chatID) FROM chat WHERE toID = ? or fromID= ? GROUP BY fromID, toID);";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			chatList = new ArrayList<ChatDTO>();
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChatDTO chat = new ChatDTO();
				chat.setChatID(rs.getInt("chatID"));
				chat.setFromID(rs.getString("fromID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setToID(rs.getString("toID").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				chat.setChatContent(rs.getString("chatContent").replaceAll(" ","&nbsp;").replaceAll("<","&lst;").replaceAll(">","&gt;").replaceAll("\n", "<br>"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11,13));
				String timeType = "오전";
				if(chatTime > 12) {
					timeType = "오후";
					chatTime -= 12;
				}
				chat.setChatTime(rs.getString("chatTime").substring(0,11)+ " " + timeType + chatTime + ":" + rs.getString("chatTime").substring(14,16)+ "");
				chatList.add(chat);
			}
			//결과 2개일때 최신것만
			for(int i=0; i<chatList.size(); i++) {
				ChatDTO x = chatList.get(i);
				for(int j=0; j<chatList.size(); j++) {
					ChatDTO y = chatList.get(j);
					if(x.getFromID().equals(y.getToID())&& x.getToID().equals(y.getFromID())) {
						if(x.getChatID() < y.getChatID()) {
							chatList.remove(x);
							i--;
							break;
						}else {
							chatList.remove(y);
							j--;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return chatList;
	}
	//전송 (데이터 삽입)
	public int submit(String fromID,String toID,String chatContent){
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		String SQL = "insert into chat values(null,?,?,?,now(),0)";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, chatContent);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	public int readChat(String fromID,String toID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "update chat set chatRead = 1 where (fromID = ? and toID = ?)";
		try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, toID);
				pstmt.setString(2, fromID);
				return pstmt.executeUpdate();
		} catch (Exception e) {
			
		}finally {
			try {
				if(rs != null) rs.close();
				if(conn != null) conn.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	public int getAllUnreadChat(String userID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select count(chatID) from chat where toID = ? and chatRead=0";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			return rs.getInt("count(chatID)");
			}
			//받은 메세지 없음 
			return 0;
		} catch (Exception e) {
			
		}finally {
			try {
				if(rs != null) rs.close();
				if(conn != null) conn.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//db오류
		return -1;
	}
	//읽씹 갯수
	public int getUnreadChat(String fromID,String toID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select count(chatID) from chat where toID = ? and fromID=? and chatRead=0";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, toID);
			pstmt.setString(2, fromID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			return rs.getInt("count(chatID)");
			}
			//받은 메세지 없음 
			return 0;
		} catch (Exception e) {
			
		}finally {
			try {
				if(rs != null) rs.close();
				if(conn != null) conn.close();
				if(pstmt != null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//db오류
		return -1;
	}
	
}
