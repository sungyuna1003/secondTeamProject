package apiIntern;

import java.io.IOException;
import java.util.Vector;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class ApiMgr {
	
	/*
	authKey	String	Y	인증키
	returnType	String	Y	xml 를 반드시 지정합니다.
	startPage	Number	Y	기본값 1, 최대 1000 검색 시작위치를 지정할 수 있습니다.
	최대 1000 까지 가능합니다.
	display	Number	Y	출력건수, 기본값 10, 최대 100 까지 가능합니다.
	region	String	 	근무지역코드를 입력합니다.
	근무지역코드 보기
	occupation	String	 	직종코드를 입력합니다.
	직종코드 보기
	education	String	 	
	학력 코드를 입력합니다.
	00 학력무관
	01 초졸이하
	02 중졸
	03 고졸
	04 대졸(2~3년)
	05 대졸(4년)
	06 석사
	07 박사
	keyword	String	 	사업장명을 입력합니다.
	applyDtStdt	String	 	신청일자 시작일
	applyDtEndt	String	 	신청일자 마감일
	*/
	
	//기본 api 주소 세팅
	public Vector<ApiDataBean> ApiMgr(){
		
	Vector<ApiDataBean> vlist = new Vector<ApiDataBean>();
	//WNKJ18EWYUPN9WJQWH23D2VR1HK
	//피상할 URL
	String url = "http://openapi.work.go.kr/opi/internInfo/internApi.do?authKey=WNKJ18EWYUPN9WJQWH23D2VR1HK&returnType=XML&startPage=1&display=10";

	//페이지에 접글해줄 다큐먼트 객체
	//파싱 요소를 읽어들임
	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder dBuilder;
	try {
		dBuilder = dbFactory.newDocumentBuilder();
		Document doc;
		try {
			doc = dBuilder.parse(url);

			
			// root tag
			doc.getDocumentElement().normalize();
			System.out.println("Root element: "+doc.getDocumentElement().getNodeName());
			
			// root element: result
			
			//파싱할 상위tag
			NodeList nList = doc.getElementsByTagName("internWantedList");
			System.out.println("파싱할 리스트 수 : "+nList.getLength());
			
			//상위tag 갯수만큼 반복 // 하위tag 선별
			for(int temp = 0; temp < nList.getLength(); temp++){		
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					//System.out.println(eElement.getTextContent());
					ApiDataBean Abean = new ApiDataBean();
					Abean.setCompanyNm(getTageValue("companyNm", eElement));
					Abean.setCollectJobsNm(getTageValue("collectJobsNm", eElement));
					Abean.setRegionNm(getTageValue("regionNm", eElement));
					Abean.setMinEdubg(getTageValue("minEdubg", eElement));
					Abean.setCollectPsncnt(getTageValue("collectPsncnt", eElement));
					
					vlist.addElement(Abean);
					
				}	// for end 
			}	// if end
		} catch (SAXException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	} catch (ParserConfigurationException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	return vlist;
	
	}
	
	//매개변수로 주소 입력
	public Vector<ApiDataBean> ApiMgr(String Url){
		
		Vector<ApiDataBean> vlist = new Vector<ApiDataBean>();
		
		//피상할 URL
		String url = Url;
		
		//페이지에 접글해줄 다큐먼트 객체
		//파싱 요소를 읽어들임
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc;
			try {
				System.out.println("----ApiMgr 실행----");
				doc = dBuilder.parse(url);
				
				// root tag
				doc.getDocumentElement().normalize();
				System.out.println("Root element: "+doc.getDocumentElement().getNodeName());
				
				// root element: result
				
				//파싱할 상위tag
				NodeList nList = doc.getElementsByTagName("internWantedList");
				System.out.println("파싱할 리스트 수 : "+nList.getLength());
				
				//토탈 tag
				String dataUrl = null;
				NodeList nodeUrl = doc.getElementsByTagName("total");
				if(nodeUrl.item(0)==null) {
					dataUrl="1";
				}else {
					dataUrl = nodeUrl.item(0).getFirstChild().getTextContent();
				}
				System.out.println("토탈 태그 개수 :"+dataUrl);
				
				for(int temp = 0; temp < nList.getLength(); temp++){		
					Node nNode = nList.item(temp);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						Element eElement = (Element) nNode;
						//System.out.println(eElement.getTextContent());
						ApiDataBean Abean = new ApiDataBean();
						Abean.setCompanyNm(getTageValue("companyNm", eElement));
						Abean.setCollectJobsNm(getTageValue("collectJobsNm", eElement));
						Abean.setRegionNm(getTageValue("regionNm", eElement));
						Abean.setMinEdubg(getTageValue("minEdubg", eElement));
						Abean.setCollectPsncnt(getTageValue("collectPsncnt", eElement));
						Abean.setDetailUrl(getTageValue("detailUrl", eElement));
						vlist.addElement(Abean);
						
					}	// for end 
				}	// if end
			} catch (SAXException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ParserConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return vlist;
		
	}
public String total(String Url){
		
		//피상할 URL
		String url = Url;
		String total = "";
		
		//페이지에 접글해줄 다큐먼트 객체
		//파싱 요소를 읽어들임
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			System.out.println("----total 실행----");
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc;
			try {
				doc = dBuilder.parse(url);
				
				// root tag
				doc.getDocumentElement().normalize();
				System.out.println("Root element: "+doc.getDocumentElement().getNodeName());
				
				// root element: result
				
				//파싱할 큰 tag
				NodeList nList = doc.getElementsByTagName("internWantedList");
				System.out.println("파싱할 리스트 수 : "+nList.getLength());
				
				//토탈 tag
				NodeList nodeUrl = doc.getElementsByTagName("total");
				if(nodeUrl.item(0)==null) {
					total="1";
				}else {
					total = nodeUrl.item(0).getFirstChild().getTextContent();
				}
				System.out.println("mgr 토탈"+total);
				
			} catch (SAXException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (ParserConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return total;
		
	}
	// 노드 검색 메소드!
	private static String getTageValue(String tag,Element eElement) {
		NodeList n1LIst = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		
		Node nValue = (Node)n1LIst.item(0);
		if(nValue == null) {
			return null;
		}
		return nValue.getNodeValue();
	}
}
