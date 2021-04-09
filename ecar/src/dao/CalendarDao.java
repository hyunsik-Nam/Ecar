package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CalendarMapper;
import logic.Calendar;

@Repository
public class CalendarDao {
   @Autowired
   private SqlSessionTemplate template;
   private Map<String,Object> param = new HashMap<>();
   
   public void write(@Valid Calendar calendar) {
      template.getMapper(CalendarMapper.class).write(calendar);
   }

   public Calendar detail(String id) {
      return template.getMapper(CalendarMapper.class).detail(id);
   }

   public void delete(Calendar calendar) {
      template.getMapper(CalendarMapper.class).delete(calendar);
   }

   public List<Calendar> list() {
      return template.getMapper(CalendarMapper.class).select(null);
   }
   
}