package faq;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/faq/faqbbsAdmin")
public class bbsAdminController extends HttpServlet {
	//403 권한 없음
	//404 url 없음
	//405 메소드 없음
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String cmd = request.getParameter("cmd");
		System.out.println(cmd);
		
		//키가 같은데 값은 다르다 -> 배열로 옴
		String[] openIds = request.getParameterValues("open-id");
		String[] delIds = request.getParameterValues("del-id");
		
		int result = 0;
		CommunitiyMgr Cmgr = new CommunitiyMgr();
		
		switch (cmd) {
		case "번호리셋":
			 	Cmgr.resetCid();
					out.println("<script type='text/javascript'>");
					out.println("alert('리셋 완료')");
					out.println("location.href='../faq/bbsAdmin'");
					out.println("</script>");
			break;
		case "선택비공":
			//정수형으로 변환
			int[] ids = new int[openIds.length];
			for(int i=0; i<openIds.length; i++) {
				ids[i] = Integer.parseInt(openIds[i]);
			}
			Cmgr.NotPub(ids);
			out.println("<script type='text/javascript'>");
			out.println("alert('비공 완료')");
			out.println("location.href='../faq/bbsAdmin'");
			out.println("</script>");
			break;
		case "선택공개": 
			//정수형으로 변환
			int[] ids2 = new int[openIds.length];
			for(int i=0; i<openIds.length; i++) {
				ids2[i] = Integer.parseInt(openIds[i]);
			}
			//결과값 메소드 이용 출력
				result = Cmgr.pub(ids2);
				out.println("<script type='text/javascript'>");
				out.println("alert('공개 완료')");
				out.println("location.href='../faq/bbsAdmin'");
				out.println("</script>");
				break;
		case "선택삭제": 
				//정수형으로 변환
				int[] ids3 = new int[delIds.length];
				for(int i=0; i<delIds.length; i++) {
					ids3[i] = Integer.parseInt(delIds[i]);
				}
					//결과값 메소드 이용 출력
					result = Cmgr.removeNoticeAll(ids3);
					out.println("<script type='text/javascript'>");
					out.println("alert('삭제 완료')");
					out.println("location.href='../faq/bbsAdmin'");
					out.println("</script>");
					break;
		
			}//switch
	}//post
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String field_ = request.getParameter("f");
		String query_=request.getParameter("q");
		String page_=request.getParameter("p");
		
		//기본값 체크
		String field = "c_title";
		if(field_ != null && !field_.equals(""))
			field = field_;
		
		String query = "";
		if(query_ != null && !query_.equals(""))
			query = query_;
		
		int page = 1;
		if(page_ != null && !page_.equals(""))
			page = Integer.parseInt(page_);
		
		System.out.println("확인1: " + field);
		System.out.println("확인2: " + query);
		System.out.println("확인3: " + page);
		CommunitiyMgr Cmgr = new CommunitiyMgr();
		List<CommunityBean> list = Cmgr.getCommunityListAdmin(field,query,page);
		if(list != null && list.size()>0) {
		System.out.println("리스트 확인: " + list.get(0).getC_title());
		int count = Cmgr.getCommunityCount(field,query);
		CommunityBean bestBean = Cmgr.getBestRow();
		System.out.println("베스트 확인: " + bestBean.getC_title());
		
		request.setAttribute("list",list);
		request.setAttribute("count",count);
		request.setAttribute("bestBean",bestBean);
		
		//forward //forward(저장,출력)
		request
		.getRequestDispatcher("../faq/bbsAdmin.jsp")
		.forward(request, response);
		}else {
			response.sendRedirect("../faq/bbsAdmin.jsp");
		}
	}//get

}//class