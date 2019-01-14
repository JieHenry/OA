<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<title></title>

<jsp:include page="../common/css.jsp"></jsp:include>
<jsp:include page="../common/scripts.jsp"></jsp:include>

<script
	src="<%=request.getContextPath()%>/res/admin/scripts/admin_grid.js"
	type="text/javascript"></script>
<script
	src="<%=request.getContextPath()%>/res/admin/scripts/ueditor/third-party/codemirror/codemirror.js"
	type="text/javascript"></script>

<style type="text/css">
fieldset {
	border: solid 1px #aaa;
}

.hideFieldset {
	border-left: 0;
	border-right: 0;
	border-bottom: 0;
}

.hideFieldset .fieldset-body {
	display: none;
}
</style>
</head>
<body>
	<h1></h1>
<fieldset id="fd1" style="width:880px;">
		<legend>
			<span>请假单</span>
		</legend>

	<div class="fieldset-body">
		<form id="form1" method="post">
		<table class="form-table" border="0" style="margin: 10px">
		 <tr> <td ><input  type="hidden" name="id" value="${leave.id}" id="leave_id"></td>
		 <td><input type="hidden" id="taskName" value="${taskName}" /></td>
		 </tr>
			 <tr>
			
				<td class="form-label" style="width:60px;">申请人：</td>
				<td style="width:150px"><input name="applicant" id="Applicant"
					class="mini-textbox" value="${leave.applicant}" /></td>

					<td class="form-label" style="width:70px;">岗位/职位：</td>
				<td style="width:150px"><input name="position" id="position"
					class="mini-textbox" value="${leave.position}"/></td>
			</tr>
				<tr><td class="form-label" style="width:60px;">部门：</td>
				<td style="width:150px"><input name="department"
					id="department" class="mini-textbox" value="${leave.company_name}"/></td>

			
             </tr>
			    <tr>
				<td class="form-label">请假时间：</td>
				<td><input class="easyui-datebox" value="${leave.start_time}"
					name="start_time" id="start_time" style="width:144px" value="Date"></td>
				<td class="form-label">至：</td>
				<td><input class="easyui-datebox" value="${leave.end_time}"
					name="end_time" id="end_time" style="width:144px" value="Date"></td>
		
				
			</tr>
			<tr>
			
			<td class="form-label" style="width:60px;">请假类别：</td>
			<td><input  value="${leave.leave_category}"name="leave_category" id="leave_category"/>
			</td>
		
			
			
			<td>共计:</td><td><input style="width:50" name="day_count" id="day_count"
					class="mini-textbox" value="${leave.day_count}" /> 天 
			<tr>
				<td class="form-label" style="width:60px;">事由：</td>
				<td colspan="3"><textarea style="width:370px;height:60px"
						name="reason" id="reason">${leave.reason}</textarea>
					</td>
			</tr> 
			<c:if test="${taskName != '提交申请'}">
			<tr>
				<td class="form-label" style="width:60px;">审核意见：</td>
				<td colspan="3"><textarea style="width:370px;height:60px"
					name="" id="options"></textarea>
					</td>
			</tr> 
			</c:if>
			
			<tr>
				<td>
					<c:choose>
   						<c:when test="${not empty leave.leaveFile_name}">
   						<input type="button" onclick="window.location.href='http://img.ca315189.com/casd/leaveFile/${leave.leaveFile_name}'" class="searchbut" value="附件查看下载">

   						
<%--    						  	<a id="leaveFile"  href="http://img.ca315189.com/casd/leaveFile/${leave.leaveFile_name}" >下载附件</a>
 --%>   						</c:when>
  	 				<c:otherwise> 
   						  	<input type="button" class="searchbut" value="无附件" >
					   </c:otherwise>
					</c:choose>
				</td>
			</tr>
			
			<tr>
			<td class="form-label" style="width:60px;">请选择：</td>
				<td style="width:150px"><select  id="username_id" style="width:120px;">
				      <option value="">请选择审批人</option>
				           <c:forEach items="${userList}" var="c">
						<option value="${c.userid}">${c.username}</option>
					</c:forEach>
				</select></td> <td style="align:center">
				
				<a class="easyui-linkbutton"
					href="javascript:;" id="btnSave" onclick="btnSave();">${bot}</a>
					&nbsp;&nbsp;&nbsp;&nbsp; 
					<c:if test="${both !=undefined}">
					<a class="easyui-linkbutton"
					href="javascript:;" id="btnBack" onclick="leave_reject()">${both}</a>
					</c:if>
				<%-- <input id="bot" onclick="btnSave()"
					type="button" value="${bot}"> <c:if test="${both !=undefined}">
						<input class="both" onclick="rejects()" type="button"
							value="${both}">
					</c:if> --%>

				</td>
				</tr>
		</table>
		</form>
		<div style="padding-left: 230px">

			

		</div>
	</div>
