package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user"
				+"(id, name, pw, email, loc)"
				+" values (#{id},#{name},#{pw},#{email}, #{loc})")
	void insert(User user);

	@Select({"<script>",
			"select * from user ",
			"<if test='id != null'> where id=#{id}</if>",
			"<if test='ids != null'> where id in "
			+ "<foreach collection='ids' separator=',' open='('"
			+ " close=')'>#{id}</foreach></if>",
			"</script>" })
	List<User> select(Map<String, Object> param);

	@Update("update user set name=#{name}, pw=#{pw}, email=#{email}, loc=#{loc}"
			+ " where id=#{id}")
	void update(User user);

	@Delete("delete from user where id=#{id}")
	void delete(String id);

	@Select({"<script>",
			"select ${col} from user ",
			"<trim prefix='where' prefixOverrides='AND || OR'>"
			+ "<if test='id != null'>and id=#{id}</if>"
			+ "and email=#{email} </trim>",
			"</script>"})
	String search(Map<String, Object> param);

	@Update("update user set pw=#{pw} where id=#{id}")
	void passwordUpdate(Map<String, Object> param);

}
