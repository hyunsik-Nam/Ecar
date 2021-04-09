package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import logic.Calendar;

public interface CalendarMapper {

   final String select = " select id, cost, runt, charge, year, month, day from calendar";

   @Insert(" insert into calendar (id, cost, runt, charge, year, month, day) "
         +" values (#{id},#{cost},#{runt},#{charge},#{year},"
         + "#{month},#{day})")
   public void write(@Valid Calendar calendar);

   @Select(select + " where id=#{id}")
   public Calendar detail(@Param("id")String id);

   @Delete("delete from calendar where id=#{id} and day=#{day}")
   public void delete(Calendar calendar);
   
   @Select({"<script>",
      "select * from calendar ",
      "<if test='id != null'> where id=#{id}</if>",
      "<if test='ids != null'> where id in "
      + "<foreach collection='ids' separator=',' open='('"
      + " close=')'>#{id}</foreach></if>",
      "</script>" })
   List<Calendar> select(Object object);
   
   
}