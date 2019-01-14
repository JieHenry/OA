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

</head>
<body class="easyui-layout" style="overflow-y: hidden;" scroll="no">
	<form id="form1" method="post">
		<div id="main" region="center"
			style="background: #eee; padding: 5px; overflow-y: hidden;">
			<div class="easyui-layout" fit="true">
				<div region="north" split="false" border="false"
				style="overflow: hidden; padding: 5px 5px 28px 5px;">
				<div class="easyui-panel" title="查询条件" style="margin-bottom: 5px;">

					<div class="search">
						<ul>
							<li><label>公司：</label><input type="text"
								name="achReview_company" id="achReview_company"
								class="easyui-validatebox" style="width: 120px" /></li>
							<li><label>月份：</label><input type="text"
								name="achReview_month" id="achReview_month"
								class="easyui-validatebox" style="width: 120px" /></li>	
							<li>&nbsp;&nbsp; <a class="easyui-linkbutton"
								data-options="iconCls:'icon-search'" href="javascript:;"
								id="btnSearch">查询</a></li>
							<li>&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
								iconCls="icon-cancel" plain="true" onclick="btnDele();">删除</a></li>
							<li>&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
								iconCls="icon-edit" plain="true" onclick="btnEdit();">修改</a></li>
							<li>&nbsp;&nbsp; <a href="#" class="easyui-linkbutton"
								iconCls="icon-add" plain="true" onclick="btnAdd();">新增</a></li>
						</ul>
						<div class="clear"></div>
					</div>
				</div>
			</div>


				<div region="center" split="false" border="false"
					style="overflow: hidden; padding: 0 5px 5px 5px" >
					<table id="data" title="" fit="true"
						data-options="collapsible: true,pagination:true,rownumbers:true">
						<thead>
							<tr>
								<th  halign="center" field="achReview_id" align="center"  hidden="hidden"
									sortable="true" width="60px">单据id</th>
								<th  halign="center" field="achReview_company" align="center"
									sortable="true" width="60px">考核公司</th>
								<th halign="center" field="achReview_month" align="center"
									sortable="true" width="120px">月份</th>
								<th halign="center" field="achReview_creatDate" align="center" 
									sortable="true" width="150px" formatter="dateformat">创建时间</th>
								<th halign="center" field="psn" align="center" sortable="true"
									width="120px" formatter="operate_formatter">操作</th>
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

			html += '<a href="javascript:;" class="opt"    cmd="view" i="' + index + '">查看</a>';
		
			return html;
		}

		function btnAdd() {
			location.href = "achReviewNew.do?achReview_id=";
		}
		
		function btnEdit() {
			
			var rows = $("#data").datagrid("getSelections");
			if(rows.length==0){
				alert("请选择要修改行！");
			}else if(rows.length>1){
				alert("只能选中一行！");
			}else{
				location.href = "achReviewNew.do?achReview_id="+rows[0].achReview_id+"";
			}
		}
		

		/***处理操作列的功能***/
		function cmdHanlder(cmd, row) {
			if (cmd == "view") {
				location.href = "achReviewView.do?bizId="+row.achReview_id+"";

			}
		}

		//批量删除处理
		function btnDele() {
			var rows = $("#data").datagrid("getSelections");
			if(rows.length==0){
				alert("请选择要删除行！");
			}else if(rows.length>1){
				alert("只能选中一行！");
			}else{
				var achReview_id = rows[0].achReview_id;
				$.messager.confirm("操作提示", "您确定要执行操作吗？", function(r) {
					if (r) {
						$.ajax({
							type : 'POST',
							url : 'delect_achReview.do',
							data : {
								'achReview_id' : achReview_id
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