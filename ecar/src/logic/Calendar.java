package logic;

public class Calendar {
   private String id;
   private int runt;
   private int cost;
   private int charge;
   private String year;
   private String month;
   private String day;
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public int getRunt() {
      return runt;
   }
   public void setRunt(int runt) {
      this.runt = runt;
   }
   public int getCost() {
      return cost;
   }
   public void setCost(int cost) {
      this.cost = cost;
   }
   public int getCharge() {
      return charge;
   }
   public void setCharge(int charge) {
      this.charge = charge;
   }
   public String getYear() {
      return year;
   }
   public void setYear(String year) {
      this.year = year;
   }
   public String getMonth() {
      return month;
   }
   public void setMonth(String month) {
      this.month = month;
   }
   public String getDay() {
      return day;
   }
   public void setDay(String day) {
      this.day = day;
   }
   @Override
   public String toString() {
      return "Calendar [id=" + id + ", runt=" + runt + ", cost=" + cost + ", charge=" + charge + ", year=" + year
            + ", month=" + month + ", day=" + day + "]";
   }
}