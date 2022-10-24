<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Book</title>
    <link rel="shortcut icon" type="image/x-icon" href="SO.png">
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <link rel="stylesheet" href="style.css">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> <%-- 구글 그래프 --%>
	<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>	<%-- Ajax --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css">
	<link href="${pageContext.request.contextPath}/resources/css/cash.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript">


	/* 삭제버튼 클릭 */
	function del(f) {
		//location.href='delete.do?idx='+f.idx.value;
		f.submit();
	}//del()

	/* 저장버튼 클릭 */
	function send_income(f) {
		f.submit(); // 전송
	}
	function send_expense(f) {
		f.submit(); // 전송
	}
	
</script>
<script> // 그래프
	google.charts.load('current', {'packages':['line', 'corechart']});
	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
	
	var button = document.getElementById('change-chart');
	var chartDiv = document.getElementById('chart_div');
	
	var data = new google.visualization.DataTable();
	data.addColumn('date', 'Month');
	data.addColumn('number', "Income");
	data.addColumn('number', "Expense");
	
/* --------------------------------------------*/	
	var list = new Array();
	var income_list = new Array();
	var expense_list = new Array();
	
	<%-- 매달 총 수입 지출 내역 --%>
	<c:forEach var="month" begin="1" end="12">
	<c:forEach var="vo" items="${ m_list }" varStatus="status">
		<c:set var = "total" value = "0" />
		<fmt:parseDate var="dateFmt" value="${vo.day}" pattern="yyyy-MM"/>
		<fmt:formatDate var="date" pattern="MM" value="${dateFmt}" />
		<c:if test="${date == month}">
			<c:set var= "total_income" value="${total_income + vo.income}"/>
			<c:set var= "total_expense" value="${total_expense + vo.expense}"/>
		</c:if>
	</c:forEach>
	
	income_list.push("${total_income}");	
	expense_list.push("${total_expense}");
    
    <c:set var="total_income" value="0" />		
	<c:set var="total_expense" value="0" />		
    </c:forEach>
    <%-- 매달 총 수입 지출 내역 --%>


	for(var i=0; i<12; i++) {
		data.addRows([
			[new Date(2022, i), parseFloat(income_list[i]), parseFloat(expense_list[i])]
		]);
	}
	
	for(var i=0; i<12; i++) {
	console.log("income "+ i +" : "+ income_list[i]+ " / expense "+ i +" : " + expense_list[i]);
	}
	

/* ------------------------------------------------------------------*/		
	var materialOptions = {
	  chart: {
	    title: ''
	  },
	width: 1800,
	  height: 500,
	  series: {
	    // Gives each series an axis name that matches the Y-axis below.
	    0: {axis: 'Temps'},
	    1: {axis: ''}
	  },
	  axes: {
	    // Adds labels to each axis; they don't have to match the axis names.
	    y: {
	      Temps: {label: '금액'},
	      Daylight: {label: 'Daylight'}
	    }
	  }
	};
	
	function drawMaterialChart() {
	  var materialChart = new google.charts.Line(chartDiv);
	  materialChart.draw(data, materialOptions);
	}
	drawMaterialChart();
	}
</script>
</head>
<body>
 <!-- Navigation-->
     <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="main.do?mid=${user.id}">DIARY'S</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="main.do?mid=${user.id}">Home</a></li>
					<li class="nav-item"><a class="nav-link"  style="cursor:pointer;" onclick="location.href='memo_list.do?id=${user.id}'">메모</a></li>
                        <li class="nav-item"><a class="nav-link" href="list.do?id=${user.id}">가계부</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">공지사항</a></li>
                    </ul>
                </div>
            </div>
        </nav>
     <!-- Page Header-->
     
            <header class="py-5 bg-light border-bottom mb-4" style="background-image:url('${pageContext.request.contextPath}/resources/img/back5.jpg')">
		<div class="text-center my-5">
			<!--                     <h1 class="fw-bolder">Welcome to Blog Home!</h1>
                    <p class="lead mb-0">A Bootstrap 5 starter layout for your next blog homepage</p> -->
		</div>
		</div>
	</header>
	<div id="history_box">
	<input type= "button " id="history" class="btn btn-warning" value="history" onclick="location.href='history.do?id=${user.id}'">
	</div>

    <div id="app">
	    	<span id="title">가계부</span> <br>
		<table class="table" border="1">
			<tr id="col">
				<th>내용</th>
				<th>수입</th>
				<th>지출</th>
				<th>날짜</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="vo" items="${ m_list }">
				<fmt:parseDate var="dateFmt" value="${vo.day}" pattern="yyyy-MM"/>
				<fmt:formatDate var="date" pattern="MM" value="${dateFmt}" />
				<c:set var="now" value="<%=new java.util.Date() %>" />
				<c:set var="nowDate"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
				<c:if test="${date == nowDate}">
					<tr id="col2">
						<td>${vo.content}</td> 
						<td>${vo.income}</td>
						<td>${vo.expense}</td>
						<td>${vo.day}</td>
						<%-- <td><%=c.getWriteday(${vo.day}) %></td> --%>
						<td>
							<form method="POST" action="delete.do?idx=${vo.idx}&id=${param.id}">
								<input type="hidden" name="idx" value="${vo.idx}">	
								<!-- 꼭 idx hidden으로 가져와야 del()함수에 넣을 수 있다 -->
								<input type="button" value="삭제" onclick="del(this.form);">
							</form>
						</td>
					</tr>
				</c:if>
			</c:forEach>
		</table> 
		
		<%-- 이번달 총 수입 지출 내역 --%>
		<c:forEach var="vo" items="${ m_list }">
			<fmt:parseDate var="dateFmt" value="${vo.day}" pattern="yyyy-MM"/>
			<fmt:formatDate var="date" pattern="MM" value="${dateFmt}" />
			<c:set var="now" value="<%=new java.util.Date() %>" />
			<c:set var="nowDate"><fmt:formatDate value="${now}" pattern="MM" /></c:set>
			<c:if test="${date == nowDate}">
				<c:set var= "to_income" value="${to_income + vo.income}"/>
				<c:set var= "to_expense" value="${to_expense + vo.expense}"/>
			</c:if>
		</c:forEach>
		
        <p class="my-header">이번달 총 수입금액: <c:out value="${to_income}"/></p>
        <p class="my-header">이번달 총 지출금액: <c:out value="${to_expense}"/></p>
        <%-- 이번달 총 수입 지출 내역 --%>
        

	
	        <!-- insert -->
	     	<div id="add">
		     	<form class="f1" method="POST" action="insert_income.do?id=${user.id}">
			소득: <input type="text" name="content" placeholder="내용" id="cont_1" v-model.trim="addText_1">
			     <input type="text" name="income" placeholder="금액" v-model.number="income" v-on:keyup.enter="fixIncome">
			    <%--  <input type="hidden" name="id" value="${user.id}"> --%>
			     <input type="button" value="추가" onclick="send_income(this.form);" v-on:click="fixIncome">
		        </form>
	        
	        
	        <form class="f1" method="POST" action="insert_income.do?id=${param.id}">
		        지출: <input type="text" name="content" placeholder="내용" id="cont" v-model.trim="addText">
		        <input type="text" name="expense" placeholder="금액" v-model.number="addPrice" v-on:keyup.enter="addList">
			    <%--  <input type="hidden" name="id" value="${user.id}"> --%>
		        <input type="button" value="추가" onclick="send_income(this.form);" v-on:click="addList">
	        </form>
	        <!-- insert -->
	        </div>
	        
        <hr>
    </div>
    
	<br><br>
	<div id="chart_div">
 <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>
</html>