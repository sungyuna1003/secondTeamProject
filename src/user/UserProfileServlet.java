package user;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/user/userProfile")
public class UserProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		UserDAO userDAO = new UserDAO();
		UserDTO userDTO = new UserDTO();
		userDTO = userDAO.getUser(userID);
		String profile = userDAO.getProfile(userID);
		request.setAttribute("userDTO",userDTO);
		request.setAttribute("profile",profile);
		request
		.getRequestDispatcher("../update/profileUpdate.jsp")
		.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		MultipartRequest multi = null;
		int fileMaxSize = 10 * 1024 * 1024;
		String savePath = "C:/Jsp/Job/WebContent/images/";
		File file = new File(savePath);
		if(!file.exists())//폴더가 없다면 
			file.mkdirs();
		try {
			multi = new MultipartRequest(request, savePath , fileMaxSize , "UTF-8" , new DefaultFileRenamePolicy());
		} catch (Exception e) {
			request.getSession().setAttribute("messageType","오류메세지");
			request.getSession().setAttribute("messageContent","파일 크기는 10MB를 넘을 수 없습니다");
			response.sendRedirect("../update/profileUpdate.jsp");
			return;
		}
		String userID = multi.getParameter("userID");
		HttpSession session = request.getSession();
		if(!userID.equals((String) session.getAttribute("userID"))) {
		request.getSession().setAttribute("messageType","오류메세지");
		request.getSession().setAttribute("messageContent","접근할 수 없습니다");
		response.sendRedirect("../main/main.jsp");
		return;
		}
		String fileName = "";
		file = multi.getFile("userProfile");
		
		if(file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
					if(ext.equals("jpg")||ext.equals("png")||ext.equals("gif")) {
						String prev = new UserDAO().getUser(userID).getImg();
						File prevFile = new File(savePath + "/" + prev);
						if(prevFile.exists()) {
							prevFile.delete();
						}
						fileName = file.getName();
					}else {
						if(file.exists()) {
							file.delete();
						}
						session.setAttribute("messageType", "오류 메시지");
						session.setAttribute("messageContent", "이미지 파일만 업로드 가능합니다");
						response.sendRedirect("../update/profileUpdate.jsp");
						return;
					}
					new UserDAO().profile(userID,fileName);
					session.setAttribute("messageType", "성공 메시지");
					session.setAttribute("messageContent", "성공적으로 프로필이 변경되었습니다.");
					response.sendRedirect("../update/profileUpdate.jsp");
					return;
		}
 }//post

}//class
