<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="PowerCheck" prefix="shop"%>

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
<body class="easyui-layout" style="overflow-y: hidden;" scroll="no">
	<form id="form1" method="post">
		<div id="main" region="center"
			style="background: #eee; padding: 5px; overflow-y: hidden;">
			<div class="easyui-layout" fit="true">
				<div region="north" split="false" border="false"
					style="overflow: hidden; padding: 5px 5px 2px 3px;">

					<div class="search">
						<ul>
							<li><label>菜单编号：</label><input type="text" name="searchId"
								id="searchId" value="" class="easyui-validatebox"
								style="width: 120px" /></li>
							<li><label>菜单名：</label><input type="text" name="searchName"
								id="searchName" value="" class="easyui-validatebox"
								style="width: 120px" /></li>
							<li><label>父级菜单：</label><input type="text" name="parent_id"
								value="" class="easyui-validatebox"
								style="width: 120px" /></li>

							<li>&nbsp;&nbsp; <a class="easyui-linkbutton"
								data-options="iconCls:'icon-search'" href="javascript:;"
								id="btnSearch">查询</a></li>
						</ul>
					</div>
					<br />

					<div>
						<ul>
							<li style="list-style:none;"><shop:permission
									code="NEW_MENU">
									<a id="btnNew" class="easyui-linkbutton" iconCls="icon-add"
										plain="true">新增菜单</a>
									<a id="btnUpdate" class="easyui-linkbutton" iconCls="icon-edit"
										plain="true">修改菜单</a>

									<a id="btnDele" class="easyui-linkbutton" iconCls="icon-cut"
										plain="true">删除菜单</a>
								</shop:permission></li>
						</ul>
					</div>
				</div>


				<div region="center" split="false" border="false"
					style="overflow: hidden; padding: 0px 5px 5px 5px" id="dataList">
					<div class="newAdd" style="display: none">
						<table style="border: 1px solid #151515">
							<tr>
								<td style="display: inline;display:none"><span
									style="display: inline-block; width: 60px">菜单编号:</span> <input
									id="menuid" type="text" name="menuid" value=""></td>
								<td style="display: inline;"><span
									style="display: inline-block; width: 60px">菜单名:</span> <input
									id="menuname" type="text" name="menuname" value=""></td>
								<td style="display: inline;"><span
									style="display: inline-block; width: 90px">父级菜单编号:</span> <input
									id="parent" type="text" name="parent" value=""></td>
								<td style="display: inline;"><span
									style="display: inline-block; width: 60px">菜单url:</span> <input
									id="url" type="text" name="murl" value=""></td>
								<td style="display: inline;"><span
									style="display: inline-block; width: 60px">菜单顺序:</span> <input
									id="ord" type="text" name="ord" value=""></td>
								<td style="display: inline;"><span
									style="display: inline-block; width: 60px">权限编号:</span> <input
									id="program_code" type="text" name="program_code" value=""></td>
								<td style="display: inline;"><span
									style="display: inline-block; width: 70px">是否菜单项:</span> <select
									id="sid" onchange="selectcity()">
										<option value="1">是</option>
										<option value="2">否</option>
								</select></td>
							</tr>
							<tr>
								<td style="align:center"><a class="easyui-linkbutton"
									href="javascript:;" id="btnSave">提交</a>
									&nbsp;&nbsp;&nbsp;&nbsp; <a class="easyui-linkbutton"
									href="javascript:;" id="btnCancel">取消</a></td>
							</tr>
						</table>
					</div>

					<table id="data" title="" fit="true"
						data-options="collapsible: true,pagination:true,rownumbers:true">
						<thead>
							<tr>
								<th halign="center" field="id" align="center" sortable="true"
									width="60px">菜单编号</th>
								<th halign="center" field="menu_name" align="center"
									sortable="true" width="120px">菜单名</th>
								<th halign="center" field="parent_id" align="center"
									sortable="true" width="120px">父级菜单编号</th>
								<th halign="center" field="menu_url" align="center"
									sortable="true" width="120px">菜单url</th>
								<th halign="center" field="order" align="center" sortable="true"
									width="120px">菜单顺序</th>
								<th halign="center" field="ismenu" align="center"
									sortable="true" width="120px" formatter="is_formatter">是否菜单项</th>

								<th halign="center" field="program_code" align="center"
									sortable="true" width="120px">权限编号</th>

							</tr>
						</thead>
					</table>
				</div>
			</div>

		</div>
	</form>


	<script type="text/javascript">
		/***处理操作列的功能***/
		function cmdHanlder(cmd, row) {
			$.ajax({
				url : "aa.do",
				type : "POST",
				success : function(data) {
					alert("审批成功");
					$("#data").datagrid("reload");

				}
			});
		}

		$(function() {
			$("#data").admin_grid({
				queryBtn : "#btnSearch",
				excelBtn : "#btnExcel",
				cmdHanlder : cmdHanlder,
			});

		});

		function is_formatter(value, row, index) {
			if (value == 1) {
				return "是";
			} else if (value == 2) {
				return "否";

			}
		}

		$(document).ready(function() {
			//按钮新增
			$("#btnNew").click(function() {
				if ($("#menuid").val() != "") {
					$("#menuid").attr("value", "");
					$("#menuname").attr("value", "");
					$("#parent").attr("value", "");
					$("#url").attr("value", "");
					$("#ord").attr("value", "");
				}
				$(".newAdd").show();
			});
			//按钮提交
			$("#btnSave").click(function() {
				var menuid = $("#menuid").val();
				var menuname = $("#menuname").val();
				var parent = $("#parent").val();
				var url = $("#url").val();
				var ord = $("#ord").val();
				var code = $("#program_code").val();
				/* var ismenu=$("#sid").val(); */
				var ismenu = $("#sid option:selected").val();
				if (menuname == "") {
					alert("菜单名不能为空");
				}

				$.ajax({
					type : 'POST',
					url : 'addMenu.do',
					data : {
						'menuid' : menuid,
						'menuname' : menuname,
						'parent' : parent,
						'url' : url,
						'ord' : ord,
						'ismenu' : ismenu,
						 'code':code
					},

					success : function(data) {
						if (data == "") {
							$(".newAdd").hide();
							location.reload();
						} else {
							alert("提交失败");
						}
					}
				});

			});
			//按钮取消
			$("#btnCancel").click(function() {
				$(".newAdd").hide();
			});

			//按钮删除
			$("#btnDele").click(function() {
				var rows = $("#data").datagrid("getSelections");
				if (rows.length == 0) {
					alert("请选择需要删除的行");
					return null;
				}

				var ids = [];
				for (var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}

				$.ajax({
					type : 'POST',
					url : 'deleMenu.do',
					traditional : true,
					data : {
						'menuids' : JSON.stringify(ids)
					},
					success : function(data) {
						if (data == "") {
							alert("删除成功");
							location.reload();
						} else {
							alert("删除失败");
						}
					}
				});
			});

			$("#btnUpdate").click(function() {
				var rows = $("#data").datagrid("getSelections");
				if (rows.length == 0) {
					alert("请选择需要修改的行");
					return null;
				}
				if (rows.length > 1) {
					alert("不能选择多行喔");
					return null;
				}
				$("#menuid").attr("value", rows[0].id);
				$("#menuname").attr("value", rows[0].menu_name);
				$("#parent").attr("value", rows[0].parent_id);
				$("#url").attr("value", rows[0].menu_url);
				$("#ord").attr("value", rows[0].order);
				$("#sid").val(rows[0].ismenu);
				$("#program_code").val(rows[0].program_code);
				$(".newAdd").show();
			});

		});
	</script>

</body>
</html>