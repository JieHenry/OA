package com.casd.controller.ownCenter;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.activiti.engine.TaskService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.casd.controller.web.Ref;
import com.casd.entity.ownCenter.OwnPurchaseHead;
import com.casd.entity.uc.User;
import com.casd.service.hr.ActivitiService;
import com.casd.service.manage.SupOpinionService;
import com.casd.service.ownCenter.OwnHeadService;

@Controller
@RequestMapping("/admin")
public class OwnPurchaseController {
	
	@Autowired
	private OwnHeadService ownHeadService;
	
	@Autowired
	private ActivitiService  activitiService;
	
	@Autowired
	private SupOpinionService supOpinionService;
	
	@Autowired
	private TaskService taskService;
	
	@RequestMapping(value = "/ownHeadList", method = RequestMethod.GET)
	public ModelAndView ownHeadList() {
		
		ModelAndView mv=new ModelAndView();
		mv.setViewName("ownCenter/ownHeadList");
		return mv;

	}
	@RequestMapping(value = "/ownHeadList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  ownHeadList(HttpServletRequest request) throws Exception {
		
		Ref<Integer> record = new Ref<Integer>();
		Map<String, Object> json = new HashMap<String, Object>();
	
		String company_name=request.getParameter("company_name");
		String own_purchase_planMan=request.getParameter("own_purchase_planMan");
		String construct_project_name=request.getParameter("construct_project_name");
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		int pageIndex = Integer.parseInt(request.getParameter("page")) - 1;
		
		String fields = "head.*,pro.construct_project_name,cpy.company_name";
		StringBuffer sbf = new StringBuffer();
		sbf.append(" own_purchase_head head");
		sbf.append(" left join construct_project_table pro on head.own_purchase_projectId=pro.construct_project_id");
		sbf.append(" LEFT JOIN uc_company cpy ON cpy.company_id=head.own_purchase_companyId");
		sbf.append(" where 1=1");
		if (StringUtils.isNotBlank(company_name)) {
			sbf.append(" AND cpy.company_name LIKE'%"+company_name+"%'");
		}
		if (StringUtils.isNotBlank(own_purchase_planMan)) {
			sbf.append(" AND head.own_purchase_planMan LIKE'%"+own_purchase_planMan+"%'");
		}
		if (StringUtils.isNotBlank(construct_project_name)) {
			sbf.append(" AND pro.construct_project_name LIKE'%"+construct_project_name+"%'");
		}
		
		List<Map<String, Object>> ListData =ownHeadService.ownHeadlist(pageIndex, pageSize, record, fields, sbf.toString());
		json.put("rows", ListData);
		json.put("total", record.getValue());
		return json;
      }
	
