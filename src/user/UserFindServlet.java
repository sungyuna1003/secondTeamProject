package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/user/UserFindServlet")
public class UserFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String SessionUserID = (String) session.getAttribute("userID");
		String userID = request.getParameter("userID");
		if(userID == null || userID.equals("") ) {
			response.getWriter().write("-1");//오류메시지
		}else if(new UserDAO().registerCheck(userID)==0){
				try {
					response.getWriter().write(find(userID));
				} catch (IOException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
					response.getWriter().write("-1");//오류메시지
				}
			} else {
			response.getWriter().write("-1");//오류메시지
		}
 }//post
	public String find(String userID) throws Exception{
		StringBuffer result = new StringBuffer("");
		result.append("{\"userProfile\":\""  + new UserDAO().getProfile(userID) + "\"}");
		return result.toString();
	}
}//class
