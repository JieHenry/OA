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

	<form id="head">
	<fieldset id="fd1" style="width:1150px;">
		<legend>
			<span>项目信息</span>
		</legend>
		<div class="fieldset-body">
			<table class="form-table" border="0" cellpadding="5" cellspacing="2">
				<tr>
					<td class="form-label" style="width:60px;display: none">项目编号：</td>
					<td style="width:150px;display: none"><input
						name="construct_Aparty_purchase_constructId" id="construct_project_id"
						class="mini-textbox" value="${aParty.construct_project_id}" /></td>
					<td class="form-label" style="width:110px;">项目名称：</td>
					<td style="width:150px"><input type="text" name="construct_project_name" readonly="readonly"
						id="construct_project_name" class="mini-textbox"
						value="${aParty.construct_project_name}" /></td>
					<td class="form-label" style="width:110px;">收货地址：</td>
					<td style="width:150px"><input type="text" readonly="readonly"
						value="${aParty.construct_project_addr}"
						name="flow_description" id="flow_description" class="mini-textbox" /></td>
					<td class="form-label" style="width:110px;">收货人：</td>
					<td style="width:150px"><input type="text" readonly="readonly"
						value="${aParty.construct_project_leader}"
						name="flow_description" id="flow_description" class="mini-textbox" /></td>
					<td class="form-label" style="width:110px;">联系电话：</td>
					<td style="width:150px"><input type="text" readonly="readonly"
						value="${aParty.construct_project_leaderTel}"
						name="flow_description" id="flow_description" class="mini-textbox" /></td>	
				</tr>

			</table>
		</div>
	</fieldset>


	<fieldset id="fd1" style="width:1150px;">
		<legend>
			<span>订单信息</span>
		</legend>
		<div class="fieldset-body">
			<table class="form-table" border="0" cellpadding="5" cellspacing="2">
				<tr>
					<td class="form-label" style="display: none">headId：</td>
					<td style="display: none"><input name="construct_Aparty_purchase_id"
						id="construct_Aparty_purchase_id" class="mini-textbox"
						value="${aParty.construct_Aparty_purchase_id}" /></td>
					<td class="form-label" style="width:110px">订单号：</td>
					<td style="width:150px"><input
						name="construct_Aparty_purchase_orderNum"
						id="construct_Aparty_purchase_orderNum" class="mini-textbox"
						value="${aParty.construct_Aparty_purchase_orderNum}" /></td>
					<td class="form-label" style="width:110px;">供货单位：</td>
					<td style="width:150px"><input type="text"
						name="construct_Aparty_purchase_supplier"
						id="construct_Aparty_purchase_supplier" class="mini-textbox"
						value="${aParty.construct_Aparty_purchase_supplier}" /></td>
					
					<td class="form-label" style="width:110px;">联系人：</td>
					<td style="width:150px"><input type="text" 
						value="${aParty.construct_Aparty_purchase_contacts}"
						name="construct_Aparty_purchase_contacts"
						id="construct_Aparty_purchase_contacts" class="mini-textbox" /></td>
					<td class="form-label" style="width:110px;">联系电话：</td>
					<td style="width:150px"><input type="text" 
						value="${aParty.construct_Aparty_purchase_tel}"
						name="construct_Aparty_purchase_tel"
						id="construct_Aparty_purchase_tel" class="mini-textbox" /></td>
					<td class="form-label" style="display: none">创建时间：</td>
					<td style="display: none"><input type="text" 
						value="${aParty.construct_Aparty_purchase_creatTime}"
						name="construct_Aparty_purchase_creatTime"
						id="construct_Aparty_purchase_creatTime" class="mini-textbox" /></td>	
					
				</tr>
			</table>
		</div>
	</fieldset>

