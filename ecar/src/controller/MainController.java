package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import logic.NaverNewsService;
import logic.ShopService;

@Controller
@RequestMapping("user")
public class MainController {
	@Autowired
	   private NaverNewsService nservice;
	
	@Autowired
	private ShopService service;
	@GetMapping("*")
	public String main(Model model) {
		model.addAttribute(model);
		return null;
	}
	@RequestMapping("main")
	public ModelAndView charger(@RequestParam(required = false) String keyword) {
		ModelAndView mav = new ModelAndView();
		if(keyword == null) {
	    	   mav.addObject("news", nservice.searchNews("전기자동차",3,1));
	       }
	       else if(keyword != null)
	       {
	          mav.addObject("news", nservice.searchNews(keyword,3,1));
	       }
		List<String> list = service.charger();
		List<String> list1 = service.list1();
		List<Map<String, String>> listmap = service.ecarlist();
		mav.addObject("list",list);
		mav.addObject("list1",list1);
		mav.addObject("listmap",listmap);
		return mav;
	}
}


