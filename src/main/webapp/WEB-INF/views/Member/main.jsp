<%@page import="vo.ArticleVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="vo.CalendarVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Insert title here</title>
<script
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>



<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css">
<style>
.fc-toolbar-chunk {
	display: flex;
	align-items: center;
}

.fc-col-header-cell-cushion {
	color: #000;
	text-decoration: none !important;
}

.fc-col-header-cell-cushion:hover {
	text-decoration: none !important;
	color: #000;
}

.fc-daygrid-day-number {
	text-decoration: none !important;
	color: #000;
}

.py-5 bg-light border-bottom mb-4 {
	height: 250px;
	background-size: contain;
	background-repeat: no-repeat !important;
	background-position: center !important;
/* 	display: flex !important;
    justify-content: center !important; */
    background-position: 25% 75%;
}
</style>
<script>
	 function send(f) {
		f.action = "memo_list.do";
		f.method="post";
		f.submit();
	 }
</script>
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="main.do?mid=${user.id}">DIARY'S</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						href="main.do?mid=${user.id}">???</a></li>
					<li class="nav-item"><a class="nav-link"  style="cursor:pointer;" onclick="location.href='memo_list.do?id=${user.id}'">??????</a></li>
					<li class="nav-item"><a class="nav-link"
						href="list.do?id=${user.id}">?????????</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">????????????</a></li>
						<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="logout.do">????????????</a></li>
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
	<div id='calendar'></div>

	<!-- modal ?????? -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form>
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">????????? ???????????????.</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<!--  <input type="hidden" name="CALENDAR_NO">  -->
							<label for="taskId" class="col-form-label">?????? ??????</label> <input
								type="text" class="form-control" id="calendar_title"
								name="CALENDAR_TITLE"> <label for="taskId"
								class="col-form-label">?????? ??????</label> <input type="date"
								class="form-control" id="calendar_start_date"
								name="CALENDAR_START"> <label for="taskId"
								class="col-form-label">?????? ??????</label> <input type="date"
								class="form-control" id="calendar_end_date" name="CALENDAR_END">
							<label for="taskId" class="col-form-label">?????? ??????</label> <input
								type="text" class="form-control" id="calendar_memo"
								name="CALENDAR_MEMO">

						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-warning" id="addCalendar"
							onclick="insertsend(this.form);">??????</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" id="sprintSettingModalClose">??????</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!--- ?????? ?????? modal ?????? -->
	<div class="modal fade" id="calendarModal1" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<form>
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">????????? ???????????????.</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="modal-body">

						<div class="form-group">

							<input type="hidden" id="calendar_index" name="CALENDAR_NO"
								value=""> <input type="hidden" name="mid"
								value="${user.id}"> <label for="taskId"
								class="col-form-label">?????? ??????</label><input type="text"
								class="form-control" id="calendar_title" name="CALENDAR_TITLE"
								value=""> <label for="taskId" class="col-form-label">??????
								??????</label> <input type="date" class="form-control"
								id="calendar_start_date" name="CALENDAR_START" value="">
							<label for="taskId" class="col-form-label">?????? ??????</label> <input
								type="date" class="form-control" id="calendar_end_date"
								name="CALENDAR_END" value=""> <label for="taskId"
								class="col-form-label">?????? ??????</label> <input type="text"
								class="form-control" id="calendar_memo" name="CALENDAR_MEMO"
								value="">

						</div>

					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-warning" id="addCalendar"
							onclick="updatesend(this.form);">??????</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal" id="sprintSettingModalClose">??????</button>
						<button type="button" class="btn btn-secondary"
							onclick="del(this.form);">??????</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

<script>
function del(f){

	if(confirm("?????????????????????????")){
		f.action="calendarDel.do?";
     	f.method="post";
     	f.submit(); 
		 $("#calendarModal1").modal("hide");
		alert("????????? ?????????????????????.");
	}
	
	
}

