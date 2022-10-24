package dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;

import vo.ArticleVO;
import vo.CalendarVO;

public class CalendarDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<CalendarVO> getCalendar(String mid) {
		List<CalendarVO> calendar = sqlSession.selectList("c.calendarList", mid);
		return calendar;
	}

	public int insert(CalendarVO vo) {

		int res = sqlSession.insert("c.calendar_insert", vo);
		return res;
	}

	public int update(CalendarVO vo) {

		int res = sqlSession.update("c.calendar_update", vo);
		return res;
	}

	public CalendarVO selectOne(int CALENDAR_NO) {

		CalendarVO vo = sqlSession.selectOne("c.calendar_one", CALENDAR_NO);
		return vo;
	}
	
	public int delete(int CALENDAR_NO)
	{
		int res = sqlSession.delete("c.calendar_delete",CALENDAR_NO);
		return res;
	}
}
