package crawl;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Crawler {

	public static void main(String[] args) {
		
		String url = "https://search.naver.com/search.naver?query=%EC%A0%84%EA%B8%B0%EC%B0%A8&where=news&ie=utf8&sm=nws_hty";
		   String result =null;
		   
			try {
	           Connection conn = Jsoup.connect(url);
	           Document doc = conn.get();
	           
	           Elements elem = doc.select("div.api_subject_bx");
	           
	           for(Element e: elem.select("li")) {
	           	if(e.className().equals("div")) {
	           		continue;
	           	}
	           	
	           	
	           	System.out.println(e.text());
	           	result = e.text();
	           }
	           
	       } catch (IOException e) {
	           e.printStackTrace();
	       }
			
	   }
		
		
	

}
