package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.User;

@Repository 
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();

	public void insert(User user) {
		template.getMapper(UserMapper.class).insert(user);
	}

	public User selectOne(String id) {
		param.clear();
		param.put("id", id);
		List<User> list = template.getMapper(UserMapper.class).select(param);
		if (list == null || list.size() == 0)
			return null;
		else
			return list.get(0);
	}

	public void update(User user) {
		template.getMapper(UserMapper.class).update(user);
	}

	public void delete(String id) {
		template.getMapper(UserMapper.class).delete(id);
	}

	public List<User> list() {
		return template.getMapper(UserMapper.class).select(null);
	}

	public List<User> userlist(String[] idchks) {
		param.clear();
		param.put("ids", idchks);
		return template.getMapper(UserMapper.class).select(param);

	}

	public void passwordUpdate(String id, String pw) {
		param.clear();
		param.put("id", id);
		param.put("pw", pw);
		template.getMapper(UserMapper.class).passwordUpdate(param);
	}

	public String search(User user) {
		param.clear();
		param.put("name", user.getName());
		param.put("email", user.getEmail());
		if (user.getId() == null) // 아이디 찾기
			param.put("col", "concat(substr(id,1,char_length(id)-2),'**')");
		else {// 비밀번호 찾기
			param.put("id", user.getId());
			param.put("col", "concat('**',substr(pw,3,char_length(pw)-2))");
		}
		return template.getMapper(UserMapper.class).search(param);
	}
}
