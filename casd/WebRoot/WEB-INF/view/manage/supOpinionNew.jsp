<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<%-- <jsp:include page="../common/css.jsp"></jsp:include> --%>
<jsp:include page="../common/scripts.jsp"></jsp:include>

<script
	src="<%=request.getContextPath()%>/res/admin/scripts/admin_grid.js"
	type="text/javascript"></script>
<script
	src="<%=request.getContextPath()%>/res/admin/scripts/ueditor/third-party/codemirror/codemirror.js"
	type="text/javascript"></script>

<script
	src="<%=request.getContextPath()%>/res/admin/scripts/jquery.ajaxfileupload.js"
	type="text/javascript"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0
}

table {
	border-collapse: collapse;
	margin: 20px auto;
}

td {
	width: 650px;
	/* height: 50px; */
	position: relative;
}

td.left{

	width:15%;
	
}

td.out{

	width:15px;
	
}

td textarea {
	width: 100%;
	height: 100%;
	border: 0;
	outline: 0;
	position: absolute;
	z-index: 10;
	left: 0;
	top: 0;
	resize：none;
}
</style>
</head>
<body>
   <div style="margin: 20px"></div>
	<div style="text-align: center;font-size:25px">
	<strong >诚安时代监察意见表</strong>
	</div>
	<div style="margin: 10px"></div>
	<div style="text-align: center;font-size:20px">
	<strong  id="supOpinion_title">${data.supOpinion_title}</strong>
	</div>


	<div class="herd">
	<table border="1">
		<tr height="50px">
			<td class="left" align="center" canEdit="false">公司/部门</td>
			<td class="right" canEdit="select" ><a id="supOpinion_company" href="#" onclick="changeCom();" >${data.supOpinion_company}</a></td>
		</tr>
		<tr height="130px">
			<td class="left" align="center" canEdit="true">监察<br>存在问题</td>
			<td id="supOpinion_supProblem" class="right" canEdit="true">${data.supOpinion_supProblem}</td>
		</tr>
		<tr height="130px">
			<td class="left" align="center" canEdit="true">监察<br>提出建议</td>
			<td id="supOpinion_supPropose" class="right" canEdit="true">${data.supOpinion_supPropose}</td>
		</tr>
		<tr height="130px">
			<td class="left" align="center" canEdit="true">监察<br>表扬/处分</td>
			<td id="supOpinion_praiOrPun" class="right" canEdit="true">${data.supOpinion_praiOrPun}</td>
		</tr>
		<tr height="130px">
			<td class="left" align="center" canEdit="true">公司/部门<br>自评</td>
			<td id="supOpinion_selfEva" class="right" canEdit="true">${data.supOpinion_selfEva}</td>
		</tr>
		<tr height="120px">
			<td class="left" align="center" canEdit="true">监察<br>评定结果</td>
			<td id="supOpinion_result" class="right" canEdit="true">${data.supOpinion_result}</td>
		</tr>
		<tr height="100px">
			<td class="left" align="center" canEdit="false">备注</td>
			<td class="right" canEdit="false">
			1、本监察意见由管理公司监察中心经理负责，以公司为单位<br>
			2、监察报告内容应包含部门/公司当月存在的问题、监察中心提出的建议，做的好的地方<br>
			应予以表扬，监察中心最终因对当月表现给出处理结果<br>
			3、监察中心每月5日前完成监察存在问题、监察提出意见及监察表扬/处罚交给诚安发展<br>
			自评，诚安发展负责人每月8日前完成自评交给监察中心，监察中心10日前将完整的监察<br>
			报告结果递交董事会审核<br>
			</td>
		</tr>
		<tr style="display: none">
			<td id="supOpinion_id" >${data.supOpinion_id}</td>
			<td id="supOpinion_creatDate">${data.supOpinion_creatDate}</td>
		</tr>
		
			
    	</table>	
	</div>

	
	
		<div style="text-align:center">
		
         <select id="cc" style="width: 100px">
	     <c:forEach items="${userList}" var="user">
         <option value="${user.userid}">${user.username}</option>  </c:forEach>
         </select>
			<a class="easyui-linkbutton" href="javascript:;" id="btnSave"
				onclick="btnSave()">保存</a> &nbsp;&nbsp;&nbsp;&nbsp; <a
				class="easyui-linkbutton" href="javascript:;" id="btnCancel"
				onclick="btnCancel()">取消</a>
		</div>
	
	<script>
			
			
			var tds = document.getElementsByTagName('td');
			for (var i = 0; i < tds.length; i++) {
				tds[i].onclick = function(e) {
					if (this.getAttribute('canEdit') === 'true') {
						var textarea = document.createElement("textarea");
						this.appendChild(textarea);
						textarea.focus();

						e.cancelBubble = false;
						textarea.value = this.innerText;
						var _this = this;
						textarea.onblur = function() {
							_this.innerText = this.value;
						};
						
					}
				};

			}
			
			$(document).ready(function() {
				  if(${edit}){
					 var date=new Date;
					 var year=date.getFullYear(); 
					 var month=date.getMonth()+1;
					 month =(month<10 ? "0"+month:month); 
					 var mydate = (year.toString()+"年"+month.toString()+"月");
					 document.getElementById("supOpinion_title").innerHTML = mydate;
					 document.getElementById("supOpinion_company").innerHTML = "传诚管理";
				 } 
			});
			
			//保存
			function btnSave(){
				
				var supOpinion_id=document.getElementById("supOpinion_id").innerText;
				var supOpinion_company=document.getElementById("supOpinion_company").innerText;
				var supOpinion_supProblem=document.getElementById("supOpinion_supProblem").innerText;
				var supOpinion_supPropose=document.getElementById("supOpinion_supPropose").innerText;
				var supOpinion_praiOrPun=document.getElementById("supOpinion_praiOrPun").innerText;
				var supOpinion_selfEva=document.getElementById("supOpinion_selfEva").innerText;
				var supOpinion_creatDate=document.getElementById("supOpinion_creatDate").innerText;
				var supOpinion_result=document.getElementById("supOpinion_result").innerText;
				var supOpinion_title=document.getElementById("supOpinion_title").innerText;
				
				var username=$("#cc").val();
	             	if(username==''){
	             	alert("请选择审核人");
	             	return false;
		            }
	             	
				$.ajax({
					type : 'POST',
					url : 'save_supOpinion.do',
					data : {
						'supOpinion_id' : supOpinion_id,
						'supOpinion_company' : supOpinion_company,
						'supOpinion_supProblem' : supOpinion_supProblem,
						'supOpinion_supPropose' : supOpinion_supPropose,
						'supOpinion_praiOrPun' : supOpinion_praiOrPun,
						'supOpinion_selfEva' : supOpinion_selfEva,
						'supOpinion_result' : supOpinion_result,
						'supOpinion_title' : supOpinion_title,
						'supOpinion_creatDate':supOpinion_creatDate,
						'username':username
					
					},
					success : function(data) {
						if (data.Success) {
							alert(data.Msg);
							location.href="supOpinionList.do";
						} else {
							alert(data.Msg);
						}
						
					}
				});
			}
			
			//取消
			function btnCancel(){
				location.href="achReviewList.do";
			}
			
			function changeCom(){
				var company=document.getElementById("supOpinion_company").innerText;
				if(company=="传诚管理"){
					document.getElementById("supOpinion_company").innerHTML = "诚安科技";
				}
				if(company=="诚安科技"){
					document.getElementById("supOpinion_company").innerHTML = "诚安教育";
				}
				if(company=="诚安教育"){
					document.getElementById("supOpinion_company").innerHTML = "诚安建设";
				}
				if(company=="诚安建设"){	
					document.getElementById("supOpinion_company").innerHTML = "董事会";
				}
				if(company=="董事会"){
					document.getElementById("supOpinion_company").innerHTML = "传诚管理";
				}
			}
			
			
			
	</script>

</body>
</html>