package exception;

public class CalendarException extends Exception {
   private String url;
   public CalendarException(String msg, String url) {
      super(msg);
      this.url=url;
   }
   public String getUrl() {
      return url;
   }
}