</form>
	<br>
	<table id="materialListID" class="easyui-datagrid" title="材料清单"
		style="width:1200px;height:auto"
		data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',onDblClickCell: onDblClickCell,onClickCell: onClickCell
				">
		<thead>
			<tr>
				<th 
					data-options="field:'construct_Aparty_purEntry_parentId',width:80,hidden:'hidden',editor:'text'">采购单id</th>
				<th 
					data-options="field:'construct_Aparty_purEntry_id',width:80,hidden:'hidden',editor:'text'">ItemID</th>
				<th 
					data-options="field:'construct_Aparty_purEntry_materialId',width:80,hidden:'hidden',editor:'text'">材料id</th>	
				<th
					data-options="field:'construct_Aparty_material_category',width:150,align:'center'">材料分类</th>
				<th
					data-options="field:'construct_Aparty_material_name',width:400,align:'center'">材料名称</th>
				<th
					data-options="field:'construct_Aparty_material_model',width:80,align:'center'">型号规格</th>
				<th
					data-options="field:'construct_Aparty_material_unit',width:80,align:'center'">单位</th>
				<th
					data-options="field:'construct_Aparty_material_num',width:80,align:'center'">合同工程量</th>
				<th
					data-options="field:'construct_aParty_byedNum',width:80,align:'center'">累计审批量</th>
				<th
					data-options="field:'construct_Aparty_purEntry_num',width:80,align:'center',editor:{type:'numberbox'}">计划采购量</th>
				
				<th
					data-options="field:'construct_Aparty_purEntry_remark',width:200,align:'center',editor:{type:'text',options:{required:true}}">备注</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="height:auto">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true" onclick="add()">添加</a> 
			
			<a href="javascript:void(0)" class="easyui-linkbutton" id="reject"
			data-options="iconCls:'icon-undo',plain:true" onclick="reject()">撤销行</a>
			
			<a href="javascript:void(0)" class="easyui-linkbutton" id="removeit"
			data-options="iconCls:'icon-cut',plain:true" onclick="removeit()">删除</a>
	</div>
	<br/>

	<br />
	<br />
	<div style="text-align:center">
		<tr>
			<td style="align:center">
				&nbsp;&nbsp;&nbsp;&nbsp; <a class="easyui-linkbutton"
				href="javascript:;" id="btnSave" onclick="btnSave()">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="easyui-linkbutton" href="javascript:;" id="btnCancel"
				onclick="btnCancel()">取消</a></td>
		</tr>
	</div>


	<div  id="win" class="easyui-window" data-options="region:'center',title:'请选择值'" closed="true" style="height: 500px; width: 800px" >    
	</div>

	<script type="text/javascript">
		var editIndex = undefined;

		$(function() {
			
			var data = ${entries}.entries;
			if(data!=undefined){
				$('#materialListID').datagrid('loadData', data);
			}
			var type = ${entries}.type;
			if(type=='new'){
				document.getElementById("removeit").style.display = "none";
			}else{
				document.getElementById("reject").style.display = "none";
			}
			
			
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
		
		
		
		//删除处理
		function removeit(){
		var row = $('#materialListID').datagrid('getSelected');
         //是否要删除
		$.messager.confirm('提示！', '你确定删除吗？', function(r) {
				if (r) {	
			 $.post("delete_aPartyEntry.do",{
				 'id':row.construct_Aparty_purEntry_id
			   },function(data) {
					if (data.Success) {
						$.messager.alert("提示", data.msg,"info", function() {
							 location.reload(true);
								});
				      	}else {
						$.messager.alert("提示", data.msg,"error");
					    
						}

			 });
			 }
		});
		};
		//新增行
		function add() {
			$('#materialListID').datagrid('appendRow', {
				status : 'P'
			});
			editIndex = $('#materialListID').datagrid('getRows').length - 1;

			$('#materialListID').datagrid('selectRow', editIndex).datagrid(
					'beginEdit', editIndex);
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

		function onClickCell(index, field) {
			$('#materialListID').datagrid('selectRow', index);
			if (endEditing()) {
				$(this).datagrid('beginEdit', index);
			}
		}

		function onDblClickCell(index, field, value) {
				
			var hrefs = "<iframe id='son' src='aPartyMaterialCheck.do?construct_project_id="+${aParty.construct_project_id}+"&index="+index+"'  allowTransparency='true' style='border:0;width:99%;height:99%;padding-left:2px;' frameBorder='0'></iframe>";
			$("#win").html(hrefs);
			$("#win").window("open");
		}
		//子窗口调用
		function aPartyMateData(data,index) {
			var row = $('#materialListID').datagrid("selectRow", index)
					.datagrid("getSelected");

			$('#materialListID').datagrid('acceptChanges');
			var rows = $('#materialListID').datagrid('getRows');
			
			for (var int = 0; int < rows.length; int++) {
				if(rows[int].construct_Aparty_purEntry_materialId==data.construct_Aparty_material_id){
					alert("此材料已存在！");
					return false;
				}
			}
			row.construct_Aparty_purEntry_materialId = data.construct_Aparty_material_id;
			row.construct_Aparty_material_name = data.construct_Aparty_material_name;
			row.construct_Aparty_material_model = data.construct_Aparty_material_model;
			row.construct_Aparty_material_unit = data.construct_Aparty_material_unit;
			row.construct_Aparty_material_num = data.construct_Aparty_material_num;
			row.construct_Aparty_material_category = data.construct_Aparty_material_category;
			
			row.construct_Aparty_purEntry_num = rows[index].construct_Aparty_purEntry_num;
			row.construct_Aparty_purEntry_remark = rows[index].construct_Aparty_purEntry_remark;
			if(data.sum!=null){
				row.construct_aParty_byedNum =data.sum;//累计审批量
			}else{
				row.construct_aParty_byedNum = 0;
			}
			$('#materialListID').datagrid('refreshRow', index);
		}

		//撤销新增行
		function reject() {
			
			var row = $('#materialListID').datagrid('getSelected');
				if (row) {
					var rowIndex = $('#materialListID').datagrid('getRowIndex', row);
					$('#materialListID').datagrid('deleteRow', rowIndex);

				} else {
					$.messager.alert("提示", "请选择删除行!");
				}
		}

		//取消
		function btnCancel() {
			location.href = "aPartyPurList.do?" + $.param({
				'construct_project_id' : ${aParty.construct_project_id}
			});
		} 

		//保存
		function btnSave() {
			
			/* 
				var construct_Aparty_material_category=$("#construct_Aparty_material_category").val();
				if(construct_purchase_materialSerId==""){
				alert("材料类别不能为空");
				return false;
			}	 */
		var project_name=construct_project_name=$("#construct_project_name").val();
			var rows = null;
			if (endEditing()) {
				$('#materialListID').datagrid('acceptChanges');
				 rows = $('#materialListID').datagrid('getRows');
			}
			
			for (var int = 0; int < rows.length; int++) {
				if (rows[int].construct_Aparty_purEntry_num=="") {
					alert("第"+int+1+"行计划采购量不能为空");
					return false;
				} 
				var num=int+1;
				if(rows[int].construct_Aparty_material_num!=0 && parseInt(rows[int].construct_Aparty_material_num)<parseInt(rows[int].construct_aParty_byedNum)+parseInt(rows[int].construct_Aparty_purEntry_num)){
					alert("第"+num+"行计划采购量累计不能大于合同工程量");
					return false;
				}
				
			}
			
			$.post("save_aPartyPur.do?rows="
				+ encodeURI(JSON.stringify(rows))+"&project_name="+project_name, $("#head").serialize(),
				function(data) {
					if (data.Success) {
						$.messager.alert("提示", data.Msg, "info", function() {
						
							location.href = "findTaskList.do";
						});

					} else {
						$.messager.alert("提示", data.Msg, "error");
						window.location.reload();
					}
			});
			
		}


		
		
		function getData(data){
			
			 $("#construct_purchase_materialSerId").val(data.construct_material_seriesID); 
			 $("#construct_purchase_materialSerName").val(data.construct_material_seriesName); 
		}
		
	</script>
</body>
</html>