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

</head>
<body class="easyui-layout" style="overflow-y: hidden;" scroll="no">

	<div id="main" region="center"
		style="background: #eee; padding: 5px; overflow-y: hidden;">

		<div class="easyui-layout" fit="true">

			<div class="easyui-layout" fit="true">
				<div region="north" split="false" border="false"
					style="overflow: hidden; padding: 5px 5px 28px 5px;">
					<div class="easyui-panel" title="查询条件" style="margin-bottom: 5px;">
						<div class="controls">
							
						</div>
						<div class="search">							<ul>
								<li><label>公司名称：</label><input type="text" name="company_name"
									class="easyui-validatebox" style="width:120px;height: 25px;"/></li>
									<li><label>项目名称：</label><input type="text" name="construct_project_name"
									class="easyui-validatebox" style="width:120px;height: 25px;"/></li>
								<li><label> 姓名：</label><input type="text" name="own_purchase_planMan"
									class="easyui-validatebox" style="width: 120px;height: 25px" /></li>
									<li><a class="easyui-linkbutton" data-options="iconCls:'icon-search'"
								href="javascript:;" id="btnSearch">查询</a></li>
							</ul>
							<div class="clear"></div>
						</div>

						<div id="tb">

							<a href="#" class="easyui-linkbutton" iconCls="icon-add"
								plain="true" onclick="ownHeadView('save');">新增</a>
						</div>
					</div>
				</div>

				<div region="center" split="false" border="false"
					style="overflow: hidden; padding: 0 5px 5px 5px" id="dataList">
					<table id="data" title="" fit="true"
						data-options="collapsible: true,pagination:true,rownumbers:true">
						<thead>
							<tr>
								<th halign="center" field="own_purchase_id" align="center"
									sortable="true" width="120px">单据编号</th>
								<th halign="center" field="company_name" align="center"
									sortable="true" width="120px">公司名称</th>
								<th halign="center" field="construct_project_name" align="center"
									sortable="true" width="250px">项目名称</th>
								<th halign="center" field=own_purchase_time align="center"
								     sortable="true" width="120px">建单时间</th>
								<th halign="center" field="own_purchase_planDate" align="center"
								     sortable="true" width="120px">计划日期</th>
								<th halign="center" field="own_purchase_arriveDate" align="center"
								    sortable="true" width="120px">希望送达日期</th>
								<th halign="center" field="own_purchase_planMan" align="center"
								    sortable="true" width="120px">计划员</th>
								<th halign="center" field="own_purchase_type" align="center"
									sortable="true" width="120px" formatter="operate_type">采购类型</th>	
								<th halign="center" field="own_purchase_status" align="center"
									sortable="true" width="120px" formatter="operate_status">状态</th>	
								<th halign="center" field="psn"  sortable="true"
									width="120px" formatter="operate_formatter">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function operate_formatter(value, row, index) {
			var html = "";	
			html += '<a href="javascript:;" class="opt" cmd="edit" i="' + index + '">查看</a>&nbsp';
			if(row.own_purchase_status==0){
				
				html += '<a href="javascript:;" class="opt" cmd="delete" i="' + index + '">删除</a>';
			}
			return html;
		}
		 function ownHeadView(type){
			 location.href = "ownHeadView.do?" + $.param({
				 'type':type,
			 });
		 }

	 function operate_type(value, row, index){
		 if(value==1){
			 return '普通采购';
		 }else if(value==2){
			 return '材料采购';
		 }
		 
	 }	 
		 
		/***处理操作列的功能***/
		function cmdHanlder(cmd, row) {
		
			if(cmd=='edit'){
				 location.href = "ownHeadView.do?" + $.param({
					 'type':'view',
					 'bizId':row.own_purchase_id,
					  
				 });
			}else if(cmd=='delete'){
	
				  $.messager.confirm('提示！', '确定删除?', function(r){
						if (r){
							$.messager.progress({
								title : '提示',
								msg : '正在处理中，请稍候……',
								text : ''
							}); 
					$.ajax({
					url : "deleteOwnEntry.do",
					type : 'POST',
					data : {'headId':row.own_purchase_id,
						    'type':'head',
						    },
					success : function(data) {
						 $.messager.progress('close');
							if (data.Success) {
								$.messager.alert("提示", data.Msg, "info", function() {
									   location.href="ownHeadList.do";
									});
								
							} else {
								$.messager.alert("提示", data.Msg, "error");

							}
					}
			        })
			        }
						
				  })
			}

		}
         //格式状态
		function operate_status(value,row,index){
        	 if(value==0){
        		 return "审核中";
        	 }else if(value==2){
        		 return "审核不通过";
        	 }else if(value==1){
        		 return "审核通过";
        	 }
         }
		
		$(function() {
			$("#data").admin_grid({
				queryBtn : "#btnSearch",
			
				cmdHanlder : cmdHanlder,

			});

		});
	</script>

</body>
</html>