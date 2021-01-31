package faq;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/faq/faqbbs")
public class bbsController extends HttpServlet{
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
		List<CommunityBean> list = Cmgr.getCommunityList(field,query,page);
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
		.getRequestDispatcher("../faq/bbs.jsp")
		.forward(request, response);
		}else {
			response.sendRedirect("../faq/bbs.jsp");
		}
	}

}
