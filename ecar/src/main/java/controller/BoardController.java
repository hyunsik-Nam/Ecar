package controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dao.CommentDao;
import exception.BoardException;
import exception.CommentException;
import logic.Board;
import logic.Comment;
import logic.ShopService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	@Autowired
	ShopService service;
	
	@RequestMapping("list")
	public ModelAndView list
		(Integer pageNum, String searchtype, String searchcontent,int btype,String man) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
	//	if (bbtype == null) bbtype=0;
		if(searchtype == null || searchcontent == null ||
			searchtype.trim().equals("") || searchcontent.trim().equals("")) {
			 searchtype = null;
			 searchcontent = null;
		}
		int limit = 10; //한페이지에 보여질 게시물 건수
		//검색 조건에 맞도록 등록된 게시물 건수
		int listcount = service.boardcount(btype,searchtype,searchcontent,man); //등록 게시물
		//boardlist : 화면에 출력할 게시물 목록 (최대 10 건)
		List<Board> boardlist = service.boardlist
						(pageNum,limit,searchtype,searchcontent,btype,man);
		//최대 필요한 페이지 수
		int maxpage = (int)((double)listcount/limit + 0.95);
		//화면에 표시할 페이지의 시작 번호
		int startpage = (int)((pageNum/1.0 + 0.9) -1) * 10 + 1;
		//화면에 표시할 페이지의 끝 번호
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listcount - (pageNum - 1) * limit;//화면 표시될 게시물 번호
		mav.addObject("pageNum",pageNum);
		mav.addObject("btype",btype);
		mav.addObject("man",man);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listcount",listcount);
		mav.addObject("boardlist",boardlist);
		mav.addObject("boardno",boardno);
		mav.addObject("today",
				new SimpleDateFormat("yyyyMMdd").format(new Date()));
		return mav;
	}
	
//===================== 게시판 상세보기 ======================
	@GetMapping("detail")
	public ModelAndView detail(Integer cnt,int btype,String man) {
		ModelAndView mav = new ModelAndView();
		//실행한 정보들을 저장해야할 공간이 필요하기때문에
		//제목 /내용/ 등등
		//Board board
		Board board = service.detail(cnt,btype,man);
		List<Comment> commentlist = service.commentlist(cnt, btype, man);
		service.readcntAdd(cnt); //조회수 증가
		mav.addObject("board",board);
		mav.addObject("commentlist",commentlist);
		return mav;
	}
//===================== 게시물 작성 ========================
	@GetMapping("*")
	public ModelAndView getBoard(Integer cnt,int btype,String man) {
		ModelAndView mav = new ModelAndView();
		Board board = null;
		if(cnt == null)
			board = new Board();
		else
			board = service.detail(cnt,btype,man);
		mav.addObject("board", board);
		return mav;
	}
//============= 게시물 작성의 유효성 검증 ==================
	@PostMapping("write")
	public ModelAndView write(@Valid Board board,BindingResult bresult,
			HttpServletRequest request,int btype,String man) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {//hasErrors : 입력값 오류 발생?
			mav.getModel().putAll(bresult.getModel());
		return mav;
	}
		//db에 board 객체 저장
		//최대 cnt값 + 1을 등록되는 게시물의 cnt으로 설정
		//등록 성공 : list.shop
		//등록 실패 : BoardException 예외 발생 .write.shop 등록화면
		int cnt = service.maxcnt();
		board.setCnt(++cnt);
		try {
			service.insertBoard(board,request);
		}catch(Exception e) {
			e.printStackTrace();
			throw new BoardException("등록 실패","write.shop?cnt="+board.getCnt()+"&btype="+board.getBtype()+"&man="+board.getMan());
		}
		mav.setViewName("redirect:list.shop?btype="+board.getBtype()+"&man="+board.getMan());
		return mav;
	}
//--------댓글등록
	@PostMapping("comment")
	public ModelAndView rwrite(Comment comment,BindingResult bresult,
			HttpServletRequest request,int btype,String man) {
		ModelAndView mav = new ModelAndView();
//		if(bresult.hasErrors()) {//hasErrors : 입력값 오류 발생?
//			mav.getModel().putAll(bresult.getModel());
//			return mav;
//		}
		//db에 board 객체 저장
		//최대 cnt값 + 1을 등록되는 게시물의 cnt으로 설정
		//등록 성공 : list.shop
		//등록 실패 : BoardException 예외 발생 .write.shop 등록화면
		int cnt = service.maxcomnum();
		comment.setComnum(++cnt);
		
		try {
			service.comment(comment,request);
		}catch(Exception e) {
			e.printStackTrace();
			throw new BoardException("등록 실패","detail.shop?cnt="+comment.getCnt()+"&btype="+comment.getBtype()+"&man="+comment.getMan());
		}
		mav.setViewName("redirect:detail.shop?cnt="+comment.getCnt()+"&btype="+comment.getBtype()+"&man="+comment.getMan());
		return mav;
	}
	
