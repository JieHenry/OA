<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Insert title here</title>

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
<script
	src="<%=request.getContextPath()%>/res/admin/scripts/jquery-easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>

<script
	src="<%=request.getContextPath()%>/res/admin/scripts/admin_grid.js"
	type="text/javascript"></script>
<script
	src="<%=request.getContextPath()%>/res/admin/scripts/ueditor/third-party/codemirror/codemirror.js"
	type="text/javascript"></script>
	
<style type="text/css">
	
	.radio-v2 {
  margin-right: 30px;
  font-weight: normal;
}
.radio-v2 input {
  opacity: 0;
  z-index: 2;
}
.radio-v2 span {
  position: relative;
  display: inline-block;
  vertical-align: top;
  margin-left: -20px;
  width: 20px;
  height: 20px;
  border-radius: 500px;
  border: 1px solid #AAB8D4;
  margin-right: 5px;
  text-align: center;
}
.radio-v2:hover span {
  border-color: #e24a51;
}
.radio-v2 input[type=radio]:checked + span:before {
  position: absolute;
  content: "";
  width: 12px;
  height: 12px;
  top: 50%;
  left: 50%;
  margin-top: -6px;
  margin-left: -6px;
  border-radius: 500px;
  opacity: 1;
  transition: color 0.3s ease-out;
  background-color: #e24a51;
}
.radio-v2 input[type=radio]:checked + span {
  border-color: #e24a51;
}
.radio-v2 input[type=radio]:disabled + span {
  border-color: rgba(162, 162, 162, 0.12) !important;
  cursor: not-allowed;
}
.radio-v2 input[type=radio]:disabled + span:before {
  background-color: rgba(162, 162, 162, 0.12);
}

.datagrid-cell-group{
   color: red;
 }

	</style>
