package logic;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import logic.News;

@Service
public class NaverNewsService {
	String clientId = "rCrZrMLemt1iSQlEOl88"; // 애플리케이션 클라이언트 아이디값"
	String clientSecret = "OC9uB8blwa"; // 애플리케이션 클라이언트 시크릿값"

	public List<News> searchNews(String keyword, int display, int start) {
		List<News> list = null;
		try {
			URL url;
			url = new URL(
					"https://openapi.naver.com/v1/search/" + "news.xml?query=" + URLEncoder.encode(keyword, "UTF-8")
							+ (display != 0 ? "&display=" + display : "") + (start != 0 ? "&start=" + start : ""));
			URLConnection urlConn = url.openConnection();
			urlConn.setRequestProperty("X-Naver-Client-Id", clientId);
			urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));

			int eventType = parser.getEventType();
			News n = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT: // 문서의 끝
					break;
				case XmlPullParser.START_DOCUMENT:
					list = new ArrayList<News>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						list.add(n);
						n = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "item":
						n = new News();
						break;
					case "title":
						if (n != null)
							n.setTitle(parser.nextText());
						break;
					case "originallink":
						if (n != null)
							n.setOriginallink(parser.nextText());
						break;
					case "link":
						if (n != null)
							n.setLink(parser.nextText());
						break;
					case "pubdate":
						if (n != null)
							n.setPubDate(parser.nextText());
						break;
					case "description":
						if (n != null)
							n.setDescription(parser.nextText());
						break;

					}

				}
				}
				eventType = parser.next();
			}

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
