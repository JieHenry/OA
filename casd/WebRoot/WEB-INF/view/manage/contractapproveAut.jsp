<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="PowerCheck" prefix="shop"%>
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

</head>
<body>

	<div style="float:left;">
	<fieldset id="fd1" style="width:900px;">
			<legend>
				<span>合同信息</span>
			</legend>
		<div class="fieldset-body">
				<form id="jvForm" method="post">
				<input type="hidden" id="taskid"  value="${taskid}"/>
					<%-- <table class="form-table" border="0" cellpadding="5"
						cellspacing="2">
						
						<tr>
						
							<td class="form-label" style="width:60px;display: none">合同id：</td>
							<td style="width:150px;display: none"><input 
								name="manage_contractapprove_id" id="manage_contractapprove_id"
								class="mini-textbox" readonly="readonly"
								value="${contractapprove.manage_contractapprove_id}" /></td>
							<td class="form-label" style="width:110px;">合同编号：</td>
							<td style="width:150px"><input type="text" readonly="readonly"
								name="manage_contractapprove_num" readonly="readonly"
								id="manage_contractapprove_num" class="mini-textbox" 
								value="${contractapprove.manage_contractapprove_num}" /></td>
							<td class="form-label" style="width:110px;">项目名称：</td>
							<td style="width:150px"><input type="text" readonly="readonly"
								value="${contractapprove.manage_contractapprove_name}"
								name="manage_contractapprove_name"
								id="manage_contractapprove_name" class="mini-textbox" /></td>
							<td class="form-label" style="width:110px;">所属公司：</td>

							<td style="width:150px"><select
								id="manage_contractapprove_company"   disabled="disabled"
								name="manage_contractapprove_company" style="width:142px;">
									<option value="0">请选择</option>
									<option value="1">建设公司</option>
									<option value="2">科技公司</option>
									<option value="3">加盟合作</option>
							</select></td>

						</tr>
						<tr>
							<td class="form-label" style="width:110px;">发包方（甲方）：</td>
							<td style="width:150px"><input type="text" readonly="readonly"
								value="${contractapprove.manage_contractapprove_firstParty}"
								name="manage_contractapprove_firstParty"
								id="manage_contractapprove_firstParty" class="mini-textbox" /></td>

							<td class="form-label" style="width:110px;">合同金额：</td>
							<td style="width:150px"><input type="text" readonly="readonly"
								value="${contractapprove.manage_contractapprove_amount}"
								name="manage_contractapprove_amount"
								id="manage_contractapprove_amount" class="mini-textbox" /></td>
							<td class="form-label" style="width:110px;">项目地址：</td>
							<td style="width:150px"><input type="text" readonly="readonly"
								value="${contractapprove.manage_contractapprove_address}"
								name="manage_contractapprove_address"
								id="manage_contractapprove_address" class="mini-textbox" /></td>
						</tr>

						<tr>
							<td class="form-label" style="width:110px;">合同开始时间：</td>
							<td style="width:150px"><input type="text"
								class="easyui-datebox" readonly="readonly"
								value="${contractapprove.manage_contractapprove_startTime}"
								name="manage_contractapprove_startTime"
								id="manage_contractapprove_startTime" class="mini-textbox" /></td>

							<td class="form-label" style="width:110px;">合同结束时间：</td>
							<td style="width:150px"><input type="text"
								class="easyui-datebox" readonly="readonly"
								value="${contractapprove.manage_contractapprove_endTime}"
								name="manage_contractapprove_endTime"
								id="manage_contractapprove_endTime" class="mini-textbox" /></td>
							<td class="form-label" style="width:110px;">备注：</td>
							<td style="width:150px"><input type="text" readonly="readonly"
								value="${contractapprove.manage_contractapprove_remark}"
								name="manage_contractapprove_remark"
								id="manage_contractapprove_remark" class="mini-textbox" /></td>
						</tr>

					</table>
 --%>
					
					<table class="form-table" border="0" cellpadding="5"
						cellspacing="2">
						<tr>
							<td class="form-label" style="width:60px;display: none">合同id：</td>
							<td style="width:150px;display: none"><input
								name="manage_contractapprove_id" id="manage_contractapprove_id"
								class="mini-textbox"
								value="${contractapprove.manage_contractapprove_id}" /></td>
							<td class="form-label" style="width:110px;display: none">合同编号：</td>
							<td style="width:150px;display: none"><input type="text"
								name="manage_contractapprove_num" readonly="readonly"
								id="manage_contractapprove_num" class="mini-textbox" 
								value="${contractapprove.manage_contractapprove_num}" /></td>
							<td class="form-label" style="width:110px;">项目名称：</td>
							<td style="width:150px"><input type="text"
								value="${contractapprove.manage_contractapprove_name}"
								name="manage_contractapprove_name"
								id="manage_contractapprove_name" class="mini-textbox" /></td>
							<td class="form-label" style="width:110px;">所属公司：</td>

							<td style="width:150px"><select
								id="manage_contractapprove_company"
								name="manage_contractapprove_company" style="width:142px;">
									<option value="0">请选择</option>
									<option value="1">建设公司</option>
									<option value="2">科技公司</option>
									<option value="3">加盟合作</option>
									<option value="4">诚安教育</option>
									<option value="5">传诚管理</option>
							</select></td>
							
							<td class="form-label" style="width:110px;">项目地址：</td>
							<td style="width:150px"><input type="text"
								value="${contractapprove.manage_contractapprove_address}"
								name="manage_contractapprove_address"
								id="manage_contractapprove_address" class="mini-textbox" /></td>
							
						</tr>
						<tr>
							<td class="form-label" style="width:110px;">发包方（甲方）：</td>
							<td style="width:150px"><input type="text"
								value="${contractapprove.manage_contractapprove_firstParty}"
								name="manage_contractapprove_firstParty"
								id="manage_contractapprove_firstParty" class="mini-textbox" /></td>

							<td class="form-label" style="width:110px;">合同金额（元）：</td>
							<td style="width:150px"><input type="text"
								value="${contractapprove.manage_contractapprove_amount}"
								name="manage_contractapprove_amount"
								id="manage_contractapprove_amount" class="mini-textbox" /></td>
							<%-- <td class="form-label" style="width:110px;">项目地址：</td>
							<td style="width:150px"><input type="text"
								value="${contractapprove.manage_contractapprove_address}"
								name="manage_contractapprove_address"
								id="manage_contractapprove_address" class="mini-textbox" /></td> --%>
							 <td style="text-align:left">
					            <span class="radioSpan">
					                <input id="manage_contractapprove_taxIncluded1" type="radio" name="manage_contractapprove_taxIncluded" checked="checked" value="1"><label>含税</label></input>
                        			<input id="manage_contractapprove_taxIncluded2" type="radio" name="manage_contractapprove_taxIncluded" value="2"><label>不含税</label></input>
					            </span>
					        </td>
						</tr>

						<tr>
							<td class="form-label" style="width:110px;">乙方：</td>
							<td style="width:150px"><input type="text"
								value="${contractapprove.manage_contractapprove_secondParty}"
								name="manage_contractapprove_secondParty"
								id="manage_contractapprove_secondParty" class="mini-textbox" /></td>
							
							<td class="form-label" style="width:110px;">合同开始时间：</td>
							<td style="width:150px"><input type="text"
								class="easyui-datebox"
								value="${contractapprove.manage_contractapprove_startTime}"
								name="manage_contractapprove_startTime"
								id="manage_contractapprove_startTime" class="mini-textbox" /></td>

							<td class="form-label" style="width:110px;">合同结束时间：</td>
							<td style="width:150px"><input type="text"
								class="easyui-datebox"
								value="${contractapprove.manage_contractapprove_endTime}"
								name="manage_contractapprove_endTime"
								id="manage_contractapprove_endTime" class="mini-textbox" /></td>
							
						</tr>
						
						
					</table>
					<table>
					<tr>
							<td class="form-label" style="width:120px;">备注：</td>
							<td style="width:150px"><textarea style="width:710px" rows="3"
								name="manage_contractapprove_remark"
								id="manage_contractapprove_remark" class="mini-textbox" >${contractapprove.manage_contractapprove_remark}</textarea></td>
						</tr>
					</table>
					<table>
					<tr>
						<td class="form-label" style="width:120px;">付款比例：</td>
							<td ><textarea  style="width:710px" rows="3"
								name="manage_contractapprove_payment"
								id="manage_contractapprove_payment" class="mini-textbox" >${contractapprove.manage_contractapprove_payment}
								</textarea></td>
					</tr>
					</table>
					
					<table>
						<tbody>

							<tr>
								<td hidden="hidden"><input type="text" id="bizId"
									value="${bizId}"></td>
									
								<td class="form-label" style="display: none">附件地址：</td>
								<td style="display: none"><input type="text"
									value="${contractapprove.manage_contractapprove_attachAddress}"
									name="manage_contractapprove_attachAddress"
									id="manage_contractapprove_attachAddress" class="mini-textbox" /></td>
									
								<td width="80%"><input name="contractFile" type="file"
									id="contractFile" /> <a class="easyui-linkbutton" 
									onclick="uploadPic();" href="javascript:;" id="btnSaveExp">上传</a>
									
								<a id="loadfied" class="easyui-linkbutton" onclick="loadSeries()">下载附件</a>
									
								</td>

							</tr>

						</tbody>
					</table>

				</form>
			</div>
       </fieldset>
		<div style="width:905px;">
			<tr>
				<td><c:forEach var="bot" items="${botlist}">
						<td style="align:center"><c:if test="${bot != '驳回'}">
								<h2>${bot}:</h2>
							</c:if>
					</c:forEach> <select id="username_id"
					style="width:120px;font-size:12px;height:24px;">
						<c:forEach items="${userList}" var="user">
							<option value="${user.userid}">${user.username}</option>
						</c:forEach>


				</select></td>


				<td><h2>意见：</h2> <textarea
						style="width:900px;height:100px;resize:none;" type="text" name=""
						id="options"></textarea></td>
			</tr>
			<div style="text-align: right;margin-top:5px;">
				<td style="width:150px"><input id="bot" onclick="cttp_pass()"
					type="button" value="${bot}"> <c:if
						test="${both !=undefined}">
						<input class="both" onclick="rejects()" type="button"
							value="${both}">
					</c:if></td>
			</div>
		</div>
		<div style="margin:20px 0;">

			<table id="history" class="easyui-datagrid" title="审批记录"
				style="width:905px;height:150px"
				data-options="
				iconCls: 'icon-edit',
				singleSelect: true,">
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
	</div>

	<script
		src="<%=request.getContextPath()%>/res/jquery-easyui/wangEditor/release/rejects.js"
		type="text/javascript"></script>
	<!--  引入封装驳回功能  ajax -->
	<script type="text/javascript">
		$(document).ready(function() {
			$("#manage_contractapprove_company").val(${contractapprove.manage_contractapprove_company});
			if(${contractapprove.manage_contractapprove_taxIncluded}==1){
		        $("input[name='manage_contractapprove_taxIncluded']").get(0).checked=true;

			}else{
		        $("input[name='manage_contractapprove_taxIncluded']").get(1).checked=true;

			}
			//加载历史记录
			var historys = ${history}.history;
			$('#history').datagrid('loadData', historys);
		});
		//取消
		function btnCancel() {
			location.href = "contractapproveList.do?";
		}

		//保存
		function cttp_pass() {
			var userid = $("#username_id").val();
			var taskName = $("#taskName").val(); //获取节点名称
			var options = $("#options").val();
			var taskid = $("#taskid").val();
			if (options == "") {
				$.messager.alert("提示", "请填写审核意见");
				return false;

			}

			if (taskName == '输出盖章') {
			} else {
				if (userid == '') {
					$.messager.alert("提示", "请选择审核人");
					return false;

				}

			}
			 $.messager.confirm('提示！', '你确定提交吗？', function(r) {
				if (r) {	
				 $.messager.progress({ 
				       title: '提示', 
				       msg: '正在处理中，请稍候……', 
				       text: '' 
				    });
			$.ajax({
				type : 'POST',
				url : 'contractapprovePass.do',

				data : {
					'options' : options,
					'username' : userid,
					'taskName' : taskName,
					'taskid' : taskid

				},
				success : function(data) {
					 $.messager.progress('close');
					if (data.Success) {

						$.messager.alert("提示", data.Msg, "info", function() {
							location.href = "findTaskList.do";
						});
					} else {

						$.messager.alert("操作提示", data.Msg, "error");
					}

				}

			});}
			 });
		}

		/**
		* 驳回
		*/
		function rejects() {
			var options = $("#options").val();
			var taskid = $("#taskid").val();
			if (options == '') {
				alert("意见不能为空!");
				return false;
			}
			$.ajax({
				type : "POST",
				url : "rejects.do",
				data : {
					'taskid':taskid,
                	'options' : options,
				},
				success : function(data) {
					
					if (data.Success) {
                            $.messager.alert("提示", data.Msg, "info", function() {
							location.href = "findTaskList.do";
						});
					} else {

						$.messager.alert("操作提示", data.Msg, "error");
					}

			

				}
			});

		}
		//提交
		function uploadPic() {
			var formData = new FormData(document.getElementById("jvForm"));
			$.ajax({
				url : 'save_conApprove.do',
				type : 'POST',
				data : formData,
				async : false,
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) {
					alert(data.Msg);
					location.reload();
				},
				error : function(data) {
					alert(data.Msg);
				}
			});

		}

		function loadSeries() {
			var attachAddress=$('#manage_contractapprove_attachAddress').val();
			var form = $("<form>");
			$('body').append(form);
			form.attr('style', 'display:none');
			form.attr('target', '');
			form.attr('method', 'post');
			form.attr('action', "downloadCon.do?attachAddress="+attachAddress);//下载文件的请求路径  

			form.submit();

		}
	</script>
</body>
</html>