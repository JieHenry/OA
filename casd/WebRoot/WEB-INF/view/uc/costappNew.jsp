<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>首页</title>
<jsp:include page="../common/css.jsp"></jsp:include> 
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


body {
    background:none;
}


* {
    font-size: 18px;
}

.right {
    text-align: left;
}

.left {
    text-align: center;
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
<body >
	<div style="margin: 20px"></div>
	<div id="head" style="text-align: center;font-size:25px">
	<strong style="font-size: 25px !important;">费用申请表</strong>
	</div>
	<table border="1">
	<tr height="50px">
			<td class="left" align="center" canEdit="false"><a style="color: red;" href="javascript:void(0)" onclick="wen('orgCheck.do')">公司/部门</a></td>
			<td id="costapp_company" class="right" canEdit="false">${data.costapp_company}</td>
		<tr height="100px">
			<td class="left" align="center" canEdit="false">申请事项</td>
			<td id="costapp_appitem" class="right" canEdit="true">${data.costapp_appitem}</td>
		</tr>
		<tr height="50px">
			<td class="left" align="center" canEdit="false">申请类型</td>
			<td class="right" canEdit="select" style="text-align: left;" ><a style="color: red;" id="costapp_application" href="#" onclick="changeCom();" >${data.costapp_application}</a></td>
		</tr>
		<tr height="50px">
			<td class="left" align="center" canEdit="false">费用金额</td>
			<td id="costapp_amount" class="right" canEdit="true">${data.costapp_amount}</td>
		</tr>
		<tr height="100px">
			<td class="left" align="center" canEdit="false">主办部门意见</td>
			<td id="costapp_majoyview" class="right" canEdit="true">${data.costapp_majoyview}</td>
		</tr>
		<tr height="60px">
			<td class="left" align="center" canEdit="false">总经理意见</td>
			<td id="costapp_managerview" class="right" canEdit="true">${costapp_managerview}</td>
			
		<tr height="60px">
		<td class="left" align="center" canEdit="false">财务经理意见</td>
		<td id="costapp_financeview" class="right" canEdit="true">${costapp_financeview}</td>
		</tr>
		<tr height="60px">
		<td class="left" align="center" canEdit="false">董事助理意见</td>
		<td id="costapp_assistant" class="right" canEdit="true">${costapp_assistant}</td>
		</tr>		
		<tr height="60px">
			<td class="left" align="center" canEdit="false">董事长意见</td>
			<td id="costapp_chairmanview" class="right" canEdit="true">${costapp_chairmanview}</td>
		</tr>
	<tr style="display: none">
			<td id="costapp_id" >${data.costapp_id}</td>
			
		</tr>
	</table>
	
		<div style="text-align:center">
			<a class="easyui-linkbutton" href="javascript:;" id="btnSave" style="width: 80px;"
				onclick="btnSave()">保存</a> &nbsp;&nbsp;&nbsp;&nbsp; <a
				class="easyui-linkbutton" style="width: 80px;" href="javascript:;" id="btnCancel"
				onclick="btnCancel()">取消</a>
		</div>
	
	<div id="centers" class="easyui-window"
			data-options="region:'center',title:'请选择值'" closed="true"
			style="height: 500px; width: 800px"></div>
	
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
					if(this.getAttribute('canEdit') === 'select'){
						
					}
				};

			}
			
			$(document).ready(function() {
				 if(${edit}){
					 document.getElementById("costapp_application").innerHTML = "借支申请";
				 }
			});
			
			//保存
			function btnSave(){
				
				var costapp_id=document.getElementById("costapp_id").innerText;
				var costapp_company=document.getElementById("costapp_company").innerText;
				var costapp_appitem=document.getElementById("costapp_appitem").innerText;
				var costapp_amount=document.getElementById("costapp_amount").innerText;
				var costapp_application=document.getElementById("costapp_application").innerText;
				var costapp_majoyview=document.getElementById("costapp_majoyview").innerText;
				var costapp_managerview=document.getElementById("costapp_managerview").innerText;
				var costapp_chairmanview=document.getElementById("costapp_chairmanview").innerText;
				var costapp_financeview=document.getElementById("costapp_financeview").innerText;
				
	
            	$.messager.confirm('提示！', '你确定提交吗？', function(r) {
            		if(r){
				$.ajax({
					type : 'POST',
					url : 'save_costapp.do',
					data : {
						'costapp_id' : costapp_id,
						'costapp_company' : costapp_company,
						'costapp_appitem' : costapp_appitem,
						'costapp_amount' : costapp_amount,
						'costapp_application' : costapp_application,
						'costapp_majoyview' : costapp_majoyview,
						'costapp_managerview':costapp_managerview,
						'costapp_chairmanview':costapp_chairmanview,
						'costapp_financeview':costapp_financeview,
					},
					success : function(data) {
						if (data.Success) {

							$.messager.alert("提示", data.Msg, "info",
									function() {
										location.href = "findTaskList.do";
									});
						} else {

							$.messager.alert("操作提示", data.Msg, "error");
						}

					}
				});
            		}
            	});
				
			}
			
			//取消
			function btnCancel(){
				location.href="costappList.do";
			}
			
			function changeCom(){
				var application=document.getElementById("costapp_application").innerText;
				if(application=="借支申请"){
					document.getElementById("costapp_application").innerHTML = "费用审批";
				}
				if(application=="费用审批"){
					document.getElementById("costapp_application").innerHTML = "报销申请";
				}
				if(application=="报销申请"){
					document.getElementById("costapp_application").innerHTML = "借支申请";
				}
				
			}
			
			
			
			function wen(src) {
				var hrefs = "<iframe id='son' src='"
						+ src
						+ "' allowTransparency='true' style='border:0;width:99%;height:99%;padding-left:2px;' frameBorder='0'></iframe>";
				$("#centers").html(hrefs);
				$("#centers").window("open");
			}
			
			
			function data(rowData){
				var company_name= rowData.company_name===undefined?"":rowData.company_name;
				var center_name=  rowData.center_name===undefined?"":rowData.center_name;
				var department_name=  rowData.department_name===undefined?"":rowData.department_name;
				document.getElementById("costapp_company").innerHTML = company_name+center_name+department_name;
			}
			
			
			
	</script>

</body>
</html>