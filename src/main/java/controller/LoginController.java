package controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dao.ArticleDAO;
import dao.CalendarDAO;
import dao.KakaoDAO;
import dao.LoginDAO;
import vo.ArticleVO;
import vo.CalendarVO;
import vo.KakaoVO;
import vo.MemberVO;

@Controller
public class LoginController {

	LoginDAO login_dao;

	public void setLogin_dao(LoginDAO login_dao) {
		this.login_dao = login_dao;
	}

	ArticleDAO article_dao;

	public void setArticle_dao(ArticleDAO article_dao) {
		this.article_dao = article_dao;
	}

	CalendarDAO calendar_dao;

	public void setCalendar_dao(CalendarDAO calendar_dao) {
		this.calendar_dao = calendar_dao;
	}
	
	KakaoDAO kakao_dao;
	
	public void setKakao_dao(KakaoDAO kakao_dao) {
		this.kakao_dao = kakao_dao;
	}

	@RequestMapping(value = { "/", "/login_form.do" }) // 시작 페이지 로그인 폼
	public String loginForm() {
		return "/WEB-INF/views/Member/login_form.jsp";
	}

	@RequestMapping("/login.do") // 로그인 시 id와 비밀번호가 맞는지 확인 및 user 세션에 저장
	@ResponseBody
	public String loginCheck(MemberVO vo, HttpServletRequest request) {

		MemberVO baseVO = login_dao.select(vo);
		String resultStr = "";

		// id가 존재하지 않는 경우
		if (baseVO == null) {
			resultStr = "[{'res':'no_id'}, {'id':'no'}]";
			return resultStr; // no_id를 콜백메서드로 전달
		}

		// 비밀번호 불일치
		if (!baseVO.getPwd().equals(vo.getPwd())) {
			resultStr = String.format("[{'res':'no_pwd'}, {'id':'no'}]");
			return resultStr; // no_pwd를 콜백메서드로 전달
		}

		// 아이디와 비밀번호에 문제가 없다면 세션에 MemberVO 객체를 저장
		// 세션에 저장된 데이터는 현재 프로젝트의 모든 jsp에서 사용이 가능

		HttpSession session = request.getSession();
		session.setAttribute("user", baseVO);

		resultStr = String.format("[{'res':'clear'}, {'id':'%s'}]", vo.getId());
		return resultStr; // 로그인 성공시 clear를 콜백메서드로 전달

	}

