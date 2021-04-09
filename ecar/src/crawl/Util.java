package crawl;

public class Util {
	public static String formatAid(int castNumber) {
        String aid = 
               String.format("%010d", castNumber);
        return aid;
    }
}
