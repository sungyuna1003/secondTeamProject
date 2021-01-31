package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/user/userRegister")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userNickName = request.getParameter("userNickName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userProfile = request.getParameter("userProfile");
		if(userID == null || userID.equals("") || userPassword1 == null||userPassword1.equals("")||
				userPassword2 == null || userPassword2.equals("") || userName == null||userName.equals("")||
						userAge == null || userAge.equals("") || userGender == null||userGender.equals("")||
								userEmail == null || userEmail.equals("")) {
			request.getSession().setAttribute("messageType","오류메세지");
			request.getSession().setAttribute("messageContent","모든 내용을 입력하세요");
			response.sendRedirect("../join/join.jsp");
			return;
	}//비어있는지 확인if
	if(!userPassword1.equals(userPassword2)) {
		request.getSession().setAttribute("messageType","오류메세지");
		request.getSession().setAttribute("messageContent","비밀번호가 일치하지 않습니다");
		response.sendRedirect("../join/join.jsp");
		return;
	}//패스워드 재확인if
	
	//모두 통과
	int result = new UserDAO().register(userID, userPassword1, userName, userNickName ,userAge, userGender, userEmail, "");
	if(result == 1) {
		request.getSession().setAttribute("userID", userID);
		request.getSession().setAttribute("messageType","성공메세지");
		request.getSession().setAttribute("messageContent","회원가입에 성공헀습니다");
		response.sendRedirect("../main/main.jsp");
	}else {
		request.getSession().setAttribute("messageType","오류메세지");
		request.getSession().setAttribute("messageContent","이미 존재하는 회원입니다 ");
		response.sendRedirect("../join/join.jsp");
	}
 }//post
}//class
