package logic;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.CalendarDao;
import dao.CommentDao;
import dao.UserDao;

@Service // @Component + Service ���. : Controller�� Dao�� �߰� ���� ����
public class ShopService {

	// =============회원================
	@Autowired // 자료형 기준으로 객체 주입 UserDao
	private UserDao userDao;

	public void insertUser(User user) {
		userDao.insert(user);
	}

	public User selectOne(String id) {
		return userDao.selectOne(id);
	}

	public void userUpdate(User user) {
		userDao.update(user);
	}

	public void UserDelete(String id) {
		userDao.delete(id);
	}

	public List<User> getUserlist() {
		return userDao.list();
	}

	public List<User> userList(String[] idchks) {
		return userDao.userlist(idchks);
	}

	public String getSearch(User user) {
		return userDao.search(user);
	}

	public void userPasswordUpdate(String id, String pw) {
		userDao.passwordUpdate(id, pw);

	}

	// ======================게시판====================

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private CommentDao commentDao;

	public int boardcount(int btype, String searchtype, String searchcontent, String man) {

		return boardDao.count(btype, searchtype, searchcontent, man);
	}

	public List<Board> boardlist(Integer pageNum, int limit, String searchtype, String searchcontent, int btype,
			String man) {
		return boardDao.list(pageNum, limit, searchtype, searchcontent, btype, man);
	}

	public Board detail(int cnt, int btype, String man) {
		return boardDao.detail(cnt, btype, man);
	}

	public List<Comment> commentlist(int cnt, int btype, String man) {
		return commentDao.rlist(cnt, btype, man);
	}

	public void readcntAdd(int cnt) {
		boardDao.readcntAdd(cnt);
	}

	public int maxcnt() {
		return boardDao.maxCnt();
	}