function insertsend(f){
	 let CALENDAR_TITLE = f.CALENDAR_TITLE.value;
	 let CALENDAR_START = f.CALENDAR_START.value;
	 let CALENDAR_END =  f.CALENDAR_END.value;
	 let CALENDAR_MEMO =  f.CALENDAR_MEMO.value;


	//?????? ?????? ?????? ??????
     if(CALENDAR_TITLE == null || CALENDAR_TITLE == ""){
         alert("????????? ???????????????.");
     }else if(CALENDAR_START == "" || CALENDAR_END ==""){
         alert("????????? ???????????????.");
     }else if(new Date(CALENDAR_END)- new Date(CALENDAR_START) < 0){ // date ???????????? ?????? ??? ??????
         alert("???????????? ??????????????? ???????????????.");
     }else{ // ???????????? ?????? ???
    
      	f.action="calendarAdd.do?mid=${user.id}";
     	f.method="post";
     	f.submit(); 

         }//????????? ?????? ??????
}

function updatesend(f){
	
	 let CALENDAR_NO = f.CALENDAR_NO.value;
	 let CALENDAR_TITLE = f.CALENDAR_TITLE.value;
	 let CALENDAR_START = f.CALENDAR_START.value;
	 let CALENDAR_END =  f.CALENDAR_END.value;
	 let CALENDAR_MEMO =  f.CALENDAR_MEMO.value;
	 
	//?????? ?????? ?????? ??????
     if(CALENDAR_TITLE == null || CALENDAR_TITLE == ""){
         alert("????????? ???????????????.");
     }else if(CALENDAR_START == "" || CALENDAR_END ==""){
         alert("????????? ???????????????.");
     }else if(new Date(CALENDAR_END)- new Date(CALENDAR_START) < 0){ // date ???????????? ?????? ??? ??????
         alert("???????????? ??????????????? ???????????????.");
     }else{ // ???????????? ?????? ???
    	f.action="calendarupdate.do";   	
      	f.method="post";
     	f.submit(); 
     	
     
         }//????????? ?????? ??????
}
/* function index(){
	//select?????? ???????????? ?????? ???
	location.href="calender_index.do?mid="+${user.id}+"&CALENDAR_NO="+index;
}  */

</script>
<script>
let index=0;

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth',
		locale : 'ko', // ????????? ??????
		headerToolbar : {
        	start : "addEventButton",
            center : 'prev title next',
            end : 'today dayGridMonth,dayGridWeek,dayGridDay'
            },
	selectable : true,
	customButtons: {
        addEventButton: { // ????????? ?????? ??????
            text : "?????? ??????",  // ?????? ??????
            click : function(){ // ?????? ?????? ??? ????????? ??????
                $("#calendarModal").modal("show"); // modal ????????????
            }
         }
    },
    eventClick:function(info) {//????????? ?????????

    	index =info.event.extendedProps.index;
    	$("#calendarModal1 #calendar_index").val( index );
        var title = info.event.title;
        $("#calendarModal1 #calendar_title").val( title );
        var start_date = info.event.start;
        $("#calendarModal1 #calendar_start_date").val( start_date );
        var end_date = info.event.end;
        $("#calendarModal1 #calendar_end_date").val( end_date );
      	var memo = info.event.extendedProps.memo;
        $("#calendarModal1 #calendar_memo").val( memo );
        $("#calendarModal1").modal("show");
		
    },

	droppable : true,
	editable : true,
		
	
	events : [ 
	    <%List<CalendarVO> calendarList = (List<CalendarVO>) request.getAttribute("list2");%>
        <%if (calendarList != null) {%>
        <%for (CalendarVO vo : calendarList) {%>
        {
        	memo : '<%=vo.getCALENDAR_MEMO()%>',
        	index : '<%=vo.getCALENDAR_NO()%>',
        	title : '<%=vo.getCALENDAR_TITLE()%>',
            start : '<%=vo.getCALENDAR_START()%>',
            end :	'<%=vo.getCALENDAR_END()%>',           
            color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
         },
	<%}
}%>
			]
   
				
	 });
			calendar.render();
		});
	

</script>
</html>