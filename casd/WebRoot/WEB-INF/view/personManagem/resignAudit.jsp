<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

	<form action="" id="from1">
		<fieldset id="fd1" style="width:1000px;">
			<legend>
				<span>基本信息</span>
			</legend>
			<div class="fieldset-body">
				<table class="form-table">
					<tr>
						<td><input type="hidden" name="hr_resign_id"
							id="hr_resign_id" value="${hr_resign_id}" /></td>
						<td><input type="hidden" name="taskid" id="taskid"
							value="${taskid}" /></td>
						<td><input type="hidden" name="taskName" id="taskName"
							value="${taskName}"/></td>
					</tr>
					<tr>
						<td>申请日期：</td>
						<td><input type="text"
							name="hr_resign_applyDate" 
						id="hr_resign_applyDate"
							value="${hr_resign_applyDate}" class="mini-textbox" /></td>
					

						<td>预定离公司日期：</td>
						<td><input type="text"
							name="hr_resign_schLeave" 
						id="hr_resign_schLeave"
							value="${hr_resign_schLeave}" class="mini-textbox"/></td>
						<td>实际离公司日期：</td>
						<td><input type="text"
							name="hr_resign_realLeave" 
						id="hr_resign_realLeave"
							value="${hr_resign_realLeave}" class="mini-textbox" /></td>
					</tr>
					<tr>
						<td><a style="color: red;" href="javascript:void(0)" onclick="wen()">离职原因<br>点击放大:</a></td>
						<td><input type="text"
							name="hr_resign_reason" id="hr_resign_reason"
							
						value="${hr_resign_reason}"/></td>
						
							<td>离职类别：</td>
						   <td><select name="hr_resign_category"
							id="hr_resign_category" style="width:100%" disabled="disabled">
								<option value="1">辞职</option>
								<option value="2">辞退</option>
								<option value="3">合同终止</option>
						</select></td>
						
						<td>离职人：</td>
						<td><input type="text"	
						value="${username}"/></td>
					</tr>

				</table>
			</div>
		</fieldset>


		<div id="tab" class="easyui-tabs" style="width:1024px;height:500px">
			<div title="审核意见" style="padding:10px">
				<table id="history" class="easyui-datagrid"
					style="width:930px;height:outo"
		             data-options="
					iconCls: 'icon-edit',
					singleSelect: true,
			        toolbar: '#tb'">
					<thead>
			<tr>
				<th data-options="field:'username',width:80">审核人</th>
				<th data-options="field:'MESSAGE_',width:300">审核意见</th>
				<th data-options="field:'center_name',width:100">中心</th>
				<th data-options="field:'department_name',width:200">部门</th>

			</tr>
			</thead>
				</table>
			</div>

			<div title="交接记录" style="padding:10px">
				<fieldset id="handOne" style="width:900px;">
					<legend>
						<span>部门手续</span>
					</legend>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="1"
							cellspacing="2">
							<tr>
								<td class="form-label" style="width:160px;">工作交接：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_workHandover" id="hr_resign_workHandover"
									value="${hr_resign_workHandover}" class="mini-textbox" /></td>
								<td class="form-label" style="width:160px;">资料交接：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_dataHandover"
								
								id="hr_resign_dataHandover"
									value="${hr_resign_dataHandover}" class="mini-textbox" /></td>
								<td class="form-label" style="width:160px;">文具交接：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_stationeryHandover"
									
								id="hr_resign_stationeryHandover"
									value="${hr_resign_stationeryHandover}"
									class="mini-textbox" /></td>
								<td class="form-label" style="width:160px;">其它事项：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_otherHandover"
									
								id="hr_resign_otherHandover"
									value="${hr_resign_otherHandover}" class="mini-textbox"/></td>
							</tr>

						</table>
					</div>
				</fieldset>

				<br>
				<fieldset id="handTwo" style="width:900px;">
					<legend>
						<span>资源中心手续</span>
					</legend>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="1"
							cellspacing="2">
							<tr>
								<td class="form-label" style="width:70px;">意见：</td>
								<td style="width:150px"><input type="text"
								 	name="hr_resign_hrOpinion" 
								    id="hr_resign_hrOpinion"
									value="${hr_resign_hrOpinion}" class="mini-textbox" /></td>
							</tr>

						</table>
					</div>
				</fieldset>
				<br>
				<fieldset id="handThree" style="width:900px;">
					<legend>
						<span>财务部手续</span>
					</legend>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="1"
							cellspacing="2">
							<tr>

								<td class="form-label" style="width:70px;">工资计发：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_payroll" 
								    id="hr_resign_payroll"
									value="${hr_resign_payroll}" class="mini-textbox" /></td>
								<td class="form-label" style="width:70px;">其他事项：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_financeOthers"
									
								id="hr_resign_financeOthers"	
									value="${hr_resign_financeOthers}" class="mini-textbox"/></td>
							</tr>

						</table>
					</div>
				</fieldset>


				<br>
				<fieldset id="handFour" style="width:900px;">
					<legend>
						<span>董事长意见</span>
					</legend>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="1"
							cellspacing="2">
							<tr>
								<td class="form-label" style="width:70px;">意见：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_topOpinion"
									
								id="hr_resign_topOpinion"
									value="${hr_resign_topOpinion}" class="mini-textbox" /></td>
							</tr>

						</table>
					</div>
				</fieldset>


				<br>
				<fieldset id="handFive" style="width:900px;">
					<legend>
						<span>申请人确认</span>
					</legend>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="1"
							cellspacing="2">
							<tr>
								<td class="form-label" style="width:70px;">确认时间：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_confirmTime"
								
								id="hr_resign_confirmTime"
									value="${hr_resign_confirmTime}" class="mini-textbox" /></td>
								<!-- <td><a href="#" class="easyui-linkbutton"
								iconCls="icon-image_add" plain="true"
								onclick="$('#findphoto').window('open')">查看签名</a></td> -->
								<td class="form-label" style="width:80px;">申请人签字：</td>
								<c:if test="${not empty hr_resign_autoPath}">
									<td><img src="/uploadfile/photo/${hr_resign_autoPath}"
										id="autoImg" style="width:100px;height:30px" /></td>
								</c:if>
								<td><a href="#" class="easyui-linkbutton"
									onclick="btnAuto();">签名</a></td>

								<td style="display: none"><input type="text"
									name="hr_resign_autoPath" 
								id="hr_resign_autoPath"
									value="${hr_resign_autoPath}" class="mini-textbox" /></td>
							</tr>

						</table>
					</div>
				</fieldset>
				<br>
				<fieldset id="handSix" style="width:900px;">
					<legend>
						<span>技术部手续</span>
					</legend>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="1"
							cellspacing="2">
							<tr>
								<td class="form-label" style="width:70px;">系统账号管理：</td>
								<td style="width:150px"><input type="text"
									name="hr_resign_sysManage" "
								id="hr_resign_sysManage"
									value="${hr_resign_sysManage}" class="mini-textbox" /></td>
							</tr>

						</table>
					</div>
				</fieldset>
			</div>

		</div>

	</form>

	<div id="win" class="easyui-window" id="reason" name="reason"
		data-options="region:'center',title:'查看'" closed="true"
		style="height: 400px; width: 520px;text-align:center">
		<textarea id="dataText" style="height: 300px; width: 500px;"></textarea>
		<br>
		<tr>
			<td style="align:center"><a href="javascript:void(0)"
				class="easyui-linkbutton" onclick="makeSure()">确定</a></td>
		</tr>
	</div>
	<div style="padding: 10px;">
		<table class="form-table" border="0">
			<tr>
             
				<td class="form-label" style="width:80px;"><h3>下一审核人：</h3></td>
				<td style="width:150px"><select name="username" id="username"
					style="width:120px;">

						<c:forEach items="${userList}" var="user">
							<option value="${user.userid}">${user.username}</option>
						</c:forEach>
				</select></td>
				<c:if test="${taskName != '申请人'}">
				<td class="form-label" style="width:80px;"><h3>审核意见：</h3></td>
				<td style="width:150px">
			   	<input type="text" value=""
					name="options" id="options" class="mini-textbox"/></td>
                  </c:if>
				<c:forEach var="bot" items="${bot}">
					<td><c:if test="${bot=='提交'}">
							<td><a class="easyui-linkbutton" href="javascript:;"
								id="btnSave" onclick="resign_pass()">${bot}</a></td>
						</c:if> <c:if test="${bot=='驳回'}">
							<td><a class="easyui-linkbutton" href="javascript:;"
								id="btnBack" onclick="rejects()">${bot}</a></td>
						</c:if>
				</c:forEach>
			</tr>
		</table>
	</div>