	@RequestMapping("/logout.do") // 로그아웃
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		return "redirect:login_form.do";
	}

	@RequestMapping("/insert_form.do") // 회원가입 폼
	public String insert_form() {
		return "/WEB-INF/views/Member/join_form.jsp";
	}

	@RequestMapping("/insert.do") // 회원가입 시 DB에 회원가입 정보 저장
	public String insert(MemberVO vo) {

		int res = login_dao.insert(vo);
		return "/WEB-INF/views/Member/login_form.jsp";
	}

	@RequestMapping("/id_check.do") // 회원가입 시 id 중복 체크
	@ResponseBody
	public String id_check(MemberVO vo, HttpServletRequest request) {

		int baseVO = login_dao.id_check(vo);
		String resultStr = "";

		// id가 존재하는경우
		if (baseVO == 1) {
			resultStr = "no";
			return resultStr; // no를 콜백메서드로 전달
		} else if (baseVO == 0) {
			resultStr = "yes";
			return resultStr; // no를 콜백메서드로 전달
		} else {
			resultStr = "null";
			return resultStr;
		}

	}

	@RequestMapping(value = "/main", method = RequestMethod.GET) // 메인 달력
	public String checkLogin(Model model, String mid) {
		
		List<CalendarVO> list = calendar_dao.getCalendar(mid);
		model.addAttribute("list2", list);
		return "/WEB-INF/views/Member/main.jsp";
	}

	@RequestMapping("/calendarAdd.do") // 일정추가
	public String calendar_insert(CalendarVO vo, String mid) {
		vo.setCALENDAR_ID(mid);
		int res = calendar_dao.insert(vo);
		return "redirect:main.do?mid=" + vo.getCALENDAR_ID();
	}

	@RequestMapping("/calendarupdate.do") // 일정수정
	public String calendar_update(Model model, CalendarVO vo, String mid) {
		CalendarVO vo1 = calendar_dao.selectOne(vo.getCALENDAR_NO());
		vo.setCALENDAR_ID(mid);
		if (vo1 != null) {
			model.addAttribute("vo", vo1);
		}
		int res = calendar_dao.update(vo);
		return "redirect:main.do?mid=" + vo.getCALENDAR_ID();
	}

	@RequestMapping("/calendarDel.do")
	public String delete(int CALENDAR_NO, String mid, CalendarVO vo) {
		int res = calendar_dao.delete(CALENDAR_NO);
		vo.setCALENDAR_ID(mid);
		return "redirect:main.do?mid=" + vo.getCALENDAR_ID();
	}

	@RequestMapping("/Article_form.do")
	public String articleForm() {
		return "/WEB-INF/views/Member/article_form.jsp";
	}

	@RequestMapping("/article_list.do")
	public String article_list(Model model, String mid) {

		List<ArticleVO> list = article_dao.selectList(mid);
		model.addAttribute("list", list);
		return "/WEB-INF/views/Member/article_list.jsp";
	}

	@RequestMapping("/Article_insert.do")
	public String article(ArticleVO vo) {
		int res = article_dao.insert(vo);
		System.out.println(vo);
		return "redirect:main.do?mid=" + vo.getId();
	}

	
	
	
	// 카카오 소셜 로그인 컨트롤러
	@RequestMapping(value = "/getKakaoAuthUrl")
	public @ResponseBody String getKakaoAuthUrl(
			HttpServletRequest request) throws Exception {
		String reqUrl = 
				"https://kauth.kakao.com/oauth/authorize"
				+ "?client_id=e5ab1403c1fab1436e3c55918f2eb878"
				+ "&redirect_uri=http://localhost:8080/oauth_kakao"
				+ "&response_type=code";
		
		return reqUrl;
	}
	
	// 카카오 연동정보 조회
	@RequestMapping(value = "/oauth_kakao", produces = "application/text; charset=utf8")
	public String oauthKakao(
			@RequestParam(value = "code", required = false) String code
			, Model model, KakaoVO vo) throws Exception {

		System.out.println("코드" + code);
        String access_Token = getAccessToken(code);
        System.out.println("###access_Token#### : " + access_Token);
        
        
        HashMap<String, Object> userInfo = getUserInfo(access_Token);
        System.out.println("###access_Token#### : " + access_Token);
        System.out.println("###userInfo#### : " + userInfo.get("email"));
        System.out.println("###nickname#### : " + userInfo.get("nickname"));
        System.out.println("###gender#### : " + userInfo.get("gender"));
        
        //String encodedParam = URLEncoder.encode((String)userInfo.get("nickname"), "UTF-8");
        
        vo.setEmail((String)userInfo.get("email"));
        vo.setNickname((String)userInfo.get("nickname"));
        vo.setGender((String)userInfo.get("gender"));
        
        System.out.println(vo.getEmail());
        System.out.println(vo.getNickname());
        System.out.println(vo.getGender());
        
        System.out.println(userInfo);
        
        return "redirect:insert_form.do?email="+ vo.getEmail() + "&nickname=" + URLEncoder.encode(vo.getNickname(), "UTF-8") + "&gender=" + vo.getGender(); //본인 원하는 경로 설정
	}
	
    //토큰발급
	public String getAccessToken (String authorize_code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=e5ab1403c1fab1436e3c55918f2eb878");  //본인이 발급받은 key
            sb.append("&redirect_uri=http://localhost:8080/oauth_kakao");     // 본인이 설정해 놓은 경로
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }
	
    //유저정보조회
    public HashMap<String, Object> getUserInfo (String access_Token) {

        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
            
            
            userInfo.put("accessToken", access_Token);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);
            userInfo.put("gender", gender);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return userInfo;
    }
    
    // 본인인증 컨트롤러
    @RequestMapping("/phoneAuth.do")
    @ResponseBody
    public String sendSMS(@RequestParam("phone") String phone) { // 휴대폰 문자보내기
       int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성
       
       MemberVO baseVO = login_dao.memtelcheck(phone);

       String resultStr = "";
       if (baseVO == null) {
    	   login_dao.certifiedPhoneNumber(phone,randomNumber);
          resultStr = Integer.toString(randomNumber);
       }else {
          resultStr = "yes_tel";
       }

       return resultStr;
    }
}
