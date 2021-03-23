package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private ShopService shopService;
	
	@RequestMapping("list")
	public ModelAndView adminChecklist(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> userlist = shopService.getUserlist();
		mav.addObject("list", userlist);
		return mav;
	}
}
