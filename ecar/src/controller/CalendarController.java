package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.BoardException;
import logic.Calendar;
import logic.ShopService;

@Controller
@RequestMapping("/calendar/*")
public class CalendarController {
   @Autowired
   ShopService service;
   
   @GetMapping("*")
   public String main(Model model) {
      model.addAttribute(model);
      return null;
   }
   
   @GetMapping("newCalendar")
   public ModelAndView myCalendar(String id) {
      ModelAndView mav = new ModelAndView();
      Calendar calendar = service.detail(id);
      mav.addObject("calendar", calendar);
      return mav;
   }
   
   @PostMapping("write")
   public ModelAndView write(@Valid Calendar calendar, BindingResult bresult,
         HttpServletRequest request) {
      ModelAndView mav = new ModelAndView();
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
      return mav;
   };
      try {
         service.writeCalendar(calendar, request);
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException("등록 실패","newCalendar.shop?id="+calendar.getId());
      }
      mav.setViewName("redirect:newCalendar.shop?id="+calendar.getId());
      return mav;
   }
   
   @PostMapping("delete")
   public ModelAndView delete(Calendar calendar, BindingResult bresult,
         HttpServletRequest request, String id) {
      ModelAndView mav = new ModelAndView();
      try {
         service.deleteCalendar(calendar, request);
         mav.setViewName("redirect:newCalendar.shop?id="+calendar.getId());
      }catch(Exception e) {
         e.printStackTrace();
         throw new BoardException
         ("기록 삭제 실패","delete.shop?id="+calendar.getId());
      }
      return mav;
   }
   
   @RequestMapping("list")
   public ModelAndView adminChecklist(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      List<Calendar> calendarlist = service.getCalendarlist();
      mav.addObject("list", calendarlist);
      return mav;
   }
   
}