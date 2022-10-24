<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">

		function del(f) {
			f.submit();
		}
		
		function modify(f) {
			f.submit();
			/* location.href='modity.do?idx='+f.idx.value; */
		}
		
		
		
	</script>

</head>
<body>
	<c:forEach var="vo" items="${ m_list }" varStatus="cnt">
	<c:set var="count" value="${vo.idx}" />
	<fmt:parseDate var="dateFmt" value="${vo.day}" pattern="yyyy-MM"/>
	<fmt:formatDate var="date" pattern="MM" value="${dateFmt}" />
		<c:forEach var="month" begin="1" end="12">
			<c:if test="${date == month}"> 
				<c:if test="${vo.income != null}">
				        <ul>
					       	<li>
					       		<form method="POST" action="modify.do?idx=${vo.idx}&id=${param.id}">
						       		<%-- 수입  내역 : <span class="text">${vo.content}</span><input type="hidden" name="content" class="change_text" value="${vo.content}" />
									금액 : <span class="text">${vo.income}</span><input type="hidden" name="income" class="change_text" value="${vo.income}" /> 
									날짜 : <span class="text">${vo.day}</span><input type="hidden" name="day" class="change_text" value="${vo.day}" /> 입니다.
									 --%>
									<%-- <input type="hidden" name="idx" value="${vo.idx}" />
									<input type="button" value="수정" class="change" onclick="count(this.form)" />
									<input type="hidden" value="변경완료" onclick="modify(this.form);" class="change_button" /> --%>
								<script>
									var bottom = "";
									bottom += "수입내역 : <span class='text"+${vo.idx}+" text_content"+${vo.idx}+"'>${vo.content}</span><input type='hidden' name='content' class='change_text"+${vo.idx}+"' value='${vo.content}' />"
									bottom += "금액 : <span class='text"+${vo.idx}+" text_income"+${vo.idx}+"'>${vo.income}</span><input type='hidden' name='income' class='change_text"+${vo.idx}+"' value='${vo.income}' />"
									bottom += "날짜 : <span class='text"+${vo.idx}+" text_day"+${vo.idx}+"'>${vo.day}</span><input type='hidden' name='day' class='change_text"+${vo.idx}+"' value='${vo.day}' /> 입니다."
									
									bottom += "<input type='button' value='수정' class='change"+${vo.idx}+"' onclick='count(this.form)' />"
									bottom += "<input type='hidden' value='변경완료' onclick='modify(this.form);' class='change_button"+${vo.idx}+"' />"
									bottom += "<input type='hidden' value='취소' class='change_cancel"+${vo.idx}+" change_button"+${vo.idx}+"' />"

									document.write(bottom);
								</script>
							    </form>
							    <script>
							    	$('.change'+${vo.idx}).click(function(){
										$('.change_text'+${vo.idx}).attr('type','text');
										$('.change_hidden'+${vo.idx}).attr('type','hidden');
										$('.change_button'+${vo.idx}).attr('type','button');
										$('.text'+${vo.idx}).empty();
							    	});
							    	$('.change_cancel'+${vo.idx}).click(function(){
							    		let temp_content = '${vo.content}'
								    	let temp_income = '${vo.income}'
									    let temp_day = '${vo.day}'
									    
										$('.change_text'+${vo.idx}).attr('type','hidden');
										$('.change_hidden'+${vo.idx}).attr('type','button');
										$('.change_button'+${vo.idx}).attr('type','hidden');
										$('.text_content'+${vo.idx}).append(temp_content);
										$('.text_income'+${vo.idx}).append(temp_income);
										$('.text_day'+${vo.idx}).append(temp_day);
							    	});
								</script>
									
							    <form method="POST" action="delete.do?idx=${vo.idx}&id=${param.id}">
								    <input type="hidden" name="income" value="${vo.income}" />
								    <input type="hidden" name="content" value="${vo.content}" />
								    <input type="hidden" name="idx" value="${vo.idx}" />
								    <input type="button" value="삭제" onclick="del(this.form);" />
							    </form>
							</li>
					    </ul>
				</c:if>
			</c:if>
		</c:forEach>
	</c:forEach>
	
	<hr>
	
	<c:forEach var="vo" items="${ m_list }">
	<fmt:parseDate var="dateFmt" value="${vo.day}" pattern="yyyy-MM"/>
	<fmt:formatDate var="date" pattern="MM" value="${dateFmt}" />
		<c:forEach var="month" begin="1" end="12">
			<c:if test="${date == month}">
				<c:if test="${vo.income == null}">
			        
				        <ul>
					       	<li>
					       		<form method="POST" action="modify.do?idx=${vo.idx}&id=${param.id}">
						       		<%-- 수입  내역 : <span class="text">${vo.content}</span><input type="hidden" name="content" class="change_text" value="${vo.content}" />
									금액 : <span class="text">${vo.income}</span><input type="hidden" name="income" class="change_text" value="${vo.income}" /> 
									날짜 : <span class="text">${vo.day}</span><input type="hidden" name="day" class="change_text" value="${vo.day}" /> 입니다.
									 --%>
									<%-- <input type="hidden" name="idx" value="${vo.idx}" />
									<input type="button" value="수정" class="change" onclick="count(this.form)" />
									<input type="hidden" value="변경완료" onclick="modify(this.form);" class="change_button" /> --%>
								<script>
									var bottom = "";
									bottom += "수입내역 : <span class='text"+${vo.idx}+" text_content"+${vo.idx}+"'>${vo.content}</span><input type='hidden' name='content' class='change_text"+${vo.idx}+"' value='${vo.content}' />"
									bottom += "금액 : <span class='text"+${vo.idx}+" text_expense"+${vo.idx}+"'>${vo.expense}</span><input type='hidden' name='expense' class='change_text"+${vo.idx}+"' value='${vo.expense}' />"
									bottom += "날짜 : <span class='text"+${vo.idx}+" text_day"+${vo.idx}+"'>${vo.day}</span><input type='hidden' name='day' class='change_text"+${vo.idx}+"' value='${vo.day}' /> 입니다."
									
									bottom += "<input type='hidden' name='idx' value='${vo.idx}' />"
									bottom += "<input type='button' value='수정' class='change"+${vo.idx}+"' onclick='count(this.form)' />"
									bottom += "<input type='hidden' value='변경완료' onclick='modify(this.form);' class='change_button"+${vo.idx}+"' />"
									bottom += "<input type='hidden' value='취소' class='change_cancel"+${vo.idx}+" change_button"+${vo.idx}+"' />"

									document.write(bottom);
								</script>
							    </form>
							    <script>
							    	$('.change'+${vo.idx}).click(function(){
										$('.change_text'+${vo.idx}).attr('type','text');
										$('.change_hidden'+${vo.idx}).attr('type','hidden');
										$('.change_button'+${vo.idx}).attr('type','button');
										$('.text'+${vo.idx}).empty();
							    	});
							    	$('.change_cancel'+${vo.idx}).click(function(){
							    		let temp_content = '${vo.content}'
								    	let temp_expense = '${vo.expense}'
									    let temp_day = '${vo.day}'
									    
										$('.change_text'+${vo.idx}).attr('type','hidden');
										$('.change_hidden'+${vo.idx}).attr('type','button');
										$('.change_button'+${vo.idx}).attr('type','hidden');
										$('.text_content'+${vo.idx}).append(temp_content);
										$('.text_expense'+${vo.idx}).append(temp_expense);
										$('.text_day'+${vo.idx}).append(temp_day);
							    	});
								</script>
									
							    <form method="POST" action="delete.do?idx=${vo.idx}&id=${param.id}">
								    <input type="hidden" name="expense" value="${vo.expense}" />
								    <input type="hidden" name="content" value="${vo.content}" />
								    <input type="hidden" name="idx" value="${vo.idx}" />
								    <input type="button" value="삭제" onclick="del(this.form);" />
							    </form>
							    
						    </li>
					    </ul>
					
				</c:if>
			</c:if>
		</c:forEach>
	</c:forEach>

	<hr>

		<c:set var = "total" value = "0" />
		<c:forEach var="result" items="${m_list}" varStatus="status">     
			<c:set var= "total_income" value="${total_income + result.income}"/>
			<c:set var= "total_expense" value="${total_expense + result.expense}"/>
		</c:forEach>
		
        <p class="my-header">총 수입금액: <c:out value="${total_income}"/></p>
        <p class="my-header">총 지출금액: <c:out value="${total_expense}"/></p>



</body>
</html>