</head>
<body>

	<div style="margin:20px 0;"></div>
	<div>
		<form action="" id="ownhead">
			<div id="panels" class="easyui-panel" title="单据信息"
				style="width:1200px;height:200px;padding:10px;">
				<fieldset id="fd1" style="width:880px;">
					<legend>
						<span>材料信息</span>
					</legend>
					<div>
						<input type="hidden" id="taskid" value="${taskid}"/>
	                 	<input type="hidden" id="taskName" value="${taskName}"/>
					</div>
					<div class="fieldset-body">
						<table class="form-table" border="0" cellpadding="5"
							cellspacing="2">
							<tr>
								<td style="width:150px;display: none"><input
									name="own_purchase_id" id="own_purchase_id"
									class="easyui-textbox" value="${own_purchase_id}" /></td>
								<td style="width:150px;display: none"><input
									name="own_purchase_companyId" id="own_purchase_companyId"
									class="easyui-textbox" value="${own_purchase_companyId}" /></td>
								<td class="form-label" style="width:110px"><a
									style="color: red;" href="javascript:void(0)"
									onclick="wen('companyList.do')">公司信息：</a></td>
								<td style="width:150px"><input id="companyName"
									value="${company_name}" class="easyui-textbox" readonly="readonly"/></td>

							 	<td style="width:150px;display: none"><input
									name="own_purchase_projectId" id="own_purchase_projectId"
									class="easyui-textbox" value="${own_purchase_projectId}" />项目id</td>
								<td class="form-label" style="width:110px;"><a
									style="color: red;" href="javascript:void(0)"
									onclick="wen('projectTableList.do')">项目名称：</a></td>
								<td style="width:150px"><input type="text" readonly="readonly"
									id="construct_project_name" value="${construct_project_name}" class="mini-textbox" /></td>

								<td class="form-label" style="width:60px;">计划员：</td>
								<td style="width:150px"><input type="text"
									value="${own_purchase_planMan}" name="own_purchase_planMan"
									id="own_purchase_planMan" class="mini-textbox" /></td>
							</tr>
						<tr>
								<td class="form-label" style="width:110px;">计划日期：</td>
								<td style="width:150px"><input type="text"
									name="own_purchase_planDate" id="own_purchase_planDate"
									class="easyui-datebox" value="${own_purchase_planDate}" /></td>
								<td class="form-label" style="width:60px;">希望送达时间：</td>
								<td style="width:150px"><input type="text"
									value="${own_purchase_arriveDate}"
									name="own_purchase_arriveDate" id="own_purchase_arriveDate"
									class="easyui-datebox" /></td>
								<td class="form-label" style="width:60px;">品牌：</td>
								<td style="width:150px"><input type="text"
									value="${own_purchase_brand}" name="own_purchase_brand"
									id="own_purchase_brand" class="mini-textbox" /></td>
							</tr>
								<tr>
							<c:if test="${own_purchase_type==1 || own_purchase_type==undefined}">
								<td><label class="radio-v2">
								<input type="radio" name="own_purchase_type" checked value="1">
								<span></span>普通采购</label></td>
							</c:if>
							<c:if test="${own_purchase_type==2}">
								<td><label class="radio-v2">
								<input type="radio" name="own_purchase_type" value="2">
								<span></span>材料采购</label></td>
                          </c:if>
							</tr>

						</table>
					</div>
				</fieldset>
			</div>
			<div id="audit">

				<table id="materialListID" class="easyui-datagrid" title="材料单"
					style="width:1200px;height:auto"
					data-options="
				singleSelect: true,
				toolbar: '#tb',rownumbers:true,
				onClickCell: onClickCell
				">
					<thead>
					  <tr><th data-options="field:'',colspan:6, align:'center',editor:'text'">主管公司</th>
					      <th data-options="field:'',colspan:6, align:'center',editor:'text'">管理公司</th>
					    </tr>
						<tr>
							<th
								data-options="field:'own_purchase_entryId',hidden:'hidden',align:'center',editor:'text'">编号</th>
							<th
								data-options="field:'own_purchase_material',width:80,align:'center',editor:'text'">材料名称</th>
							<th
								data-options="field:'own_purchase_model',width:140,align:'center',editor:'text'">型号规格</th>
							<th
								data-options="field:'own_purchase_unit',width:80,align:'center',editor:'text'">单位</th>
							<th
								data-options="field:'own_purchase_quantities',width:80,align:'center',editor:'text' ">合同工程量</th>
							<th
								data-options="field:'own_purchase_stock',width:80,align:'center',editor:'numberbox'">库存</th>
							<th
								data-options="field:'own_purchase_applyNum',width:80,align:'center',editor:'numberbox'">计划采购量</th>
							<th
								data-options="field:'own_purchase_leastPrice',width:80,align:'center',editor:'text'">最低单价</th>
							<th
								data-options="field:'own_purchase_price',width:80,align:'center',editor:'text'">本次单价</th>
							<th
								data-options="field:'own_purchase_purchaseTotal',width:80,align:'center'" formatter="sum">小计</th>
							<th
								data-options="field:'own_purchase_remarks',width:80,align:'center',editor:'text'">备注</th>
							<th data-options="field:'operation',width:120,align:'center'" formatter="operate_formatter">操作</th>
						</tr>
					</thead>
				</table>

				<div id="tb" style="height:auto">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true" onclick="add()">添加</a>

				</div>
				<!-- 打开子框开始 -->
				<div id="centers" class="easyui-window"
					data-options="region:'center',title:'请选择值'" closed="true"
					style="height: 500px; width: 800px"></div>
				<!-- 打开子框结束 -->
				<br>
			<div>
			
		<input  class="easyui-textbox" id="options" label="个人原因：" labelPosition="top" multiline="true" style="width:1200px;height:120px">
			</div>
				<div >
					<div style="float: left; padding-top: 4px">
					 <c:if test="${taskName !='采购输出' && taskName !='董事长'}">
						<select  id="username_id" style="width:120px;height: 32px">  	     
						      <c:forEach items="${userList}" var="user">
									<option value="${user.userid}">${user.username}</option>
								</c:forEach>	
						</select>
						</c:if>
					</div>
				
					<div>
					 <div style="padding-top: 4px">&nbsp;
                              <a href="#" class="easyui-linkbutton" style="width:5%;height:32px;background:#D8BFD8"onclick="btnSave('true')">同意</a> &nbsp;
                            <c:if test="${taskName !='申请人' && taskName !='采购输出'}">
							  <a class="easyui-linkbutton" style="width:5%;height:32px"onclick="btnSave('false')">不同意</a>
							</c:if>
                    </div>
                  
					 </div>
				</div>
			</div>
		</form>
	<div>
	<div style="margin:4px 0;">		
	<table id="history" class="easyui-datagrid" title="审批记录"
			style="width:1200px;height:150px"
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
	</div>
	<script type="text/javascript">
    
		var editIndex = undefined;
		$(function() {
			//单选框赋值
			var car=${own_purchase_type==undefined?1:own_purchase_type};
			$("input[name='own_purchase_type'][value="+car+"]").attr("checked",true);
			//加载数据
			$('#materialListID').datagrid('loadData',${jsonObject});
			$('#history').datagrid('loadData',${historyList});
			//单元格编辑
			$.extend($.fn.datagrid.methods, {
				editCell : function(jq, param) {
					return jq.each(function() {
						var fields = $(this).datagrid('getColumnFields', true)
								.concat($(this).datagrid('getColumnFields'));
						for (var i = 0; i < fields.length; i++) {
							var col = $(this).datagrid('getColumnOption',
									fields[i]);
							col.editor1 = col.editor;
							if (fields[i] != param.field) {
								col.editor = null;
							}
						}
						$(this).datagrid('beginEdit', param.index);
						for (var i = 0; i < fields.length; i++) {
							var col = $(this).datagrid('getColumnOption',
									fields[i]);
							col.editor = col.editor1;
						}
					});
				}
			});

		});
		
		function operate_formatter(value, row, index) {
			var headId=row.own_purchase_entryId;
			var html = "";
			if(${taskName=='申请人'}){
			html += '<a href="javascript:;" class="opt" onclick="deleteEntry('+headId+')" data-options=plain:true"  cmd="delete" i="' + index + '">删除</a>';
			}
			return html;
		}     
		//监听行内编辑
		function onClickCell(index, field){
			if (endEditing()){
				$('#materialListID').datagrid('selectRow', index)
						.datagrid('editCell', {index:index,field:field});
				editIndex = index;
			}
		}
		//添加行
		function add() {
			//	$('#centers').window('open');
			$('#materialListID').datagrid('appendRow', {
				status : 'P'
			});
			editIndex = $('#materialListID').datagrid('getRows').length - 1;
			$('#materialListID').datagrid('selectRow', editIndex).datagrid(
					'beginEdit', editIndex);
		}

		//打开子窗口
		function wen(src) {
			var hrefs = "<iframe id='son' src='"
					+ src
					+ "' allowTransparency='true' style='border:0;width:99%;height:99%;padding-left:2px;' frameBorder='0'></iframe>";
			$("#centers").html(hrefs);
			$("#centers").window("open");
		}

		//公司信息赋值
		function data(rowData) {
			var company_name = rowData.company_name === undefined ? ""
					: rowData.company_name;
			$("#companyName").textbox("setValue",company_name);
			
			$("#own_purchase_companyId").val(rowData.company_id);
		}
		//项目名称赋值
		function projectTable(rowData) {
			var project_name = rowData.construct_project_name;
			var project_id = rowData.construct_project_id;
			$("#own_purchase_projectId").val(project_id);
			$("#construct_project_name").val(project_name);
			$("#centers").window("close");
		}

		//是否编辑结束
		function endEditing() {
			if (editIndex == undefined) {
				return true;
			}
			if ($('#materialListID').datagrid('validateRow', editIndex)) {
				$('#materialListID').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		//审核单据
		function btnSave(sign) {
			$('#materialListID').datagrid('acceptChanges');
			var rows = $('#materialListID').datagrid('getRows');
		    var own_purchase_id =$("#own_purchase_id").val();
			var taskName=$("#taskName").val();
			var taskid=$("#taskid").val();
			var username=$("#username_id").val();
			var options=$("#options").val().trim();
			var	companyName	=$("#companyName").val();
		      if(options==''){
		    	  $.messager.alert("提示","意见不能为空!", "info");
		    	  return;
		      }
			$.messager.confirm('提示！', '你确定提交吗？', function(r){
				if (r){
					$.messager.progress({
						title : '提示',
						msg : '正在处理中，请稍候……',
						text : ''
					});
			$.ajax({
				url : "ownHeadPass.do?=" + $("#ownhead").serialize(),
				type : 'POST',
				data : {
					'rows' : JSON.stringify(rows),
					'taskid':taskid,
					'username' : username,
					'taskName' : taskName,
					 'sign': sign,
					 'own_purchase_id':own_purchase_id,
					 'options': options,
					 'companyName': companyName,
				},
				success : function(data) {
					
					 $.messager.progress('close');
						if (data.Success) {
							$.messager.alert("提示", data.Msg, "info", function() {
								location.href="findTaskList.do";
								});
							
						} else {
							$.messager.alert("提示", data.Msg, "error");

						}
				   }
			    });
			   }
			});
		}
		
		//删除
		function deleteEntry(entryId) {
			$.messager.confirm('提示！', '你确定提交吗？', function(r){
				if (r){
					$.messager.progress({
						title : '提示',
						msg : '正在处理中，请稍候……',
						text : ''
					});
			$.ajax({
				url : "deleteOwnEntry.do",
				type : 'POST',
				data : {
					'type':'entry',
					 'entryId':entryId,
				},
				success : function(data) {
					
					 $.messager.progress('close');
						if (data.Success) {	
						window.location.reload(true);		
						} else {
							$.messager.alert("提示", data.Msg, "error");

						}
				   }
			    });
			   }
			});
		}
		
		  //技算单价
		function sum(value, row, index){
			 var own_purchase_applyNum =row.own_purchase_applyNum;
			 var own_purchase_price=row.own_purchase_price;
	  if(own_purchase_applyNum !=undefined &&own_purchase_price != undefined){
		var sum= own_purchase_price*own_purchase_applyNum;
		sum = sum.toFixed(2); 
		 return sum;
	  }else{
		  return 0;
	  }
	
		}
		
	</script>
</body>
</html>