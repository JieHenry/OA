<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<style>
		.datagrid-cell-c1-manage_status{
			color:red ;
		}
	</style>
</head>
<body class="easyui-layout" style="overflow-y: hidden;" scroll="no">
	<form id="form1" method="post">
		<div id="main" region="center"
			style="background: #eee; padding: 5px; overflow-y: hidden;">
			<div class="easyui-layout" fit="true">
				<div region="north" split="false" border="false"
				style="overflow: hidden; padding: 5px 5px 25px 5px;">
				<div class="easyui-panel" title="查询条件" style="margin-bottom: 5px;">

					<div class="search">
						<ul>
							
							<li><label>年度：</label>
							<select  id="yearMon" name="yearMon"  style="width:110px;">
								<option value="0" selected>请选择</option>
								<c:forEach items="${yearMon}" var="y">
									<option value="${y.yearMon}">${y.yearMon}</option>
								</c:forEach>
							</select>
							</li>
							
							<li style="display: none"><label>合同编号：</label><input type="text"
								name="manage_contractapprove_num" id="manage_contractapprove_num"
								class="easyui-validatebox" style="width: 120px" /></li>
							<li><label>项目名称：</label><input type="text"
								name="manage_contractapprove_name" id="manage_contractapprove_name"
								class="easyui-validatebox" style="width: 120px" /></li>
							<li style="display: none"><label>公司名称：</label><input type="text"
								name="manage_contractapprove_company" id="manage_contractapprove_company"
								class="easyui-validatebox" style="width: 120px" /></li>		
								
							<li>&nbsp;&nbsp; <a class="easyui-linkbutton"
								data-options="iconCls:'icon-search'" href="javascript:;"
								id="btnSearch">查询</a></li>
							<!-- <li>&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
								iconCls="icon-cancel" plain="true" onclick="btnDele();">删除</a></li> -->
							<li>&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
								iconCls="icon-edit" plain="true" onclick="btnEdit();">修改</a></li>
							<li>&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
								iconCls="icon-add" plain="true" onclick="btnAdd();">新增</a></li>
						</ul>
						<div class="clear"></div>
						<div >
							<ul>
								<li> <a href="#" class="easyui-linkbutton"
									 onclick="btnCompany('builder');">建设公司</a></li>
							</ul>
							<ul>
								<li> <a href="#" class="easyui-linkbutton"
									 onclick="btnCompany('science');">科技公司</a></li>
							</ul>
							<ul>
								<li> <a href="#" class="easyui-linkbutton"
									 onclick="btnCompany('join');">加盟合作</a></li>
							</ul>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>


				<div region="center" split="false" border="false"
					style="overflow: hidden; padding: 0 5px 5px 5px" >
					<table id="data" title="" fit="true"
						data-options="collapsible: true,pagination:true,rownumbers:true,onDblClickRow:onDblClickRow">
						<thead>
							<tr>
								<th halign="center" field="manage_contractapprove_id" align="center"  hidden="hidden"
									sortable="true" width="60px">单据id</th>
								<th halign="center" field="manage_contractapprove_num" align="center" hidden="hidden"
									sortable="true" width="80px">合同编号</th>
								<th halign="center" field="manage_contractapprove_name" align="center"
									sortable="true" width="150px">项目名称</th>
								<th halign="center" field="manage_contractapprove_firstParty" align="center" 
									sortable="true" width="150px" >发包方（甲方）</th>
								<th halign="center" field="manage_contractapprove_address" align="center" 
									sortable="true" width="280px" >项目地址</th>
								<th halign="center" field="manage_contractapprove_startTime" align="center" 
									sortable="true" width="80px" >合同开始时间</th>
								<th halign="center" field="manage_contractapprove_endTime" align="center" 
									sortable="true" width="80px" >合同结束时间</th>
								<th halign="center" field="manage_contractapprove_amount" align="right" 
									sortable="true" width="80px" >合同金额</th>		
								<th halign="center" field="manage_contractapprove_attachAddress" align="right" 
									sortable="true" width="120px" >附件地址</th>	
								<th halign="center" field="manage_contractapprove_remark" align="center" 
									sortable="true" width="150px" >备注</th>	
								<th halign="center" field="manage_status" align="center" 
									 width="80px" formatter="operate_status">状态</th>						
								<th halign="center" field="psn" sortable="true"
									width="40px" formatter="operate_formatter">操作</th>
							</tr>
						</thead>
					</table>
				</div>

			</div>
		</div>
	</form>
	<script type="text/javascript">
		function operate_formatter(value, row, index) {
			var html = "";
			
	/* 	if(row.manage_status==0){ */
			html += '<a href="javascript:;" class="opt"    cmd="view" i="' + index + '">查看</a>';
			/*html += '<a href="javascript:;" class="opt"    cmd="view" i="' + index + '">查看</a>&nbsp;';
			 html += '<a href="javascript:;" class="opt"    cmd="delete" i="' + index + '">删除</a>'; */
	/* 	} */
			return html;
		}
		
		
		function operate_status(value, row, index){

              		if (value == 0) {
              			
						return "数据已录入";
					} else if (value == 1) {
						return "审核中";
					} else if (value ==3) {
						return "通过审核";
					}
				
		}
		
		function btnCompany(obj){
			if(obj==='builder'){
				$("#manage_contractapprove_company").val("1");
			}else if(obj==='science'){
				$("#manage_contractapprove_company").val("2");
			}else{
				$("#manage_contractapprove_company").val("3");
			}
			
			//IE
			if (document.all) {
				document.getElementById("btnSearch").click();
			}
			// 其它浏览器
			else {
				var e = document.createEvent("MouseEvents");
				e.initEvent("click", true, true); //这里的click可以换成你想触发的行为
				document.getElementById("btnSearch").dispatchEvent(e); //这里的clickME可以换成你想触发行为的DOM结点
			}
		}
		
		
		
		function btnAdd() {
			location.href = "contractapproveNew.do?manage_contractapprove_id=";
		}
		
		function btnEdit() {
			
			var rows = $("#data").datagrid("getSelections");
			if(rows.length==0){
				alert("请选择要修改行！");
			}else if(rows.length>1){
				alert("只能选中一行！");
			}else if(rows[0].manage_status!=0){
				alert("审核中不可修改！");
			}else{
				location.href = "contractapproveNew.do?manage_contractapprove_id="+rows[0].manage_contractapprove_id+"&type='update'";
			}
		}
		

		/***处理操作列的功能***/
		function cmdHanlder(cmd, row) {
			if (cmd == "view") {
				location.href = "contractapproveNew.do?manage_contractapprove_id="+row.manage_contractapprove_id+"&type='view'";
			}
		}

		//删除处理
		function btnDele() {
			var rows = $("#data").datagrid("getSelections");
			if(rows.length==0){
				alert("请选择要删除行！");
			}else if(rows.length>1){
				alert("只能选中一行！");
			}else{
				var manage_contractapprove_id = rows[0].manage_contractapprove_id;
				$.messager.confirm("操作提示", "您确定要执行操作吗？", function(r) {
					if (r) {
						$.ajax({
							type : 'POST',
							url : 'delete_Contractapprove.do',
							data : {
								'manage_contractapprove_id' : manage_contractapprove_id
							},
							success : function(data) {
								if (data.msg!=undefined) {
									  $.messager.alert("操作提示", data.msg,"error");
									  $('#data').datagrid('reload');
								} else {
									 $.messager.alert("操作提示","操作成功！");
									 $('#data').datagrid('reload');
								}
								}
						});
					}
				});
		    }
		}
		
		//双击选择
		function onDblClickRow(rowIndex, rowData) {
			$(window.parent.window.getData(rowData));
			$(window.parent.$("#win").window("close"));
		}
		
		
		$(function() {
			$("#data").admin_grid({
				queryBtn : "#btnSearch",
				excelBtn : "#btnExcel",
				cmdHanlder : cmdHanlder,

			});
		});
	</script>

</body>
</html>
  

