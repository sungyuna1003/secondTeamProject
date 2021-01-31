package chat;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDAO;
import user.UserDTO;

@WebServlet("/chat/chat")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		String toID = request.getParameter("toID");
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = new UserDTO();
		String fromProfile = userDAO.getProfile(userID);
		String toProfile = userDAO.getProfile(toID);
		userDTO = userDAO.getUser(userID);
		request.setAttribute("userDTO",userDTO);
		request.setAttribute("toID",toID);
		request.setAttribute("fromProfile",fromProfile);
		request.setAttribute("toProfile",toProfile);
		request
		.getRequestDispatcher("../chat/chat.jsp")
		.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
	}

}