	public void insertBoard(Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "board/file/");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.write(board);
	}

	public void boardReply(Board board, HttpServletRequest request) {
		// 답글들의 grpstep항목 +1
		boardDao.updateGrpStep(board, request);
		// 답글 등록
		int max = boardDao.maxCnt();
		board.setCnt(++max);
		board.setGrplevel(board.getGrplevel() + 1);
		board.setGrpstep(board.getGrpstep() + 1);
		boardDao.write(board);
	}

	private void uploadFileCreate(MultipartFile picture, HttpServletRequest request, String path) {
		String orgFile = picture.getOriginalFilename();// 업로드된 파일의 이름
		String uploadPath = request.getServletContext().getRealPath("/") + path;
		java.io.File fpath = new java.io.File(uploadPath);
		if (!fpath.exists())
			fpath.mkdirs(); // 업로드 폴더가 없는 경우 폴더 생성
		try {
			// picture : 업로드된 파일의 내용 저장
			// transferTo : 업로드된 파일의 내용을 File로 저장.
			picture.transferTo(new File(uploadPath + orgFile));
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

//=================== 게시글 수정 ======================
	public void updateBoard(@Valid Board board, HttpServletRequest request) {
		if (board.getFile1() != null && !board.getFile1().isEmpty()) {
			uploadFileCreate(board.getFile1(), request, "board/file/");
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.update(board);
	}

//================== 게시글 삭제 ===========================
	public void deleteBoard(Board board, HttpServletRequest request) {
		boardDao.delete(board);
	}

//================ 댓글 달기 ==============================
	public void comment(Comment comment, HttpServletRequest request) {
		commentDao.write(comment);

	}

	public int maxcomnum() {
		return commentDao.maxcomnum();
	}

	// ================= 댓글 삭제 ==============================
	public void rdelete(Comment comment, HttpServletRequest request) {
		commentDao.rdelete(comment);

	}

	// ================== 댓글 수정 ============================
	public void rupdate(Comment comment, HttpServletRequest request) {
		commentDao.rupdate(comment);

	}

	public List<String> charger() {
		List<String> list = new ArrayList<String>();
		try {
			FileInputStream file = new FileInputStream("C:/charger.xlsx");
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			for (rowindex = 1; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				if (row != null) {
					// 셀의 수
					int cells = row.getPhysicalNumberOfCells();
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크
						if (cell == null) {
							continue;
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = cell.getNumericCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						if (columnindex == 1 || columnindex == 5 || columnindex == 6 || columnindex == 7)
							list.add(value);
					}

				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Map<String, String>> ecarlist() {
		List<String> list = new ArrayList<String>();
		List<String> list1 = new ArrayList<String>();
		List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();
		Map<String, String> map1 = new HashMap<String, String>();
		Map<String, String> map2 = new HashMap<String, String>();
		Map<String, String> map3 = new HashMap<String, String>();
		try {
			FileInputStream file = new FileInputStream("C:/ecarlist.xlsx");
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				if (row != null) {
					// 셀의 수
					int cells = row.getPhysicalNumberOfCells();
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크
						if (cell == null) {
							continue;
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = cell.getNumericCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						// System.out.println(rowindex+"번 행 : "+columnindex+"번 열 값은: "+value);
						if (rowindex == 0) {
							list.add(value);
						}
						if (rowindex == 1) {
							map1.put(list.get(columnindex), value);
						}
						if (rowindex == 2) {
							map2.put(list.get(columnindex), value);
						}
						if (rowindex == 3) {
							map3.put(list.get(columnindex), value);
						}

					}

				}
			}
			listmap.add(map1);
			listmap.add(map2);
			listmap.add(map3);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return listmap;
	}

	public List<String> list1() {
		List<String> list = new ArrayList<String>();
		List<String> list1 = new ArrayList<String>();
		List<Map<String, String>> listmap = new ArrayList<Map<String, String>>();
		Map<String, String> map1 = new HashMap<String, String>();
		Map<String, String> map2 = new HashMap<String, String>();
		Map<String, String> map3 = new HashMap<String, String>();
		try {
			FileInputStream file = new FileInputStream("C:/ecarlist.xlsx");
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			int rowindex = 0;
			int columnindex = 0;
			// 시트 수 (첫번째에만 존재하므로 0을 준다)
			// 만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
			XSSFSheet sheet = workbook.getSheetAt(0);
			// 행의 수
			int rows = sheet.getPhysicalNumberOfRows();
			for (rowindex = 0; rowindex < rows; rowindex++) {
				// 행을읽는다
				XSSFRow row = sheet.getRow(rowindex);
				if (row != null) {
					// 셀의 수
					int cells = row.getPhysicalNumberOfCells();
					for (columnindex = 0; columnindex <= cells; columnindex++) {
						// 셀값을 읽는다
						XSSFCell cell = row.getCell(columnindex);
						String value = "";
						// 셀이 빈값일경우를 위한 널체크
						if (cell == null) {
							continue;
						} else {
							// 타입별로 내용 읽기
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = cell.getNumericCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						// System.out.println(rowindex+"번 행 : "+columnindex+"번 열 값은: "+value);
						if (rowindex == 0) {
							list.add(value);
						}
						if (rowindex == 1) {
							map1.put(list.get(columnindex), value);
						}
						if (rowindex == 2) {
							map2.put(list.get(columnindex), value);
						}
						if (rowindex == 3) {
							map3.put(list.get(columnindex), value);
						}

					}

				}
			}
			listmap.add(map1);
			listmap.add(map2);
			listmap.add(map3);

			list1.addAll(listmap.get(0).keySet());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list1;
	}
//	============================================== 달력 =======================================
			   
			   
			   @Autowired
			   private CalendarDao calendarDao;
			   
			   public void writeCalendar(@Valid Calendar calendar, HttpServletRequest request) {
			      calendarDao.write(calendar);
			   }

			   public Calendar detail(String id) {
			      return calendarDao.detail(id);
			   }

			   public void deleteCalendar(Calendar calendar, HttpServletRequest request) {
			      calendarDao.delete(calendar);
			   }

			   public List<Calendar> getCalendarlist() {
			      return calendarDao.list();
			   }

}
