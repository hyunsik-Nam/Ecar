package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component 
@Aspect 
@Order(1) 
public class AdminLoginAspect {
					
	 @Around("execution(* controller.Admin*.*(..)) && args(..,session)")
	   public Object AdminCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable{
	      User loginUser = (User)session.getAttribute("loginUser");
	      if(loginUser == null) {//로그인이 안되어있는 경우
	    	  throw new LoginException("로그인하세요","../user/login.shop");
	      } else if(!loginUser.getId().equals("admin")) { //관리자가 아닌 경우
	         throw new LoginException("관리자가 아닙니다","../user/main.shop");
	      }
	      return joinPoint.proceed();
	   }
}