//================= 게시물 수정 =======================	
	@PostMapping("update")
	public ModelAndView update(@Valid Board board,BindingResult bresult,HttpServletRequest request,int btype,String man) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
		}
		Board dbboard = service.detail(board.getCnt(),board.getBtype(),board.getMan());
		if(!board.getPw().equals(dbboard.getPw())) {//비밀번호가 다를때
			throw new BoardException ("비밀번호가 틀립니다","update.shop?cnt="+board.getCnt()+"&btype="+board.getBtype());
		}
		if(board.getPw().equals(dbboard.getPw())) {//같을때
			service.updateBoard(board, request);
			mav.setViewName("redirect:detail.shop?cnt="+board.getCnt()+"&btype="+board.getBtype());
		}
		else {
			throw new BoardException ("게시물 등록 실패.","update.shop?cnt="+board.getCnt()+"&btype="+board.getBtype());
		}
		return mav;
	}
	//====================== 댓글 수정 ======================
			@PostMapping("rupdate")
			public ModelAndView rupdate(Comment comment ,
					HttpServletRequest request,int btype,String man)
				throws CommentException {
				ModelAndView mav = new ModelAndView();
				Board dbboard = service.detail(comment.getCnt(),comment.getBtype(),comment.getMan());
				try {
					service.rupdate(comment, request);
					mav.setViewName("redirect:detail.shop?cnt="+comment.getCnt()+"&btype="+comment.getBtype()+"&man="+comment.getMan());
				}catch(Exception e) {
					e.printStackTrace();
					throw new CommentException
					("댓글 수정 실패","detail.shop?cnt="+comment.getCnt()+"&btype="+comment.getBtype()+"&man="+comment.getMan());
					
				}
				return mav;
			}
//==================== 게시물 삭제 ===================
	@PostMapping("delete")
	public ModelAndView delete(Board board, BindingResult bresult,
			HttpServletRequest request,int btype,String man) {
		ModelAndView mav = new ModelAndView();
		Board dbboard = service.detail(board.getCnt(),board.getBtype(),board.getMan());
		if(!board.getPw().equals(dbboard.getPw())) {//비밀번호가 다를때
			bresult.reject("error.login.password");//글로벌 오류
			return mav;
		}
		else {
		try {
			service.deleteBoard(board, request);
			mav.setViewName("redirect:list.shop?cnt="+board.getCnt()+"&btype="+board.getBtype());
		}catch(Exception e) {
			e.printStackTrace();
			throw new BoardException
			("게시물 삭제 실패","delete.shop?cnt="+board.getCnt()+"&btype="+board.getBtype());
		}
		}
		return mav;
	}
	//====================== 댓글 삭제 ======================
		@PostMapping("rdelete")
		public ModelAndView rdelete(Comment comment, BindingResult bresult,
				HttpServletRequest request,int btype,String man) throws CommentException {
			ModelAndView mav = new ModelAndView();
			Board dbboard = service.detail(comment.getCnt(),comment.getBtype(),comment.getMan());
			try {
				service.rdelete(comment, request);
				mav.setViewName("redirect:detail.shop?cnt="+comment.getCnt()+"&btype="+comment.getBtype());
			}catch(Exception e) {
				e.printStackTrace();
				throw new CommentException
				("댓글 삭제 실패","detail.shop?cnt="+comment.getCnt()+"&btype="+comment.getBtype());
				
			}
			return mav;
		}
//====================== 이미지 CKEDIT로 업로드 =====================
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload,
		String CKEditorFuncNum, HttpServletRequest request, Model model) {
		String path=request.getServletContext().getRealPath("/")
				+ "board/imgfile/";
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		if(!upload.isEmpty()) {
			File file = new File(path, upload.getOriginalFilename());
			try {
				upload.transferTo(file); //업로드된 내용을 파일에 저장
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		String fileName = request.getContextPath() +
				"/board/imgfile/" + upload.getOriginalFilename(); //절대 경로로 지정
		model.addAttribute("fileName",fileName);
		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
		return "ckedit"; 
	}

}