	  //跳转 新增 、 编辑页面
	@RequestMapping(value = "/ownHeadView", method = RequestMethod.GET)
	public ModelAndView ownHeadView(HttpServletRequest request) throws Exception {
		String type=request.getParameter("type");
		ModelAndView mv=new ModelAndView();
		 JSONArray jsonArray = new JSONArray();
		 
			List<Map<String, Object>> historyList=new ArrayList<Map<String,Object>>();		
			List<Map<String, Object>> entryList=new ArrayList<Map<String,Object>>();
		if (type.equals("save")) {
			User user = (User) request.getSession().getAttribute("loginUser");
			String fields="*";
			String where="uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id";
			     where +=" WHERE uc.userid="+user.getUserid();
			Map<String, Object> userrole =ownHeadService.findOwnHead(fields,where);
			String rolename=userrole.get("role_name")+"";
			 
			   StringBuilder sbf=new StringBuilder();
		     List<Map<String, Object>> userList= null;
		     
				if (rolename.indexOf("项目经理")!=-1) {
					sbf.append("uc_user uc JOIN uc_department ud ON uc.department=ud.department_id");
					sbf.append(" WHERE ud.department_name='经营部'");
				}else if (rolename.indexOf("经理")!=-1||rolename.indexOf("助理")!=-1) {
						if ((rolename.indexOf("总经理")!=-1)||(rolename.indexOf("助理")!=-1)) {
							sbf.append("uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id");
							sbf.append(" WHERE ro.role_name='采购专员'");
						}else {
							sbf.append("uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id ");
							sbf.append(" WHERE ro.role_name like '%总经理'");
						}
				}else {
					sbf.append("uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id");
					sbf.append(" WHERE ro.role_name like '%经理' AND ro.role_name NOT like '%项目经理'");
				}
				userList=ownHeadService.findOwnEntry(fields, sbf.toString());
		        mv.addObject("userList", userList);
		}else {
			//查询单头
		   String bizid=request.getParameter("bizId");
			String fields="head.*,pro.construct_project_name,cmy.company_name";
			StringBuilder sbf=new StringBuilder();
			sbf.append(" own_purchase_head head LEFT JOIN  construct_project_table pro");
			sbf.append(" on head.own_purchase_projectId=pro.construct_project_id");
			sbf.append(" LEFT JOIN uc_company  cmy ON  cmy.company_id=head.own_purchase_companyId");
			sbf.append(" WHERE head.own_purchase_id="+bizid);
		Map<String, Object> ownHead =ownHeadService.findOwnHead(fields, sbf.toString());
		   // 查询采购单据
		   String fields2="*";
		   String where=" own_purchase_entry entry where entry.own_purchase_parentId="+bizid;
	       entryList= ownHeadService.findOwnEntry(fields2, where);
	       jsonArray = JSONArray.fromObject(entryList);
				mv.addAllObjects(ownHead);
				String beyId = "ownHeadView"; // 流程实例key 请勿改动
				 historyList = activitiService.viewHisComments(bizid, beyId);					   
	     	}	  
		mv.addObject("jsonObject", jsonArray);
		jsonArray = JSONArray.fromObject(historyList);    		
		mv.addObject("historyList", jsonArray);
		mv.setViewName("ownCenter/ownHeadView");
		return mv;

	}
	
