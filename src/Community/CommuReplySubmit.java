package Community;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import chat.ChatDAO;

@WebServlet("/Community/CReplySubmit")
public class CommuReplySubmit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String uid_seeker =request.getParameter("uid_seeker");
		int cid =Integer.parseInt(request.getParameter("cid"));
		String comment_con = request.getParameter("comment");
		System.out.println(uid_seeker);
		System.out.println(cid);
		System.out.println(comment_con);
		if(uid_seeker == null || uid_seeker.equals("")){
			response.getWriter().write("0");
		}
		uid_seeker = URLDecoder.decode(uid_seeker,"UTF-8");
		comment_con = URLDecoder.decode(comment_con,"UTF-8");
		
		
		int result = new CommuReplyMgr().submit(cid, uid_seeker,comment_con + "");
		if(result == 1) {
			String result2 = Integer.toString(result);
			response.getWriter().write(result2);
		}else
		if(result == 0) {
			String result2 = Integer.toString(result);
			response.getWriter().write(result2);
		}else {
			String result2 = Integer.toString(result);
			response.getWriter().write(result2);
		}
	}

}
