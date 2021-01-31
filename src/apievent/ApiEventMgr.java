package apievent;

import java.net.URLEncoder;
import java.util.List;
import java.util.Vector;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;



public class ApiEventMgr {
	
	private String rssFeed = "http://openapi.work.go.kr/opi/opi/opia/empEventApi.do?authKey=WNKJ18EWYUPN9WJQWH23D2VR1HK&returnType=XML&callTp=L"
			+ "&startPage=%s&display=%s&areaCd=%s";

	public Vector<EventBean> getEventlist(int nowpage, int numPerPage, String areaCd){
		Vector<EventBean> vlist = new Vector<EventBean>();
		try {

			String url = String.format(rssFeed, Integer.toString(nowpage), Integer.toString(numPerPage), areaCd);
			SAXBuilder parser = new SAXBuilder();
			parser.setIgnoringElementContentWhitespace(true);
			
			
			Document doc = parser.build(url);
			Element root = doc.getRootElement();
			String total = root.getChildTextTrim("total");
	        List<Element> list = root.getChildren("empEvent");
	        if(Integer.parseInt(total)/numPerPage < 1) {
	        	
	        	  for (int i = 0; i < Integer.parseInt(total)%numPerPage; i++) {
	      			EventBean bean = new EventBean();
	        		 Element el = list.get(i);
	  				bean.setAreaCd(el.getChildTextTrim("areaCd"));
	  				bean.setArea(el.getChildTextTrim("area"));
	  				bean.setEventNo(el.getChildTextTrim("eventNo"));
	  				bean.setEventNm(el.getChildTextTrim("eventNm"));
	  				bean.setEventTerm(el.getChildTextTrim("eventTerm"));
	  				bean.setStartDt(el.getChildTextTrim("startDt"));
	  				
	  				vlist.addElement(bean);
	  			}
	        } else {
			
	        for (int i = 0; i < numPerPage; i++) {
				EventBean bean = new EventBean();
				Element el = list.get(i);
				bean.setAreaCd(el.getChildTextTrim("areaCd"));
				bean.setArea(el.getChildTextTrim("area"));
				bean.setEventNo(el.getChildTextTrim("eventNo"));
				bean.setEventNm(el.getChildTextTrim("eventNm"));
				bean.setEventTerm(el.getChildTextTrim("eventTerm"));
				bean.setStartDt(el.getChildTextTrim("startDt"));
				
				vlist.addElement(bean);
			}
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return vlist;
	}
	
	public int gettotal(String areaCd) {
		String total = "";
		try {
			
			String url = String.format(rssFeed, "1", "10", areaCd);
			SAXBuilder parser = new SAXBuilder();
			parser.setIgnoringElementContentWhitespace(true);
			
			Document doc = parser.build(url);
			Element root = doc.getRootElement();
			total = root.getChildTextTrim("total");
			
			return Integer.parseInt(total);

		} catch (Exception e) {
			e.printStackTrace();
		} 
		return 0;
	}


}
