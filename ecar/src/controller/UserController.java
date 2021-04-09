package controller;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("member")
public class UserController {
   @Autowired
   private ShopService shopService;

   @GetMapping("*")
   public String user(Model model) {
      model.addAttribute(new User());
      return null;
   }

   @RequestMapping({"main","password"}) 
   public String loginCheckmain(HttpSession session) {
      return null;
   }

   @PostMapping("joinForm")
   public ModelAndView userEntry(@Valid User user, BindingResult bindResult) {
      ModelAndView mav = new ModelAndView();
      if (bindResult.hasErrors()) {
         mav.getModel().putAll(bindResult.getModel());
         bindResult.reject("error.input.user"); 
         return mav;
      }
      try {
         shopService.insertUser(user);
         mav.addObject("user", user);
      } catch (DataIntegrityViolationException e) {
         e.printStackTrace();
         bindResult.reject("error.duplicate.user"); 
         mav.getModel().putAll(bindResult.getModel());
         return mav;
      }
      mav.setViewName("redirect:login.shop");
      return mav;
   }

   @PostMapping("login")
   public ModelAndView login(@Valid User user, BindingResult bindResult, HttpSession session) {
      ModelAndView mav = new ModelAndView();

      try {
         User dbuser = shopService.selectOne(user.getId());
         if(dbuser == null) {
            bindResult.reject("error.login.id");
            mav.getModel().putAll(bindResult.getModel());
            return mav;
         }
         if (user.getPw().equals(dbuser.getPw())) { 
            session.setAttribute("loginUser", dbuser);
            mav.setViewName("redirect:../user/main.shop");
         } else { 
            bindResult.reject("error.login.pw");
            mav.getModel().putAll(bindResult.getModel());
         }
      } catch (EmptyResultDataAccessException e) { 
         bindResult.reject("error.login.id");
         mav.getModel().putAll(bindResult.getModel());
      }
      return mav;
   }

   @RequestMapping("logout")
   public ModelAndView logout(HttpSession session) { 
      session.invalidate(); 
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:login.shop");
      return mav;
   }
   
   @RequestMapping("mypage")
   public ModelAndView idCheckmypage(String id, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      User user = shopService.selectOne(id); 
      mav.addObject("user", user);
      return mav;
   }
   @GetMapping("update")
   public ModelAndView idCheckupdate(String id, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      User user = shopService.selectOne(id);
      mav.addObject("user", user);
      return mav;
   }
   
   @PostMapping("update")
   public ModelAndView update(@Valid User user, BindingResult bindResult, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      if (bindResult.hasErrors()) {
         mav.getModel().putAll(bindResult.getModel());
         bindResult.reject("error.input.user");
         return mav;
      }
      try {
         User login = (User) session.getAttribute("loginUser");
         if (user.getPw().equals(login.getPw())) { // 비밀번호가 같으면
            shopService.userUpdate(user);
            mav.setViewName("redirect:mypage.shop?id=" + user.getId());
            if (user.getId().equals(login.getId())) {
               session.setAttribute("loginUser", login);
            }
            mav.addObject("user",user);
         } else { // 비밀번호가 틀린 경우
            bindResult.reject("error.login.pw");
            mav.getModel().putAll(bindResult.getModel());
         }
      } catch (EmptyResultDataAccessException e) { 
         bindResult.reject("error.login.id");
         mav.getModel().putAll(bindResult.getModel());
      }
      return mav;
   }
   
   @GetMapping("delete") 
   public ModelAndView idCheckdelete(String id, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      User user = shopService.selectOne(id);
      mav.addObject("user", user);
      return mav;
   }

   @PostMapping("delete")
   public ModelAndView idCheckdelete(String id, HttpSession session, String pw) {
      ModelAndView mav = new ModelAndView();
      User login = (User) session.getAttribute("loginUser");

      if (id.equals("admin")) {
         throw new LoginException("관리자 탈퇴는 불가합니다.", "main.shop");
      }
      if (!pw.equals(login.getPw())) {
         throw new LoginException("탈퇴 시 비밀번호가 틀립니다.", "delete.shop?id=" + id);
      }
      try {
         shopService.UserDelete(id);
      } catch (Exception e) {
         e.printStackTrace();
         throw new LoginException("탈퇴시 오류가 발생했습니다.", "delete.shop?id=" + id);
      } // 탈퇴 이후
      if (login.getId().equals("admin")) {
         mav.setViewName("redirect:/admin/list.shop");
      } else {
         session.invalidate();
         throw new LoginException(id + "회원님의 탈퇴처리가 되었습니다.", "login.shop");
      }
      return mav;
   }
   
   @PostMapping("{url}search") //idsearch,pwsearch 같이 처리
   public ModelAndView search(User user, BindingResult bresult, @PathVariable String url) {
      ModelAndView mav = new ModelAndView();
      String code="error.id.search";
      String title = "아이디";
      
      if(url.equals("pw")) {
         code = "error.pw.search";
         title="비밀번호";
         if(user.getId()==null || user.getId().equals("")) {
            bresult.rejectValue("id", "error.required"); //message.properties 코딩해야함.
         }
      }
      if(user.getName()==null || user.getName().equals("")) {
         bresult.rejectValue("name", "error.required");
      }
      if(user.getEmail()==null || user.getEmail().equals("")) {
         bresult.rejectValue("email", "error.required");
      }
      
      if(bresult.hasErrors()) {
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      
      if(user.getId() != null && user.getId().equals(""))
         user.setId(null);
      String result = shopService.getSearch(user);
      if(result==null) {
         bresult.reject(code);
         mav.getModel().putAll(bresult.getModel());
         return mav;
      }
      mav.addObject("result",result);
      mav.addObject("title",title);
      mav.setViewName("search");
      return mav;
   }
   
   @PostMapping("password")
   public ModelAndView loginCheckpassword(@RequestParam Map<String,String> param, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      System.out.println(param);
      User loginUser=(User)session.getAttribute("loginUser");
      if(param.get("pw").equals(loginUser.getPw())) {
         try {
            shopService.userPasswordUpdate(loginUser.getId(),param.get("chgpw"));
            loginUser.setPw(param.get("chgpw"));
            mav.addObject("message",loginUser.getName()+ "님 비밀번호 변경 완료");
            mav.addObject("url","../user/main.shop");
            mav.setViewName("alert");
         } catch(Exception e) {
            throw new LoginException("비밀번호 변경시 오류가 있습니다.","password.shop");
         }
      } else {
         throw new LoginException("현재 비밀번호가 틀립니다.","password.shop");
      }
      return mav;
   }
}