</fieldset>
<div style="margin:20px 0;">		
	<table id="history" class="easyui-datagrid" title="审批记录"
			style="width:905px;height:150px"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,">
			<thead>
			<tr>
				<th data-options="field:'name_',width:100">步骤名称</th>
				<th data-options="field:'username',width:80">相关人员</th>
				<th data-options="field:'MESSAGE_',width:300">审核意见</th>
				<th data-options="field:'TIME_',width:180" formatter="dateformat">审核时间</th>			
				<th data-options="field:'center_name',width:100">中心</th>	
				<th data-options="field:'department_name',width:200">部门</th>
			</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		
		  //加载历史记录
		var historys = ${history}.history;
		$('#history').datagrid('loadData', historys);
		
		var leave_category=$("#leave_category").val();
		if (leave_category ==0) {
			$("#leave_category").val("事假");
		} else if (leave_category == 1) {
			$("#leave_category").val("病假");	
		} else if (leave_category == 2) {
			$("#leave_category").val("婚假");
		}else if (leave_category == 3) {
			$("#leave_category").val("产假");	
		}else if (leave_category == 4) {
			$("#leave_category").val("丧假");
		}else if (leave_category == 5) {
			$("#leave_category").val("年假");	
		}else if (leave_category == 6) {
			$("#leave_category").val("其他");	
		}
		});
	
	//提交请假条审核
	   function btnSave(){
	    
	     
		var bizId = $("#leave_id").val();    //获取业务键
		var username = $("#username_id").val();//获取审核人
		var taskName = $("#taskName").val();  //获取节点名称
		var option = $("#options").val(); //获取审核意见
		var position=$("#position").val();//获取职位
		var day = $("#day_count").val();
		var nametext = $("#username_id").find("option:selected").text();//获取审核人username_id
	
		if(option==""){
			if(taskName!='提交申请'){
				$.messager.alert("提示", "请填写审核意见");
				return false;
			}
				
		}	
		if(${userList.size()>0}){
				
			if(taskName=='人事存档' && day<3){
				if(position.indexOf("总经理") != -1){
					$.messager.alert("请选择审核人!");
					return false;
				}
			}else{
				if (username == '') {
					$.messager.alert("提示","请选择审核人","info");
					return false;
			
				}
				}
 
	     	}

		$.messager.confirm('提示！', '你确定审核吗？', function(r) {
		if (r) {	
			
			$.messager.progress({
				title : '提示',
				msg : '正在处理中，请稍候……',
				text : ''
			});
	   	  $.ajax({
			type : 'POST',
			url :  'leave_pass.do',		
			data : {'taskid':${taskid},
					'username' : username,
					'taskName' : taskName,
					'options' : option,
					'bizId' : bizId,
					'position':position,
					'nametext':nametext,	
					'day':day,	   
		},success : function(data) {
			 $.messager.progress('close');
			if (data.Success) {
				$.messager.alert("提示", data.Msg+data.message,"info", function() {
							location.href="findTaskList.do";
						});
		      	}else {
				$.messager.alert("提示", data.Msg,
						"error");
			}

				}
			});
	   	  }
				});
	   }
	   
	   // 驳回功能
	   function  leave_reject(){
		  
			var options = $("#options").val();
			var taskid = ${taskid};
			if(options==''){
				$.messager.alert("提示","审核意见不能为空！");
				return false;
			}
			
		  $.messager.confirm('提示！', '你确定审核吗？', function(r) {
			if (r) {	
			$.ajax({
				type : 'POST',
				url : 'rejects_leave.do',
				data : {
					'taskid':taskid,
					'options':options,
					},success:function(data){
						if (data.Success) {
							$.messager.alert("提示", data.Msg,"info", function() {
										location.href="findTaskList.do";
									});
						} else {
							$.messager.alert("提示", data.Msg,
									"error");
						}

					}
			});}
		});
						
	   }
	
	   Date.prototype.Format=function(fmt){
	        var o={
	            "M+":this.getMonth()+1,//月份
	            "d+":this.getDate(),//日
	            "H+":this.getHours(),//小时
	            "m+":this.getMinutes(),//分
	            "s+":this.getSeconds(),//秒
	            "q+":Math.floor((this.getMonth()+3)/3),//季度
	            "S+":this.getMilliseconds()//毫毛
	        };
	        if(/(y+)/.test(fmt)) fmt=fmt.replace(RegExp.$1,(this.getFullYear()+"").substr(4-RegExp.$1.length));
	        for (var k in o)
	            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	        return fmt;
	    };
		
		 function dateformat(value, row, index) {
			if (value == undefined)
				return "";	
		  var  date=new  Date(value.time); 
	      var time=date.Format("yyyy-MM-dd HH:mm:ss");
				return time;
	            }
	
	</script>

</body>