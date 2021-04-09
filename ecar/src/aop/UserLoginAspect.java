package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component //Aspect으로 사용하기 위핸 무조건 객체화가 필요하기때문에
@Aspect //객체화된 객체가 aop클래스로 설정
@Order(1) //순서는 1번째
public class UserLoginAspect {
   /*
    * @Around : 핵심메서드 실행 전, 후에서 userLoginCheck메서드 실행
    * execution(* controller.User*.loginCheck*(..)) 
    * =>controller 패키지의  User로 시작하는 이름을 가진 클래스의 메서드의 이름이
    *   loginCheck로 시작하는 메서드.
    * args(..,session)
    * => 메서드의 매개변수의 마지막의 매개변수가 session인 메서드
    */
   //loginCheckmain
   @Around("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
   public Object userLoginCheck(ProceedingJoinPoint joinPoint,
         HttpSession session) throws Throwable{
      //@Around라서 먼저 실행
      User loginUser = (User)session.getAttribute("loginUser");
//      if(loginUser == null) {
//         throw new LoginException("[userlogin]로그인 후 거래하세요","login.shop");
//      }
      return joinPoint.proceed();
   }
   //idcheck
   // controller.User* => *.Usercontroller 로 변경 가능
   @Around("execution(* controller.User*.idCheck*(..)) && args(id,session,..)")
   public Object idCheck(ProceedingJoinPoint joinPoint,
         String id, HttpSession session) throws Throwable{
	   
   //============== 로그인 검증 =============
    User loginUser = (User)session.getAttribute("loginUser");
    if(loginUser == null) {
         throw new LoginException("[userlogin]로그인 후 거래하세요","login.shop");
    }
    //====== 관리자가 아니면서 아이디가 다를때 ==========
    if(!loginUser.getId().equals("admin") && !id.equals(loginUser.getId()) ) {
       throw new LoginException("본인만 조회가능합니다.","main.shop");
    }
      return joinPoint.proceed();
   }
}