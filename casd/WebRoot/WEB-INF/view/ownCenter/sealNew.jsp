<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="PowerCheck" prefix="shop"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>首页</title>
<jsp:include page="../common/css.jsp"></jsp:include>
<link
	href="<%=request.getContextPath()%>/res/jquery-easyui/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/res/admin/css/icon.css"
	rel="stylesheet" type="text/css" />
<script
	src="<%=request.getContextPath()%>/res/jquery-easyui/jquery.min.js"
	type="text/javascript"></script>
<script
	src="<%=request.getContextPath()%>/res/jquery-easyui/jquery.easyui.min.js"
	type="text/javascript"></script>
<style type="text/css">
</style>
</head>
<body>
	<form id="jvForm"  method="post"enctype="multipart/form-data">
		<table>
			<tr>
				<td><input class="easyui-filebox" name="sealFile" id="uploadFileid"
					data-options="prompt:'选择文件',buttonText:'&nbsp;选&nbsp;择&nbsp;',required:true"
					style="width:20%px"> 
					
					<c:choose>
   						<c:when test="${not empty seal.own_seal_filePath}">
   						  	<a id="loadfied" class="easyui-linkbutton" onclick="loadSeries()">下载附件</a>
   						</c:when>
  	 				<c:otherwise> 
   						  	<a id="loadfied" class="easyui-linkbutton" >无附件</a>
					   </c:otherwise>
					</c:choose>
					</td>
			</tr>
		</table>

		<fieldset id="fd1" style="width:800px;">
			<legend>
				<span>基本信息</span>
			</legend>
			<div class="fieldset-body">
				<table class="form-table" border="0" cellpadding="1" cellspacing="2">
					<tr>
						<td><input type="hidden" name="own_seal_id" id="own_seal_id"
							value="${seal.own_seal_id}" /></td>
					</tr>
					<tr>
						<td>文件名称：</td>
						<td><input type="text" style="width:250px"
							name="own_seal_fileName" id="own_seal_fileName"
							value="${seal.own_seal_fileName}"/></td>
						<td>预结算金额：</td>
						<td><input type="text"
							name="own_seal_settle" id="own_seal_settle"
							value="${seal.own_seal_settle}" /></td>
						<td><a style="color: red;"
							href="javascript:void(0)" onclick="wen('companyList.do')">用章公司(选择):</a></td>
						<td><input type="text"
							name="own_seal_companyName" id="own_seal_companyName"
							value="${seal.company_name}" readonly="readonly"/></td>
						
						<td style="display: none"><input type="text"
							name="own_seal_company" id="own_seal_company"
							value="${seal.own_seal_company}" class="mini-textbox" /></td> 
						
					</tr>
					<tr>
						<!-- <td>用章类别：</td>
						<td><select id="own_seal_chapCategory" class="mini-combobox" name="own_seal_chapCategory" style="width:124px;">
								<option value="1">公章</option>
								<option value="2">业务章</option>
								<option value="3">出图章</option>
								<option value="4">竣工章</option>
								<option value="5">项目章</option>
						</select></td> -->
						<td>主送单位：</td>
						<td><input type="text" style="width:250px"
							name="own_seal_sender" id="own_seal_sender"
							value="${seal.own_seal_sender}" class="mini-textbox" /></td>


						<td class="form-label" style="display: none">文件路径：</td>
						<td style="display: none"><input type="text"
							name="own_seal_filePath" id="own_seal_filePath"
							value="${seal.own_seal_filePath}" class="mini-textbox" /></td>

						<td class="form-label" style="display: none">创建时间:</td>
						<td style="display: none"><input type="text"
							name="own_seal_creatTime" id="own_seal_creatTime"
							value="${seal.own_seal_creatTime}" class="mini-textbox" /></td>
					    <td>用章类别：</td>
								<td colspan="3"><input type="checkbox"
									name="own_seal_chapCategory" value="1"/>公章 <input
									type="checkbox" name="own_seal_chapCategory" value="2"/>业务章 <input
									type="checkbox" name="own_seal_chapCategory" value="3" />出图章 <input
									type="checkbox" name="own_seal_chapCategory" value="4" />竣工章 <input
									type="checkbox" name="own_seal_chapCategory" value="5" />项目章</td>
							  </tr>
				
					<tr><td>盖章用途：</td>
						<td  colspan="10" ><textarea type="text"  style="width:100%;height: 60px;resize:none;"
							name="own_seal_remark" id="own_seal_remark"
							value="${seal.own_seal_remark}"></textarea></td></tr>
							
					
				</table>
			</div>
			盖章说明：
			<div>
			公章：发起人——>主管公司部门经理——>主管公司总经理——>总裁——>董事长助理——>公司盖章——>始发人——>结束<br>
			业务章/出图章/竣工章：发起人——>主管公司部门经理——>主管公司总经理——>董事长助理——>公司盖章——>始发人——>结束<br>
			项目章：发起人——>主管公司总经理——>项目盖章——>结束<br>
			
			</div>
		</fieldset>
	</form>
	<br>
	<div>
       <span>节点名称：</span>   
