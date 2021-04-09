package util;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import logic.User;

public class UserValidator implements Validator{
	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.isAssignableFrom(clazz);//유효성 검사를 위한 객체의 자료형 검증
	}
	@Override
	public void validate(Object target, Errors errors) {
		User user = (User)target;
		String group = "error.required";
		if(user.getId() == null || user.getId().length()==0) {
			errors.rejectValue("id",group); 
		}
		if(user.getPw() == null || user.getPw().length()==0) {
			errors.rejectValue("pw",group);
		}
		if(user.getName() == null || user.getName().length()==0) {
			errors.rejectValue("name",group);
		}
		if(user.getEmail() == null || user.getEmail().length()==0) {
			errors.rejectValue("email",group);
		}
		if(errors.hasErrors()) { //오류가 존재하니?
			errors.reject("error.input.user"); //글로벌 오류
		}
	}

}
