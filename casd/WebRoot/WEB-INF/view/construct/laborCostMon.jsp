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
		<div id="main" region="center"
			style="background: #eee; padding: 5px; overflow-y: hidden;">


			<div class="easyui-layout" fit="true">
				<div region="north" split="false" border="false"
					style="overflow: hidden; padding: 5px 5px 28px 5px;">
					<div class="easyui-panel" title="查询条件" style="margin-bottom: 5px;">

						<div class="search">
							<ul>
							
							<li><label>年度：</label><input type="text" name="yearNum" id="yearNum"
									class="easyui-validatebox" style="width: 60px" value="${yearNum}"} /></li>
								<li><label>项目名称：</label><input type="text" name="construct_project_name" id="construct_project_name"
									class="easyui-validatebox" style="width: 120px" /></li>
								<li>&nbsp;&nbsp; <a class="easyui-linkbutton"
									data-options="iconCls:'icon-search'" href="javascript:;"
									id="btnSearch">查询</a></li>
							</ul>
							<div class="clear"></div>
						</div>
					</div>
				</div>
				
				<div region="center" split="false" border="false"
					style="overflow: hidden; padding: 0 5px 5px 5px" id="dataList">
					<table id="data" title="" fit="true"
						data-options="collapsible: true,pagination:true,rownumbers:true">
						<thead>
							<tr>
								<th halign="center" field="manage_contract_num" align="center"
									sortable="true" width="60px" hidden="hidden">合同编码</th> 
								<th halign="center" field="construct_project_name" align="center"
									sortable="true" width="120px" formatter="name_num" >项目</th>
								
								<th halign="center" field="construct_project_workTeam_category" align="center"
									sortable="true" width="120px" formatter="category" >施工项目</th>
								<th halign="center" field="hr_attend_workTeamId" align="center"
									sortable="true" width="120px" hidden="hidden" >施工项目id</th>	
								<th halign="center" field="username" align="center" 
									sortable="true" width="120px">班组</th>
								<th halign="center" field="construct_project_workTeam_amount" align="center" 
									sortable="true" width="120px">合同金额</th>
								<th halign="center" field="construct_project_workTeam_price" align="center" 
									sortable="true" width="120px">单价</th>
								<th halign="center" field="jan" align="center" 
									sortable="true" width="100px" formatter="amount">1月份</th>
								<th halign="center" field="feb" align="center" 
									sortable="true" width="100px" formatter="amount">2月份</th>
								<th halign="center" field="mar" align="center" 
									sortable="true" width="100px" formatter="amount">3月份</th>
								<th halign="center" field="apr" align="center" 
									sortable="true" width="100px" formatter="amount">4月份</th>
								<th halign="center" field="may" align="center" 
									sortable="true" width="100px" formatter="amount">5月份</th>
								<th halign="center" field="jun" align="center" 
									sortable="true" width="100px" formatter="amount">6月份</th>
								<th halign="center" field="jul" align="center" 
									sortable="true" width="100px" formatter="amount">7月份</th>
								<th halign="center" field="aug" align="center" 
									sortable="true" width="100px" formatter="amount">8月份</th>
								<th halign="center" field="sep" align="center" 
									sortable="true" width="100px" formatter="amount">9月份</th>
								<th halign="center" field="oct" align="center" 
									sortable="true" width="100px" formatter="amount">10月份</th>
								<th halign="center" field="nov" align="center" 
									sortable="true" width="100px" formatter="amount">11月份</th>
								<th halign="center" field="dec" align="center" 
									sortable="true" width="100px" formatter="amount">12月份</th>	
								<th halign="center" field="total" align="center" 
									sortable="true" width="100px" formatter="total">累计付款</th>
								<th halign="center" field="percent" align="center" 
									sortable="true" width="100px" formatter="percent">累计支付比例</th>
								<th halign="center" field="balance" align="center" 
									sortable="true" width="100px" formatter="balance">累计余额</th>
								<!-- <th halign="center" field="remarks" align="center" 
									sortable="true" width="100px" >备注</th>	 -->		
							</tr>
						</thead>
					</table>
				</div>

			</div>
		</div>





	<script type="text/javascript">
		function operate_formatter(value, row, index) {
			var html = "";

			html += '<a href="javascript:;" class="opt"    cmd="taskList" i="' + index + '">项目作业</a>';

			return html;
		}
		
		function name_num (value, row, index){
			
			return value+"<br>"+row.manage_contract_num;
			
		}
		
		
		 function amount(value, row, index) {
				var amount=0;
				if (value != undefined||value!="")
					amount =parseFloat(value)*parseFloat(row.construct_project_workTeam_price);
				return amount.toFixed(2);
				
			   
		}
		 
		 
		 function category(value, row, index) {
				switch (value) {
				case 1:
					return "预埋"; 
					break;
				case 2:
					return "消防水"; 
					break;
				case 3:
					return "消防电"; 
					break;
				case 4:
					return "防排烟"; 
					break;	
				default:
					break;
				}
				
				
			   
		}
		 
		 
		 
		 function total(value, row, index) {
				return ((parseFloat(row.jan)+parseFloat(row.feb)+parseFloat(row.mar)+parseFloat(row.apr)+parseFloat(row.may)+parseFloat(row.jun)
				+parseFloat(row.jul)+parseFloat(row.aug)+parseFloat(row.sep)+parseFloat(row.oct)+parseFloat(row.nov)+parseFloat(row.dec))*parseFloat(row.construct_project_workTeam_price)).toFixed(2); 
		}
		 
		 function percent(value, row, index) {
				
			 	if(row.construct_project_workTeam_amount!= undefined && row.construct_project_workTeam_amount!="")
				return (((parseFloat(row.jan)+parseFloat(row.feb)+parseFloat(row.mar)+parseFloat(row.apr)+parseFloat(row.may)+parseFloat(row.jun)
						+parseFloat(row.jul)+parseFloat(row.aug)+parseFloat(row.sep)+parseFloat(row.oct)+parseFloat(row.nov)+parseFloat(row.dec))*parseFloat(row.construct_project_workTeam_price)/parseFloat(row.construct_project_workTeam_amount))*100).toFixed(2)+"%"; 
			   
		}
		 
		 function balance(value, row, index) {
			 	if(row.construct_project_workTeam_amount!= undefined && row.construct_project_workTeam_amount!="")
				return parseFloat(row.construct_project_workTeam_amount)-(parseFloat(row.jan)+parseFloat(row.feb)+parseFloat(row.mar)+parseFloat(row.apr)+parseFloat(row.may)+parseFloat(row.jun)
						+parseFloat(row.jul)+parseFloat(row.aug)+parseFloat(row.sep)+parseFloat(row.oct)+parseFloat(row.nov)+parseFloat(row.dec))*parseFloat(row.construct_project_workTeam_price).toFixed(2); 
			   
		}
		

		/***处理操作列的功能***/
		function cmdHanlder(cmd, row) {
			if (cmd == "taskList") {
				
				location.href = "taskList.do?" + $.param({
					'construct_project_id' : row.construct_project_id, //传参项目部编号
				});
			}
		}

		
		$(function() {
			$("#data").admin_grid({
				queryBtn : "#btnSearch",
				excelBtn : "#btnExcel",
				cmdHanlder : cmdHanlder,
				
				onLoadSuccess: function(data){
					var mark=1;
					for (var i=1; i <data.rows.length; i++) {
						if (data.rows[i]['construct_project_name'] == data.rows[i-1]['construct_project_name']) {
							mark += 1;
							$(this).datagrid('mergeCells',{ 
								index: i+1-mark, 
								field: 'construct_project_name',
								rowspan:mark
							});
						}else{
							mark=1;     
						}
					}
					
				},
				
				onClickRow: function (rowIndex, rowData) {
		            $(this).datagrid('unselectRow', rowIndex);
				},
				
				onDblClickCell: function (rowIndex, field, value) {
					 if(field=="jan"||field=="feb"||field=="mar"||field=="apr"||field=="may"||field=="jun"||field=="jul"||field=="aug"||field=="sep"||field=="oct"||field=="nov"||field=="dec"){
						 var row = $('#data').datagrid("selectRow", rowIndex)
							.datagrid("getSelected");
						   
						 location.href = "laborCostDate.do?field="+field+"&hr_attend_workTeamId="+row.hr_attend_workTeamId;
					 }
					 
				 }
			
			});
			
			
				
			
		});
	</script>

</body>
</html>