	@RequestMapping(value = "/saveOwnHead", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveOwnHead(OwnPurchaseHead ownHead,HttpServletRequest request) {
		Map<String, Object> json=new HashMap<String, Object>();
	try {
		 Date currentTime = new Date();
		   SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   String dateString = formatter.format(currentTime);
		ownHead.setOwn_purchase_time(dateString);
		ownHeadService.saveOwnHead(ownHead, request);	
		
		json.put("Success", true);
		json.put("Msg", "已提交!");
	} catch (Exception e) {
		e.printStackTrace();
		json.put("Success", false);
		json.put("Msg", "程序出错,请联系技术员");
	}
				
		return json;

	}
	
	
	
	
	@RequestMapping(value = "/ownHeadAut", method = RequestMethod.GET)
	public ModelAndView ownHeadAudit(String taskid,HttpServletRequest request) throws Exception {
		ModelAndView mv=new ModelAndView();
		String taskName =request.getParameter("taskName");
		String bizid = activitiService.getBusinessBizId(taskid);// 获取业务编号
		if(StringUtils.isNotBlank(bizid)){
			bizid = bizid.split("\\.")[1];
        }
		List<Map<String, Object>> historyList = activitiService.getProcessComments(taskid);// 查询审批记录
		
		 JSONArray jsonArray = new JSONArray();
		//查询单头
			String fields="head.*,pro.construct_project_name,cmy.company_name";
			StringBuilder sbf=new StringBuilder();
			sbf.append(" own_purchase_head head LEFT JOIN  construct_project_table pro");
			sbf.append(" on head.own_purchase_projectId=pro.construct_project_id");
			sbf.append(" LEFT JOIN uc_company  cmy ON  cmy.company_id=head.own_purchase_companyId");
			sbf.append(" WHERE head.own_purchase_id="+bizid);
		Map<String, Object> ownHead =ownHeadService.findOwnHead(fields, sbf.toString());
		   // 查询采购单据
		   String fields2="*";
		   String where=" own_purchase_entry entry where entry.own_purchase_parentId="+bizid;
	     List<Map<String, Object>> entryList= ownHeadService.findOwnEntry(fields2, where);  //查询单据
	     
	       jsonArray = JSONArray.fromObject(entryList);    
				mv.addAllObjects(ownHead);
				mv.addObject("jsonObject", jsonArray);
				 
	List<Map<String, Object>> userList= new ArrayList<Map<String,Object>>();
	       //查询人员
			if(taskName.equals("申请人")){	
				User user = (User) request.getSession().getAttribute("loginUser");
				String fields3="*";
				String where3=" uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id";
				     where3 +=" WHERE uc.userid="+user.getUserid();
				Map<String, Object> userrole =ownHeadService.findOwnHead(fields3,where3);
				String rolename=userrole.get("role_name")+"";
				
			        sbf.delete(0, sbf.length());
				if (rolename.indexOf("项目经理")!=-1) {
					sbf.append("uc_user uc JOIN uc_department ud ON uc.department=ud.department_id");
					sbf.append(" WHERE ud.department_name='经营部'");
				}else if (rolename.indexOf("经理")!=-1||rolename.indexOf("助理")!=-1) {
						if ((rolename.indexOf("总经理")!=-1)||(rolename.indexOf("助理")!=-1)) {
							sbf.append("uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id");
							sbf.append(" WHERE ro.role_name='采购专员'");
						}else {
							sbf.append("uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id ");
							sbf.append(" WHERE ro.role_name like '%总经理'");
						}
				}else {
					sbf.append("uc_user uc JOIN uc_role ro ON uc.role_id=ro.role_id");
					sbf.append(" WHERE ro.role_name like '%经理' AND ro.role_name NOT like '%项目经理'");
				}
				userList=ownHeadService.findOwnEntry("uc.userid,uc.username", sbf.toString());
		      			
			 }else {
                   userList = supOpinionService.supOpinionUser(
				   taskName, "ownHeadView"); //查询审核人
			}	
			 jsonArray = JSONArray.fromObject(historyList);    
			  mv.addAllObjects(ownHead);
			  mv.addObject("historyList", jsonArray);
			  mv.addObject("taskid", taskid);
			  mv.addObject("taskName", taskName);
			  mv.addObject("userList", userList);
	          mv.setViewName("ownCenter/ownHeadAudit");
		return mv;
		
	}
	
	@RequestMapping(value = "/ownHeadPass", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  ownHeadPass(OwnPurchaseHead head,HttpServletRequest request) {
		
      Map<String, Object> json=new HashMap<String, Object>();
			try {
				String own_purchase_id =request.getParameter("own_purchase_id");
				int bizid=Integer.parseInt(own_purchase_id);
				head.setOwn_purchase_id(bizid);
				ownHeadService.ownHeadPass(head, request);
				
				json.put("Success", true);
				json.put("Msg", "已提交!");
			} catch (Exception e) {
				e.printStackTrace();
				json.put("Success", false);
				json.put("Msg", "程序出错,请联系技术员");
			}
		return json;
	
		
	}
	
	@RequestMapping(value = "/deleteOwnEntry", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  deleteOwnEntry(String headId,String entryId,String type) {
		Map<String, Object> json=new HashMap<String, Object>();
		StringBuffer sbf=new StringBuffer();
		try {
			
	
		if (type.equals("head")) {
		   //级联删除
			sbf.append("own_purchase_head where own_purchase_id ="+headId);		
			ownHeadService.deleteEntry(sbf.toString());//级联删除 内容
			String where=" own_purchase_entry  where own_purchase_parentId="+headId;
			ownHeadService.deleteEntry(where);//级联删除 内容
			activitiService.deleteRecord(headId, "ownHeadView");//级联删除流程信息
			
		  }else if(type.equals("entry")){
			sbf.append("own_purchase_entry where own_purchase_entryId ="+entryId);
		    ownHeadService.deleteEntry(sbf.toString());
		 }
		
		json.put("Success", true);
		json.put("Msg", "已删除!");
	} catch (Exception e) {
		e.printStackTrace();
		json.put("Success", false);
		json.put("Msg", "程序出错,请联系技术员");
	}
		return json;
	}
		
	
	
}
