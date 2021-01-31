package faq;


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
		// disc 보내는 로케이션 //절대경로 써야됨 -> 임시 디렉토리 사용 // 걍 설정 ㄴ 
		//location ="/tmp",
		//전송 데이터 일정량 ( 1MB ) 메모리대신 disc 이용 하라는뜻 
		fileSizeThreshold = 1024*1024,
		//하나의 파일 사이즈 제한 5MB
		maxFileSize = 1024*1024*5,
		// 전체 사이즈 25MB
		maxRequestSize = 1024*1024*5*5 
		)
@WebServlet("/faq/faqwrite")
public class writeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
			System.out.println(request.getRealPath("/fileupload"));
			String SAVEFOLDER = "C:/Users/권오현/git/Practice-github/myapp/WebContent/job/fileupload";
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
		 System.out.println(SAVEFOLDER);
		 
		 System.out.println(file);
		 System.out.println(multi.getParameter("c_title"));
		// 현재 세션 상태를 체크한다
		String userID = null;
		HttpSession session = request.getSession();
		CommunityBean Cbean = new CommunityBean();
		Cbean.setC_title(multi.getParameter("c_title"));
		Cbean.setC_content(multi.getParameter("c_content"));
		Cbean.setTab(multi.getParameter("tab"));
		
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		System.out.println(userID);
		PrintWriter out = response.getWriter();
		// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
		if(userID == null){
			out.println("<script>");
			out.println("alert('로그인을 하세요')");
			out.println("location.href='../login/login.jsp'");
			out.println("</script>");
		}else{
			// 입력이 안 된 부분이 있는지 체크한다
			if(Cbean.getC_title() == null || Cbean.getC_content() == null){
				out.println("<script>");
				out.println("alert('입력이 안 된 사항이 있습니다')");
				out.println("history.back()");
				out.println("</script>");
			}else{
				// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
				CommunitiyMgr communitiyMgr = new CommunitiyMgr();
				int result = communitiyMgr.write(Cbean.getC_title(),Cbean.getC_content(),userID,Cbean.getTab(),file);
				// 데이터베이스 오류인 경우
				if(result == -1){
					out.println("<script>");
					out.println("alert('글쓰기에 실패했습니다')");
					out.println("history.back()");
					out.println("</script>");
				// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
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
