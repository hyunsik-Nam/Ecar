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

public interface BoardMapper {

   final String select = " select cnt, id, title, con, file1 fileurl"
         + ", date, readcnt, btype, man, grp, grplevel, grpstep,"
         + "(SELECT COUNT(*) AS cnt FROM COMMENT WHERE comment.cnt = board.cnt) as CommentTotalCnt"
         + " from board ";
   

   @Select({"<script>",
		" select count(*) from board where btype=#{btype}",
		"<if test='searchtype !=null and searchcontent != null'> "
		+ " and ${searchtype} like '%${searchcontent}%'</if> ",
		"<if test='man != null'> and man = #{man}</if>",
		" ORDER BY date desc ",
		"</script>"})
	int count(Map<String, Object> param);

   @Select({"<script>",select,		
		"<if test='btype != null'> where btype = #{btype}</if>",
		"<if test='searchtype !=null and searchcontent != null'>"
		+ " and ${searchtype} like '%${searchcontent}%'</if>",
	//	" and btype=#{btype} and man=#{man} ",
		"<if test='cnt != null'> where cnt = #{cnt}</if>",
		"<if test='man != null'> and man = #{man}</if>",
		"<if test='limit != null'>"
		+" ORDER BY FIELD(id,'admin') DESC,grp desc, grpstep asc limit #{startrow}, #{limit}</if>",
		"</script>"})
	List<Board> select(Map<String, Object> param);

   @Select(select +" where cnt=#{cnt} and btype=#{btype}")
   //Board detail(Map<Integer, Integer> param);
   Board detail(@Param("cnt")int cnt, @Param("btype")int btype, @Param("man")String man);

   @Update("update board set readcnt = readcnt + 1 where cnt=#{cnt}")
   void readcnt(int cnt);     

   @Select("select ifnull(max(cnt),0) from board")
   int maxcnt();

   @Insert(" insert into board (cnt,id,title,con,file1,"
         + " date,readcnt,btype,man,grp,grplevel,grpstep)"
         +" values (#{cnt},#{id},#{title},#{con},#{fileurl},"
         + " now(),0,#{btype},#{man},#{grp},#{grplevel},#{grpstep} )")
   void write(@Valid Board board);

   @Update(" update board set "
         + " id=#{id},title=#{title},"
         + " con=#{con},file1=#{fileurl},man=#{man} where cnt=#{cnt} and btype=#{btype}")
   void update(Board board);

   @Delete("delete from board where cnt=#{cnt}")
   void delete(Board board);
   
   @Update("update board set grpstep = grpstep + 1"
         + " where grp =#{grp} and grpstep > #{grpstep}")
   void updateGrpStep(Board board);
   
   public void updateReplyCnt(@Param("cnt")int cnt, @Param("amount") int amount);
}