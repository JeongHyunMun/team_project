package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.MemoDAO;
import vo.MemoVO;

@Controller
public class MemoController {
	
	@Autowired
	ServletContext application;
	
	@Autowired
	HttpServletRequest request;
	
	
	MemoDAO memo_dao;
	public void setMemo_dao(MemoDAO memo_dao) {
		this.memo_dao = memo_dao;
	}
	
	//메모 컨트롤러 
	@RequestMapping("/memo_list.do")
	public String list( Model model, String id) {
		// 방명록 조회를 위한 dao의 메서드 호출
		
		List<MemoVO> list = memo_dao.selectList(id);
		//System.out.println("gfggg");
		model.addAttribute("list", list); //바인딩
		
		return "/WEB-INF/views/memo/memo_list.jsp";  // 포워딩
	}
	
	
	//삭제메서드
	@RequestMapping("/memo_delete.do")
	@ResponseBody //return값을 jsp등으로 인식하지 않고, 콜백메서드로 전달하기 위한 키워드
	public String delete(int idx, String filename){
		int res = memo_dao.delete(idx);
		
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		
		String result = "no";
		if(res == 1) {
			result = "yes";
			File f = new File(savePath, filename);
			
			if ( f.exists() ) {
				f.delete(); //file클래스 경로의 파일을 제거
			}
		}
		//@ResponseBody가 적용되어 있으므로
		//result에 no 또는 yes 데이터는 콜백메서드로 돌아간다
		return result;
	}
	
	@RequestMapping("/memo_insert_form.do")
	public String memo_insert_form(MemoVO vo, String id) {
		vo.setId(id);
		return "/WEB-INF/views/memo/memo_insert_form.jsp?id="+vo.getId();
	}
	
	
	
	@RequestMapping("/memo_insert.do")
	public String insert(MemoVO vo, String id) {
		
		//사진을 업로드할 절대경로를 지정
		String webPath = "/resources/upload/";
		String savePath = application.getRealPath(webPath);
		System.out.println("절대경로 "  + savePath);
		
		MultipartFile photo = vo.getPhoto();
		
		String filename = "no_file";
		
		// 업로드 된 파일이 존재한다면
		if ( !photo.isEmpty() ) {
			// 업로드될 파일의 파일명
			filename = photo.getOriginalFilename();
			
			
			//파일을 저장할 경로 
			File saveFile = new File(savePath, filename);
			
			if ( !saveFile.exists() ) {
				saveFile.mkdirs();
			} else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s",time, filename);
				saveFile = new File(savePath, filename);
			}
			// 업로드된 파일은 임시저장소에서 일정시간이 지나면 사라지는데,
			// 현재 내가 지정한 upload 폴더까지 경로로 사라지지 않도록 파일을 복사하는 메서드
			try {
				photo.transferTo(saveFile);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		vo.setId(id);
		vo.setFilename(filename);
		
		int res = memo_dao.insert(vo);
		
		// sendRedirect("list.do");
		return "redirect:memo_list.do?id="+vo.getId(); //list.do 매핑을 호출하는 방법
	}

	//글 수정 폼으로 이동
	@RequestMapping("/memo_modify_form.do")
	public String modify_form( Model model, int idx, String id ) {
		
		MemoVO vo = memo_dao.selectOne(idx);
		vo.setId(id);
		
		if ( vo != null ) {
			model.addAttribute("vo", vo);
		}
		
		return "/WEB-INF/views/memo/memo_modify_form.jsp?id="+ vo.getId();
	}
	
	//게시글 수정
	@RequestMapping("/memo_modify.do")
	public String modify(MemoVO vo, String id) {
		vo.setId(id);
		int res = memo_dao.update(vo);
		return "redirect:memo_list.do?id="+ vo.getId();
	}
	
	//메모 컨트롤러
	
	
	//게시글 상세보기
	@RequestMapping("/view.do")
	public String view(Model model, int idx) {

		//상세보기를 위한 게시물 한건 조회
		MemoVO vo = memo_dao.selectOne(idx);
		model.addAttribute("vo", vo);

		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");

		return "memo_view.jsp";

	}
}
