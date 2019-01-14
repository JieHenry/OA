<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

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

#main {
	height: 120px;
	border: 1px solid #000;
	margin: 10px auto;
	float: left;
}

#main .title {
	float: left;
}

#mes-tec {
	height: 120px;
	width: 40px;
	border-right: 1px solid #000;
	text-align: center;
}

#person {
	height: 120px;
	width: 50px;
	border-right: 1px solid #000;
}

#person div input {
	height: 120px;
	width: 50px;
	border: 0;
	padding-left: 10px;
	line-height: 120px;
}

#option {
	width: 170px;
	border-right: 1px solid #000;
	height: 120px;
}

#option div input {
	width: 170px;
	height: 120px;
	border: 0;
	padding-left: 10px;
	line-height: 120px;
}
</style>
</head>
<body>

	<fieldset id="fd1" style="width:880px;">
		<legend>
			<span>项目信息</span>
		</legend>
		<div class="fieldset-body">
			<table class="form-table" border="0" cellpadding="5" cellspacing="2">
				<tr>
					<td class="form-label" style="width:60px;display: none">项目编号：</td>
					<td style="width:150px;display: none"><input
						name="construct_project_id" id="construct_project_id"
						class="mini-textbox" value="${head.construct_project_id}" /></td>
					<td class="form-label" style="width:110px;">项目名称：</td>
					<td style="width:150px"><input type="text" name="flow_name"
						readonly="readonly" id="flow_name" class="mini-textbox"
						value="${head.construct_project_name}" /></td>
					<td class="form-label" style="width:110px;">工程地址：</td>
					<td style="width:150px"><input type="text"
						value="${head.construct_project_addr}" name="flow_description"
						readonly="readonly" id="flow_description" class="mini-textbox" /></td>
					<td class="form-label" style="width:110px;">项目经理：</td>
					<td style="width:150px"><input type="text" readonly="readonly"
						value="${head.construct_project_leader}" name="flow_description"
						id="flow_description" class="mini-textbox" /></td>
				</tr>
				<tr>
					<td class="form-label" style="width:110px;">项目经理联系方式：</td>
					<td style="width:150px"><input type="text" readonly="readonly"
						value="${head.construct_project_leaderTel}"
						name="flow_description" id="flow_description" class="mini-textbox" /></td>
				</tr>

			</table>
		</div>
	</fieldset>

	<fieldset id="fd1" style="width:880px;">
		<legend>
			<span>材料信息</span>
		</legend>
		<div class="fieldset-body">
			<table class="form-table" border="0" cellpadding="5" cellspacing="2">
				<tr>
					<td class="form-label" style="display: none">单据编号：</td>
					<td style="display: none"><input name="construct_purchase_id"
						id="construct_purchase_id" class="mini-textbox"
						value="${head.construct_purchase_id}" /></td>
					<td style="display: none"><input
						name="construct_purchase_projectId"
						id="construct_purchase_projectId" class="mini-textbox"
						value="${head.construct_purchase_projectId}" /></td>
					<td class="form-label" style="width:110px">计划日期：</td>
					<td style="width:150px"><input
						name="construct_purchase_planDate" readonly="readonly"
						id="construct_purchase_planDate" class="easyui-datebox"
						value="${head.construct_purchase_planDate}" /></td>
					<td class="form-label" style="width:110px;">希望送达时间：</td>
					<td style="width:150px"><input type="text"
						name="construct_purchase_arriveDate" readonly="readonly"
						id="construct_purchase_arriveDate" class="easyui-datebox"
						value="${head.construct_purchase_arriveDate}" /></td>
					<td class="form-label" style="width:110px;">材料计划员：</td>
					<td style="width:150px"><input type="text"
						value="${head.construct_purchase_planMan}"
						name="construct_purchase_planMan" readonly="readonly"
						id="construct_purchase_planMan" class="mini-textbox" /></td>

				</tr>
				<tr>
					<td class="form-label" style="width:60px;">材料复核员：</td>
					<td style="width:150px"><input type="text"
						value="${head.construct_purchase_reviewer}"
						name="construct_purchase_reviewer" readonly="readonly"
						id="construct_purchase_reviewer" class="mini-textbox" /></td>
					<td class="form-label" style="width:60px;">供应商：</td>
					<td style="width:150px"><input type="text"
						value="${head.construct_purchase_supplier}"
						name="construct_purchase_supplier" readonly="readonly"
						id="construct_purchase_supplier" class="mini-textbox" /></td>
					<td class="form-label" style="width:60px;">供应商联系方式：</td>
					<td style="width:150px"><input type="text"
						value="${head.construct_purchase_supplierTel}"
						name="construct_purchase_supplierTel" readonly="readonly"
						id="construct_purchase_supplierTel" class="mini-textbox" /></td>

				</tr>

			</table>
		</div>
	</fieldset>

	<div style="margin:20px 0;"></div>
	 <table id="materialListID" class="easyui-datagrid" title="材料清单"
		style="width:1200px;height:350px"
		data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',showFooter: true,onDblClickCell: onDblClickCell
				">
		<thead>
			<tr>
				<th
					data-options="field:'construct_purchase_entryId',width:80,hidden:'hidden',editor:'text'">ItemID</th>
				<th
					data-options="field:'num',width:80,align:'right'">材料编号</th>	
				<th
					data-options="field:'construct_purchase_material',width:80,align:'right'">材料名称</th>
				<th
					data-options="field:'construct_purchase_model',width:150,align:'right'">型号规格</th>
				<th
					data-options="field:'construct_purchase_unit',width:80,align:'right'">单位</th>
				<th
					data-options="field:'construct_purchase_quantities',width:80,align:'right'">合同工程量</th>
				<th
					data-options="field:'construct_purchase_approvalNum',width:80,align:'right'">累计审批量</th>
				<th
					data-options="field:'construct_purchase_applyNum',width:80,align:'right'">计划采购量</th>
				<th
					data-options="field:'construct_purchase_contractPrice',width:80,align:'right'">合同单价</th>
				<th
					data-options="field:'construct_purchase_purchasePrice',width:80,align:'right'">采购单价</th>
				<th
					data-options="field:'construct_purchase_purchaseTotal',width:80,align:'right'">采购小计</th>
				
				<th
					data-options="field:'construct_purchase_remarks',width:250,align:'center'">备注</th>
			</tr>
		</thead>
	</table> 
		
	<div id="tb" style="padding:5px;">
	<c:if test="${taskName=='采购核对单价'}">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="chooseSupplier()">选择供应商</a>
		</c:if>
			<c:if test="${taskName=='核对签收'}">
			 <a href="#"
			class="easyui-linkbutton" iconCls="icon-image_add" plain="true"
			onclick="$('#uploads').window('open')">导入图片</a> 
			</c:if>
			<a href="#"
			class="easyui-linkbutton" iconCls="icon-image_add" plain="true"
			onclick="$('#findphoto').window('open')">查看图片</a>
			<a href="#"
			class="easyui-linkbutton" iconCls="icon-ok" plain="true"
			onclick="exc_print()">打印</a>
	</div>

	<div  id="win" class="easyui-window" data-options="region:'center',title:'备注'" closed="true" style="height: 500px; width: 800px" >    
		<textarea style="width: 100%;height: 100% "  readonly="readonly" id="remark" ></textarea>
	</div>
	
	<br/>
	<div class="fieldset-body">
		<table class="form-table" border="0" cellpadding="5" cellspacing="2">
			<tr>
				<td><input type="text" id="taskName" value="${taskName}" /></td>
				<td class="form-label" style="width:80px;">下一审核人：</td>
				<td style="width:150px"><select name="username" id="username"
					style="width:120px;">
						<option value="">请选择审批人</option>
						<c:forEach items="${userList}" var="c">
						<option value="${c.userid}">${c.username}</option>
						</c:forEach>
				</select></td>
				<td class="form-label" style="width:80px;">审核意见：</td>
				<td style="width:150px"><input type="text" value=""
					name="options" id="options" class="mini-textbox"/></td>


				<td style="width:150px"><input id="bot" onclick="subimtAudit()"
					type="button" value="${bot}"> <c:if
						test="${both !=undefined}">
						<input class="both" onclick="rollback()" type="button"
							value="${both}">
					</c:if></td>

			</tr>

		</table>
	</div>

	<div id="win" class="easyui-window"
		data-options="region:'center',title:'请选择值'" closed="true"
		style="height: 500px; width: 800px"></div>


	<div id="w" class="easyui-window" title='修改信息'
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width:1100px;height:700px;padding:10px;">

		<table id="dg"
			data-options="
				fitColumns: true,
				singleSelect: true,
				rownumbers: true,
				showFooter: true
			"></table>
		<div class="fieldset-body">
			<table class="form-table" border="0" cellpadding="5" cellspacing="2">
				<tr>
					<td class="form-label" style="width:80px;">供应商：</td>
					<td style="width:150px"><select name="supplier" id="supplier"
						style="width:120px;">
							<option value="">请选择供应商</option>
							<c:forEach items="${supplier}" var="s">
								<option value="${s.construct_supplier_id}">${s.construct_supplier_name}</option>
							</c:forEach>
					</select></td>
				</tr>
			</table>
		</div>

		<br /><br />
		
		<div style="text-align:center">
			<a class="easyui-linkbutton" href="javascript:;" id="btnChoose"
				onclick="btnChoose()">确定</a> &nbsp;&nbsp;&nbsp;&nbsp; <a
				class="easyui-linkbutton" href="javascript:;" id="btnCancel"
				onclick="closeDown()">取消</a>

		</div>

	</div>
	<div id="audit">
		<table id="history" class="easyui-datagrid" title="审批记录"
			style="width:1200px;height:150px"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true">
		
			<thead>
			<tr>
				<th data-options="field:'username',width:80">审核人</th>
				<th data-options="field:'MESSAGE_',width:300">审核意见</th>
				<th data-options="field:'center_name',width:100">中心</th>
				<th data-options="field:'department_name',width:200">部门</th>
				<th data-options="field:'TIME_',width:200" formatter="dateformat">审核时间</th>

			</tr>
			</thead>
		</table>
	</div>
	<div id="uploads" class="easyui-window"
		data-options="region:'center',title:'请选择值'" closed="true"
		style="height: 100px; width: 400px;padding: 10px;">

		<form id="jvForm" action="" method="post"
			enctype="multipart/form-data">
			<table>
				<tbody>
					<tr>
						<td hidden="hidden"><input type="text" id="bizId"
							value="${bizId}"></td>
						<td width="80%"><input name="photo" type="file" id="file" />
							<a class="easyui-linkbutton"
							data-options="iconCls:'icon-system_save'" onclick="uploadPic();"
							href="javascript:;" id="btnSaveExp">提交</a></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
    	<div id="rollback" class="easyui-window" title="选择回退的节点" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:400px;height:200px;padding:10px;">
          
		<select id="TASK_DEF_KEY_"  name="TASK_DEF_KEY_" style="width:180px;height: 21px;">
           			        
        </select>
		<input class="both" onclick="reject_order()" type="button" value="回退">
	</div>
	<div id="findphoto" class="easyui-window" title="图片"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width:50%px;height:100%px;padding:10px;">
		<tr><td>
		<img src="/uploadfile/photo/${head.photo}" 
			style="width:500px;height:600px" /></td>
			<td><input type="text" hidden="hidden" value="${head.photo}" id="photo" value="${head.photo}"/></td></tr>
	</div>
  <!-- 遮罩层 -->
	    <div class="mark"  style="position:fixed;left:0;top:0; opacity:0.4; width:100%;height:100%; background:#000;z-index:998;display:none;">
          <div class="content" >
            <img alt="" style="width: 200px; height: 180px; position: absolute; left:40%; top: 40%;" src="../res/images/loading.gif">
          </div>
       </div>
       <!-- 遮罩层结束 -->
	<script type="text/javascript">
		$(document).ready(function() {
                             //加载历史记录
							var historys = ${history}.history;
							$('#history').datagrid('loadData', historys);

							//弹框
							var columnsData = ${rows}.columns;
							columnsData = eval(columnsData);
							var $datagrid = {};
							var columns = new Array();
							$datagrid.title = "";
							$datagrid.height = 350;
							$datagrid.width = 1000;
							$datagrid.idField = "id";

							for ( var key in columnsData[0]) {
								columns.push({
									"field" : columnsData[0][key],
									"title" : key,
									"width" : 80,
									"sortable" : true
								});
							}
							$datagrid.columns = new Array(columns);
							$('#dg').datagrid($datagrid);

							if (${rows}.rows != undefined) {
								var rows = ${rows}.rows;
								var data = JSON.parse("{}");
								data.footer = ${rows}.selectFooter;
								data.rows = rows;
								$('#dg').datagrid('loadData', data);
							}

							//后台数据
							if (${rows}.rows != undefined) {
								var rows = ${rows}.rows;
								var data = JSON.parse("{}");
								data.footer = ${rows}.footer;
								data.rows = rows;
								$('#materialListID').datagrid('loadData', data);
							}

							$("#backList").click(function() {

								location.href = "auditList.do";
							});
						});

		//材料采购单审核
		function subimtAudit(obj) {
			var bizId = ${bizId};        //获取业务键
			var username = $("#username").val();//获取审核人
			var name = $("#username option:selected").text();
			var taskName = $("#taskName").val();  //获取节点名称
			var options = $("#options").val(); //获取审核意见
            var photo = $("#photo").val();  //图片路径
         
			if (options == '') {
				alert("意见不能为空!");
				return false;
			}
			if (taskName =='通知财务') {
			}else{
				if (username == '') {
					$.messager.alert("提示!","请选择审核人!");
					return false;
				}			
			}

			if(taskName=='核对签收'){
				if(photo==''){
					$.messager.alert("提示","请上传图片");
					return false;
				}
			
			}
			
			if(taskName=='采购核对单价'){
				if($("#construct_purchase_supplier").val()==''){
					$.messager.alert("提示","请选择供应商");
					return false;
				}
			 }
			
			$.messager.confirm('提示！', '你确定提交：'+name, function(r) {
				if (r) {
					$('.mark').css("display","block");
			$.ajax({
				type : "POST",
				url : "start_examination.do",
				data : {
					'taskid' : ${taskid},
					'username' : username,
					'taskName' : taskName,
					'options' : options,
					'bizId' : bizId,
				},
				success : function(data) {
					
					if (data.Success) {
						$('.mark').css("display","none");
						$.messager.alert("提示", data.Msg+data.leva,"info", function() {
							location.href = "findTaskList.do";
								});
				      	}else {
				      		$('.mark').css("display","none");
						$.messager.alert("提示", data.Msg,
								"error");
					      }
						}
					});
			   	  }			
		       	});
		       }
        //打开回退窗口
		function rollback() {
			$("#TASK_DEF_KEY_").empty(); //清空内容
			$('#rollback').window('open') 
		   var processInstanceId=${processInstanceId}
			$.ajax({
				type : "get",
				url : "findtaskinst.do",
				data : {
					'processInstanceId' : processInstanceId,
				},success : function(data) {				
					var taskName = $("#taskName").val();  //获取节点名称
					var html="";
					
					switch (taskName) {
					case "经营部审核":
						html+="<option value='"+data[0].TASK_DEF_KEY_+"'>"+data[0].NAME_+"</option>";									 
						break;
					case "总经理审核":
						html+="<option value='"+data[0].TASK_DEF_KEY_+"'>"+data[0].NAME_+"</option>";
						html+="<option value='"+data[1].TASK_DEF_KEY_+"'>"+data[1].NAME_+"</option>";					
						break;
					case "采购核对单价":
						html+="<option value='"+data[0].TASK_DEF_KEY_+"'>"+data[0].NAME_+"</option>";
						html+="<option value='"+data[1].TASK_DEF_KEY_+"'>"+data[1].NAME_+"</option>";
						html+="<option value='"+data[2].TASK_DEF_KEY_+"'>"+data[2].NAME_+"</option>";
					break;
					case "财务经理审批":
						html+="<option value='"+data[0].TASK_DEF_KEY_+"'>"+data[0].NAME_+"</option>";
						html+="<option value='"+data[1].TASK_DEF_KEY_+"'>"+data[1].NAME_+"</option>";
						html+="<option value='"+data[2].TASK_DEF_KEY_+"'>"+data[2].NAME_+"</option>";
						html+="<option value='"+data[3].TASK_DEF_KEY_+"'>"+data[3].NAME_+"</option>";
					break;
					case "董事会审批":
						html+="<option value='"+data[0].TASK_DEF_KEY_+"'>"+data[0].NAME_+"</option>";
						html+="<option value='"+data[1].TASK_DEF_KEY_+"'>"+data[1].NAME_+"</option>";
						html+="<option value='"+data[2].TASK_DEF_KEY_+"'>"+data[2].NAME_+"</option>";
						html+="<option value='"+data[3].TASK_DEF_KEY_+"'>"+data[3].NAME_+"</option>";
						html+="<option value='"+data[4].TASK_DEF_KEY_+"'>"+data[4].NAME_+"</option>";
					break;
					default:
						break;
					}
					 $("#TASK_DEF_KEY_").append(html);
					
				}})
			
		}
		
		//驳回功能
		function reject_order() {
			
			var construct_purchase_id =$("#construct_purchase_id").val();
		
			if(construct_purchase_id==null ||construct_purchase_id==''){
				$.messager.alert("提示","没有单据编号");
				return;
			}
			var options = $("#options").val();
			if (options == '') {
				alert("意见不能为空!");
				return false;
			}
			var TASK_DEF_KEY_ = $("#TASK_DEF_KEY_").val();//获取审核人
			$.messager.confirm('提示！', '你确定审核吗？', function(r) {
				if (r) {
					 $.messager.progress({
							title : '提示',
							msg : '正在处理中，请稍候……',
							text : ''
						});
			$.ajax({
				type : "POST",
				url : "reject_order.do",
				data : {
					'taskid' : ${taskid},
					'activityId':TASK_DEF_KEY_,
					'options' : options,
					'construct_purchase_id':construct_purchase_id,
				},
				success : function(data) {
					$.messager.progress('close');
					if (data.Success) {
						$.messager.alert("提示", data.Msg,"info", function() {
							location.href = "findTaskList.do";
								});
				      	}else {
						$.messager.alert("提示", data.Msg,"error");
					      }
				  }
	       	   });

				}
			});

		}
		
		function onDblClickCell(index, field, value) {
			
			if (field == "construct_purchase_remarks") {
				$("#remark").val(value);
				$("#win").window("open");
			}
		}
		
		//上传图片
		function uploadPic() {

			var fileName = $("#file").val();
			var bizId = ${bizId};
			if (fileName == "") {
				$.messager.alert("提示", "请选择采购单图片！");
				return false;
			}
			var file_typename = fileName.substring(fileName.lastIndexOf('.'),
					fileName.length);

			if (file_typename != '.png' && file_typename != '.jpg'&&file_typename != '.JPG'&& file_typename!='.jpeg'&& file_typename!='.JPEG') {
				$.messager.alert("提示", "图片格式错误，请选择文件格式为.jpg,png");
				return false;
			}

			$.messager.confirm('继续操作', '确定导入吗?', function(r) {
				if (r) {
					// 上传设置  

					$('#jvForm').form(
							'submit',
							{
								url : 'uploadPhoto.do',

								onSubmit : function(data) {
									//参数
									data.bizId = bizId;
									//导入成功后的要处理的操作
								},
								success : function(data) {
									var data = eval("(" + data + ")");
									if (data.Success) {
										$.messager.alert("提示", data.Msg,
												"info", function() {
													window.location
															.reload(true);
												});
									} else {
										$.messager.alert("提示", data.Msg,
												"error");
									}

								}
							});
				}
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
		

		//弹框
		function chooseSupplier() {
			$('#w').window('open');
		}
		
		
		//打印
		   function exc_print(){
			
				location.href = "excelprint.do?" + $.param({
					'taskid' : ${taskid},
					
				  });
		      }
		
		   function closeDown() {
			   $('#w').window('close');
		     }
		
		function btnChoose() {
			var supplier = $("#supplier").val();
			var supplierName = $("#supplier").find("option:selected").text();
			var purchase_id = $("#construct_purchase_id").val();
			$('#dg').datagrid('acceptChanges');
			var rows = $('#dg').datagrid('getRows');

			if (supplier == "") {
				alert("供应商不能为空!");
				return false;
			}
			if (confirm("你确定选择这个供应商吗？")) {
				$.ajax({
					type : 'POST',
					url : 'chooseSupplier.do',
					data : {
						'supplier' : supplier,
						'supplierName' : supplierName,
						'rows' : JSON.stringify(rows),
						'purchase_id' : purchase_id
					},
					success : function(data) {
						if (data.erro == "") {
							window.location.reload(true);
						} else {
							alert(data.erro);
						}
					}
				});
			} else {
				return false;
			}
		}

		//子窗口调用
		function materialPriceData(data, index) {
			var row = $('#materialListID').datagrid("selectRow", index)
					.datagrid("getSelected");

			$('#payroll').datagrid('acceptChanges');
			var rows = $('#materialListID').datagrid('getRows');

			row.construct_purchase_material = rows[index].construct_purchase_material;
			row.construct_purchase_model = rows[index].construct_purchase_model;
			row.construct_purchase_unit = rows[index].construct_purchase_unit;
			row.construct_purchase_quantities = rows[index].construct_purchase_quantities;
			row.construct_purchase_contractPrice = rows[index].construct_purchase_contractPrice;
			row.construct_purchase_purchasePrice = data.price;
			row.construct_purchase_brand = data.brand;
			row.construct_purchase_suppliers = data.supplier;
			row.construct_material_supplierTel = data.tel;

			row.construct_purchase_remarks = rows[index].construct_purchase_remarks;
			row.construct_purchase_applyNum = rows[index].construct_purchase_applyNum;
			row.construct_purchase_approvalNum = rows[index].construct_purchase_approvalNum;//累计审批量

			var applyNum = rows[index].construct_purchase_applyNum == undefined ? 0 //计划采购量
					: rows[index].construct_purchase_applyNum;
			var purchasePrice = data.price == undefined ? 0 //计划采购量
			: data.price;
			Total = parseInt(applyNum) * parseInt(purchasePrice);
			row.construct_purchase_purchaseTotal = Total;

			$('#materialListID').datagrid('refreshRow', index);
		}
	</script>

</body>