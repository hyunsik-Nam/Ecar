package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import logic.NaverNewsService;



@Controller
@RequestMapping("/api/*")
public class NewsController {

   @Autowired
   private NaverNewsService service;
    
    @RequestMapping("news")
    public ModelAndView news(@RequestParam(required = false) String keyword) {
       ModelAndView mav = new ModelAndView();
       if(keyword == null) {
    	   mav.addObject("news", service.searchNews("전기자동차",10,1));
       }
       else if(keyword != null)
       {
          mav.addObject("news", service.searchNews(keyword,10,1));
       }
 //      mav.setViewName("api/news");
       return mav;
    }
}