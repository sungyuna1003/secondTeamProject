package Community;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import chat.ChatDAO;
import chat.ChatDTO;
import user.UserDAO;

@WebServlet("/Community/Reply")
public class CommunityReply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String userID = request.getParameter("userID");
		String cid = request.getParameter("cid");
		String listType = request.getParameter("listType");
		if(userID == null||userID.equals("")) {
			response.getWriter().write("");
		}else {
			try {
				HttpSession session = request.getSession();
				   if(!URLDecoder.decode(userID,"UTF-8").equals((String)session.getAttribute("userID"))){
					   response.getWriter().write("");
					   return;
				   }
				
				userID = URLDecoder.decode(userID,"UTF-8");
				System.out.println("리스트타입:"+listType);
				response.getWriter().write(getBox(cid,listType));
			} catch (Exception e) {
				userID = URLDecoder.decode(userID,"UTF-8");
				response.getWriter().write("");
			}
		}
	}
	public String getBox(String cid,String checkID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		CommuReplyMgr  Cmgr = new CommuReplyMgr();
		ArrayList<CommuReplyBean> ComuList = Cmgr.getComment(cid,checkID);
		System.out.println("사이즈1:"+ ComuList.size());
		if(ComuList.size()==0) return "";
		for(int i = 0 ; i <ComuList.size(); i++) {
			
			result.append("[{\"value\": \""+ ComuList.get(i).getUid_seeker() +"\"},");
			result.append("{\"value\": \""+ ComuList.get(i).getComment_con() +"\"},");
			result.append("{\"value\": \""+ ComuList.get(i).getDate() +"\"}]");
			if(i != ComuList.size()-1)  result.append(",");
		}
		result.append("], \"last\":\""+ ComuList.get(ComuList.size()-1).getComment_id()+"\"}");
		return result.toString();
	}
}