<!-- 驳回js调用 -->
<script src="<%=request.getContextPath()%>/res/jquery-easyui/wangEditor/release/rejects.js"
	type="text/javascript"></script> 
	
	<script type="text/javascript">
		$(function() {
			var historys = ${history}.history;
			$('#history').datagrid('loadData',historys);
	
			
			$("#hr_resign_category").val(${hr_resign_category});

		});

		function makeSure() {
			$("#hr_resign_reason").val($("#dataText").val());
			$("#win").window("close");
		}

		function wen() {
			$("#dataText").val($("#hr_resign_reason").val());

			$("#win").window("open");
		}

		/**
		 *审核单据
		*/
		function resign_pass() {
			
			var taskName = $("#taskName").val();
			var taskid = $("#taskid").val();
			var options = $("#options").val();	
			var username =$("#username").val();
			var hr_resign_workHandover =$("#hr_resign_workHandover").val();	//部门手续	
			var hr_resign_hrOpinion =$("#hr_resign_hrOpinion").val();	//资源中心手续
			var hr_resign_payroll =$("#hr_resign_payroll").val();	//财务部手续
			var hr_resign_topOpinion =$("#hr_resign_topOpinion").val();	//董事长手续
			var hr_resign_autoPath =$("#hr_resign_autoPath").val();	  //申请人签字
			var hr_resign_sysManage =$("#hr_resign_sysManage").val();	//系统确认
			
			//部门手续限制
			if(taskName=='部门经理手续'){
				if(hr_resign_workHandover==''){
					$.messager.alert("提示!","请切换交接记录填写部门手续!");
					return false;
				}
				
			}
			//资源中心手续限制
		  if(taskName=='资源中心手续'){
				if(hr_resign_hrOpinion==''){
					$.messager.alert("提示!","请切换交接记录资源中心手续!");
					return false;
				}
				//财务部手续
			}else if(taskName=='财务核算工资'){
				if(hr_resign_payroll==''){
					$.messager.alert("提示!","请切换交接记录填写财务部手续!");
					return false;
				}
				
			//董事长意见
			}else if(taskName=='董事长'){
				if(hr_resign_topOpinion==''){
					$.messager.alert("提示!","请切换交接记录填写董事长意见!");
					return false;
				}
				//申请人签字
			}else if(taskName=='申请人签名'){
				if(hr_resign_autoPath==''){
					$.messager.alert("提示!","请切换交接记录填写申请人签字!");
					return false;
				}
				
			//技术部注销账号
			}else if(taskName=='技术部注销账号'){
				if(hr_resign_sysManage==''){
					$.messager.alert("提示!","请填写注销事项!");
					return false;
				}
				
			}
			
			
			
			

			
		
			if (taskName =='技术部注销账号') {
				
			}else{
				if (username ==''|| username==null) {
					$.messager.alert("提示!","请选择审核人!");
					return false;
				}
				
			}
			$.messager.confirm('提示！', '你确定审核吗？', function(r) {
				if (r) {	
				
			$.ajax({
				//几个参数需要注意一下
				type : "POST",//方法类型
				url : "resign_pass.do?" + $('#from1').serialize(),//url
				data : {
					'taskName' : taskName,
					'taskid' : taskid,
					'options': options,
					'username':username,
				},
				success : function(data) {
					
					if (data.Success) {
						$.messager.alert("提示", data.Msg,"info", function() {
							location.href = "findTaskList.do";
								});
				      	}else {
						$.messager.alert("提示", data.Msg,
								"error");
					      }
						

				},
				error : function() {
					alert("异常！");
				}
			});
			}
				
			});

		}
		
		
		function btnAuto(){
			
			location.href="auto.do?hr_resign_id="+${hr_resign_id}+"&hr_resign_autoPath="+$("#hr_resign_autoPath").val();

		}
		
	</script>
</body>
</html>