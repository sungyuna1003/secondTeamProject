package Community;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



@MultipartConfig(
		fileSizeThreshold = 1024*1024,
		maxFileSize = 1024*1024*5,
		maxRequestSize = 1024*1024*5*5 
		)
@WebServlet("/Community/write")
public class writeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
			System.out.println(request.getRealPath("/fileupload"));
			String SAVEFOLDER =  "C:/Jsp/Job/WebContent/images";
			String ENCODING = "UTF-8";
			int MAXSIZE = 1024*1024*10;//10MB
			
			File dir = new File(SAVEFOLDER);
			if(!dir.exists())//폴더가 없다면 
				dir.mkdirs();
		MultipartRequest multi = 
				new MultipartRequest(request, SAVEFOLDER, MAXSIZE,
						 ENCODING, new DefaultFileRenamePolicy());
		String file = multi.getFilesystemName("file");
		File f = multi.getFile("file");
		 //유효성 검사 
		//  세션 체크
		String userID = null;
		HttpSession session = request.getSession();
		CommunityBean Cbean = new CommunityBean();
		Cbean.setC_title(multi.getParameter("c_title"));
		Cbean.setC_content(multi.getParameter("c_content"));
		Cbean.setTab(multi.getParameter("tab"));
		
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		PrintWriter out = response.getWriter();
		if(userID == null){
			out.println("<script>");
			out.println("alert('로그인을 하세요')");
			out.println("location.href='../login/login.jsp'");
			out.println("</script>");
		}else{
			if(Cbean.getC_title() == null || Cbean.getC_content() == null){
				out.println("<script>");
				out.println("alert('입력이 안 된 사항이 있습니다')");
				out.println("history.back()");
				out.println("</script>");
			}else{
				CommunitiyMgr communitiyMgr = new CommunitiyMgr();
				int result = communitiyMgr.write(Cbean.getC_title(),Cbean.getC_content(),userID,Cbean.getTab(),file);
				if(result == -1){
					out.println("<script>");
					out.println("alert('글쓰기에 실패했습니다')");
					out.println("history.back()");
					out.println("</script>");
				}else {
					out.println("<script>");
					out.println("alert('글쓰기 성공')");
					out.println("location.href='bbs'");
					out.println("</script>");
				}
			}
		}
	}
	
}
