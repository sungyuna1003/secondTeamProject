package freelancer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/freewrite")
public class FreePostServlet extends HttpServlet {
	
	
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
	    
		request.setCharacterEncoding("UTF-8");
		FreelancerMgr mgr = new FreelancerMgr();

		mgr.insertFreelancer(request);
		
	
		response.sendRedirect("../job/main/main.jsp");



	
	}

}
