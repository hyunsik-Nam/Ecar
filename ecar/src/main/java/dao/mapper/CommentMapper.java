package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;
import logic.Comment;

public interface CommentMapper {
	
	final String select = " select comnum, content, up, pw, cnt, id "
			+ " from comment ";

	@Insert(" insert into comment (comnum, cnt, id ,pw, content, up,btype,man)"
			+ " values (#{comnum}, #{cnt}, #{id}, #{pw}, #{content} ,now(),#{btype},#{man})")
	void write(Comment comment);

	@Select("SELECT ifnull(MAX(comnum),0) FROM comment")
    int maxcomnum();
	

	@Select({"<script>",
		"select count(*) from comment",
		"<if test='cnt != null and btype != null and man != null'>where cnt=#{cnt} and btype=#{btype} and man=#{man}</if>",
		"<if test='cnt == null and btype != null'> where btype=#{btype} and man=#{man}</if>",
		"</script>"})
	int count(Map<String, Object> param);

	
	   @Select({"<script>",
		      "select * from comment",
		      "<if test='cnt != null'> where cnt=#{cnt}</if>",
		      "<if test='btype != null'> and btype=#{btype}</if>",
		      "<if test='man != null'> and man=#{man}</if>",   
		      " ORDER BY comnum asc ",
		      "</script>"})
		   List<Comment> select(Map<String, Object> param);
	
	   @Delete("delete from comment where comnum=#{comnum} and cnt=#{cnt}")
		void rdelete(Comment comment);

		@Update(" update comment set "
				+ " content=#{content},man=#{man} where cnt=#{cnt} and btype=#{btype}")
		void rupdate(Comment comment);


}