<select id="key" class="easyui-combobox" name="dept" style="width:150px;">
   <option value="">请选择</option>
 <c:forEach var="dept" items="${sdsDefinitions }">
<option value="${dept.getNameExpression()}">${dept.getNameExpression()}</option>
</c:forEach>
</select>
    <span>审核人：</span>
 <input class="easyui-combobox"  style="width:150px;" id="courseName"><br/>
</div>
	<div style="margin: 2px 5px 10px 70px">
	<c:if test="${seal.own_seal_status==0||empty seal.own_seal_status}">
		<a class="easyui-linkbutton" href="javascript:;" id="btnSave"
			onclick="btnSave()">保存</a>
		</c:if>	
			 &nbsp; <a class="easyui-linkbutton"
			href="javascript:;" id="btnCancel" onclick="btnCancel()">返回</a>
		
	</div>

	<div id="centers" class="easyui-window"
		data-options="region:'center',title:'请选择值'" closed="true"
		style="height: 500px; width: 800px"></div>



	<script type="text/javascript">


	
	$(document).ready(function () {
		if(${type=='edit'}){
		      category();
			}
		$("#key").combobox({
		onChange: function (n,o) {

			var	nodeName = $('#key').val();
			
		    $.ajax({
		      type: "get",
		      url: 'loadCourse.do',
		      data:{'nodeName':nodeName},
		   
		      success: function(data){
		    		$('#courseName').combobox({
		    		    valueField:'userid',
		    		    textField:'username',
		    		    editable:false, //不可编辑状态
		    		});
		      $("#courseName").combobox("loadData",data);
		               }
		          }); 

		}
		});
		});
	

		function show(){
		    obj = document.getElementsByName("own_seal_chapCategory");
		    check_val = [];
		    for(k in obj){
		        if(obj[k].checked)
		            check_val.push(obj[k].value);
		    }
		     return check_val;
		}
		//给公章类型赋值
		function category() {
			var category = "${seal.own_seal_chapCategory}".split(",");
			for (var i = 0; i < category.length; i++) {
				$('input[name=own_seal_chapCategory][value='
								+ category[i] + ']').attr('checked', 'checked');//很简单就不说了哦
			}
		}
		//取消
		function btnCancel() {
			location.href = "sealList.do";
		}
		function wen(src) {
			var hrefs = "<iframe id='son' src='"
					+ src
					+ "' allowTransparency='true' style='border:0;width:99%;height:99%;padding-left:2px;' frameBorder='0'></iframe>";
			$("#centers").html(hrefs);
			$("#centers").window("open");
		}

		function data(rowData) {
			var company_name = rowData.company_name === undefined ? ""
					: rowData.company_name;
			$("#own_seal_companyName").val(company_name);
			$("#own_seal_company").val(rowData.company_id);
	     	}
		//保存
		function btnSave() {
		
			
			obj = document.getElementsByName("own_seal_chapCategory");
			    check_val = [];
			    for(k in obj){
			        if(obj[k].checked)
			            check_val.push(obj[k].value);
			    }
			var own_seal_companyName=$("#own_seal_companyName").val();
			if(own_seal_companyName=="" || own_seal_companyName == null){
				alert("用章公司不能为空!");
				return false;
			}
			
			if(check_val==""){
				$.messager.alert("提示","请选择公章!", "info");
				return false;
			}
			var username=$('#courseName').val();
			if(username==""){
				$.messager.alert("提示","审核人不能为空!", "info");
				return false;
			}
			var taskName=$("#key").val();
			var formData = new FormData(document.getElementById("jvForm"));
			$.messager.confirm('提示！', '你确定提交吗？', function(r) {
				if (r) {
					 $.messager.progress({ 
					       title: '提示', 
					       msg: '正在处理中，请稍候……', 
					       text: '' 
				   });
			  $.ajax({
				url : "save_seal.do?username="+username+"&taskName="+taskName,
				type : 'POST',
				data : formData,
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					 $.messager.progress('close');
					if (data.Success) {
						$.messager.alert("提示", data.Msg, "info", function() {
							location.href = "sealList.do";
						});

					} else {
						$.messager.alert("提示", data.Msg, "error");
					}

				},
				error : function(data) {
					$.messager.alert("提示", data.Msg, "error");
				}
			});}});
		}

		function loadSeries() {
			var own_seal_filePath = $('#own_seal_filePath')
					.val();
			if (own_seal_filePath == "") {
				alert("没有附件！");
				return false;
			}
			var form = $("<form>");
			$('body').append(form);
			form.attr('style', 'display:none');
			form.attr('target', '');
			form.attr('method', 'post');
			form.attr('action', "downloadseal.do?own_seal_filePath="+ own_seal_filePath);//下载文件的请求路径  
			form.submit();
		}
	</script>
</body>
</html>