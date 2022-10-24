package dao;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import vo.CalendarVO;
import vo.MemberVO;

public class LoginDAO {
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public MemberVO select(MemberVO vo) {
		MemberVO baseVO = sqlSession.selectOne("u.id_check", vo);
		return baseVO;
	}

	public int insert(MemberVO vo) {
		int res = sqlSession.insert("u.member_insert", vo);
		return res;
	}

	public int id_check(MemberVO vo) {
		int res = sqlSession.selectOne("u.id_overlap", vo);
		return res;
	}
	
	
	   // 회원 등록 전화번호 중복 체크
	public MemberVO memtelcheck (String phone) {
		MemberVO baseVO = sqlSession.selectOne("u.member_telcheck", phone);
		return baseVO;
	}
	

	   // 인증번호 보내기
	   public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {

	      String api_key = "NCSWBNBDAGARDW6C";
	      String api_secret = "3PAUHLQAZ5BFULBCNIXKHLSSTRNKQQQ7";
	      Message coolsms = new Message(api_key, api_secret);
	      System.out.println("aasdfasdfsdf : " +userPhoneNumber);
	      // 4 params(to, from, type, text) are mandatory. must be filled
	      HashMap<String, String> params = new HashMap<String, String>();
	      params.put("to", userPhoneNumber); // 수신전화번호
	      params.put("from", "01024695903"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	      params.put("type", "SMS");
	      params.put("text", "[TEST] 인증번호는" + "[" + randomNumber + "]" + "입니다."); // 문자 내용 입력
	      params.put("app_version", "test app 1.2"); // application name and version

	      try {
	         JSONObject obj = (JSONObject) coolsms.send(params);
	         System.out.println(obj.toString());
	      } catch (CoolsmsException e) {
	         System.out.println(e.getMessage());
	         System.out.println(e.getCode());
	      }

	   }
}
