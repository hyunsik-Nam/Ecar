package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;

@Controller
@RequestMapping("charger")
public class ChargerController {
	@Autowired
	private ShopService service;
	
	@GetMapping("*")
	public String charger(Model model) {
		model.addAttribute(model);
		return null;
	}
	@RequestMapping("location")
	public ModelAndView charger() {
		ModelAndView mav = new ModelAndView();
		List<String> list = service.charger();
		mav.addObject("list",list);
		return mav;
	}
}
