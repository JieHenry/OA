package com.casd.controller.ownCenter;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.activiti.engine.impl.task.TaskDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.casd.controller.web.Ref;
import com.casd.controller.web.common.JumpActivityCmd;
import com.casd.controller.web.utils.ActivitUtil;
import com.casd.controller.web.utils.DownloadUtil;
import com.casd.entity.ownCenter.Seal;
import com.casd.service.hr.ActivitiService;
import com.casd.service.manage.SupOpinionService;
import com.casd.service.ownCenter.SealService;

@Controller
@RequestMapping("/admin")
public class SealController {

	@Autowired
	private SealService sealService;
	
	@Autowired
	private SupOpinionService supOpinionService;
	
	@Autowired
	private ActivitiService activitiService;
	

	/**
	 * 盖章列表
	 */
	@RequestMapping(value = "/sealList", method = RequestMethod.GET)
	public ModelAndView sealList(HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("ownCenter/sealList");
		return mv;
	}

	@RequestMapping(value = "/sealList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sealList(HttpServletRequest request, Model model)
			throws Exception {
		Map<String, Object> jsonMap = new HashMap<String, Object>();

		StringBuilder sBuilder = new StringBuilder();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		int pageIndex = Integer.parseInt(request.getParameter("page")) - 1;
		Ref<Integer> record = new Ref<Integer>();
		String fields = "*";
		sBuilder.append(" own_seal seal left join uc_company com on seal.own_seal_company=com.company_id");
		sBuilder.append(" where 1=1");

		String company_name = request.getParameter("company_name");
		if (StringUtils.hasText(company_name)) {
			sBuilder.append(" and com.company_name like '%" + company_name
					+ "%'");
		}
		
		  String own_seal_fileName = request.getParameter("own_seal_fileName");
		if (StringUtils.hasText(own_seal_fileName)) {
			sBuilder.append(" and own_seal_fileName like '%"
					+ own_seal_fileName + "%'");
		}
		sBuilder.append(" ORDER BY own_seal_id DESC");

		List<Map<String, Object>> data = sealService.sealList(pageIndex,
				pageSize, record, fields, sBuilder.toString());
		jsonMap.put("rows", data);
		jsonMap.put("total", record.getValue());
		return jsonMap;

	}

	/**
	 * 查看界面
	 * @throws Exception 
	 * 
	 * */
	@RequestMapping(value = "/sealView", method = RequestMethod.GET)
	public ModelAndView sealView(HttpServletRequest request, Model model) throws Exception {
		ModelAndView mv = new ModelAndView();
		int own_seal_id = Integer.valueOf(request.getParameter("bizId")
				.toString());

		 String fields=" * ";
	     StringBuilder sbf=new StringBuilder();
	     sbf.append(" uc_company com left join  own_seal seal on com.company_id=seal.own_seal_company");
	     sbf.append("  where own_seal_id="+own_seal_id);
		List<Map<String, Object>> data = sealService.getData(fields,sbf.toString());
		
		String bizId = String.valueOf(own_seal_id);
		String beyId = "sealView"; // 流程实例key 请勿改动

		List<Map<String, Object>> historyList = activitiService.viewHisComments(bizId, beyId);
		
		//审核历史意见
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("history", historyList);
		model.addAttribute("history", jsonObject);
			model.addAttribute("data", data.get(0));
		mv.setViewName("ownCenter/sealView");
		return mv;
	}

	/**
	 * 盖章新增、修改
	 */
	@RequestMapping(value = "/sealNew", method = RequestMethod.GET)
	public ModelAndView sealNew(HttpServletRequest request, Model model)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		
		String own_seal_id = request.getParameter("own_seal_id");
		Map<String, Object> seal = new HashMap<String, Object>();
		List<Map<String, Object>> data=new ArrayList<Map<String,Object>>();
		String type = "";
		 List<TaskDefinition> sdsDefinitions=JumpActivityCmd.taskDefinitionList("sealView:7:427504", "startevent2");
		if (own_seal_id.equals("")) {
	
			seal.put("own_seal_id", 0);
			seal.put("own_seal_settle", 0);
			type = "new";
			mv.addObject("sdsDefinitions", sdsDefinitions);
			mv.addObject("seal", seal);			
		} else {
			type = "edit";
			 String fields=" * ";
		     StringBuilder sbf=new StringBuilder();
		     sbf.append(" uc_company com left join  own_seal seal on com.company_id=seal.own_seal_company");
		     sbf.append("  where own_seal_id="+own_seal_id);	
		 	data = sealService.getData(fields,sbf.toString());
			mv.addObject("seal", data.get(0));
		}
		mv.addObject("type", type);
		
		mv.setViewName("ownCenter/sealNew");
		return mv;

	}

	/**
	 * 删除
	 * 
	 * */
	@RequestMapping(value = "/delect_seal", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delect_seal(HttpServletRequest request) {
		String own_seal_id = request.getParameter("own_seal_id");
		String own_seal_filePath = request.getParameter("own_seal_filePath");

		Map<String, Object> json = new HashMap<String, Object>();
		try {
			if(!own_seal_filePath.equals("")){
				File file = new File("E:/file/casd/sealFile/"+own_seal_filePath);
			    if (file.exists()) {
			        file.delete();
			    }
			}
			Map<String, Object> map = new HashMap<String, Object>();
			StringBuffer sbf = new StringBuffer();
			sbf.append(" own_seal where own_seal_id=" + own_seal_id);
			map.put("where", sbf);
			sealService.delete_data(map);
			String beyId="sealView."+own_seal_id;
			activitiService.deleteRecord(own_seal_id, beyId);
		} catch (Exception e) {
			json.put("msg", "删除失败!");
			e.printStackTrace();
		}
		return json;

	}

	/**
	 * 保存
	 * 
	 * */
	@RequestMapping(value = "/save_seal", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save_seal(MultipartFile sealFile, HttpServletRequest request, Seal seal)
			throws Exception {
		Map<String, Object> json = new HashMap<String, Object>();
		try {
		// 获取原始文件名		
		String timeStr = "";
		String fileName = sealFile.getOriginalFilename();
		if (!fileName.equals("")) {

			if (StringUtils.isEmpty(fileName)) {
				json.put("Success", false);
				json.put("Msg", "请选择要导的文件");
				return json;
			}
			File file2 = new File("E:/file/casd/sealFile");
			if (!file2.exists()) {
				file2.mkdirs();
			}
			// 定义文件路径
			String fileUploadBasePath = "E:/file/casd/sealFile/";
			timeStr = System.currentTimeMillis() + fileName;
			String newFilePath = fileUploadBasePath + timeStr;
			File newFile = new File(newFilePath);
			sealFile.transferTo(newFile); // 写入文件到服务器目录
			seal.setOwn_seal_filePath(timeStr);
		  }
		int id=seal.getOwn_seal_id();		
		if (id==0) {
			Date date = new Date(System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String createdate = sdf.format(date);
			seal.setOwn_seal_creatTime(createdate);
          sealService.start_seal(request, seal); //保存数据时 启动流程
			id=seal.getOwn_seal_id();		
		}else {
			sealService.save_seal(seal);
		}

		json.put("id", id);
		json.put("Success", true);
		json.put("Msg", "保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "上传失败" + e);
		}
		return json;
	}
	
	// 下载
	@RequestMapping(value = "/downloadseal", method = RequestMethod.POST)
	@ResponseBody
	public void downloadseal(HttpServletRequest request,
			HttpServletResponse response) {
		String fileurl = "E:/file/casd/sealFile/"+request.getParameter("own_seal_filePath");
	
		DownloadUtil.saveUrlAs(fileurl, request, response);
	}
	
      /**
       * 审核页面
     * @throws Exception 
       * 
       * */
	@RequestMapping(value = "/seal_Audit", method = RequestMethod.GET)
	public ModelAndView seal_Audit(String taskid,String taskName,String processInstanceId) throws Exception {
		ModelAndView mv=new ModelAndView();
		
		String bizkey = activitiService.getBusinessBizId(taskid);// 获取业务编号

		String[] strs = bizkey.split("\\.");
		String bizId = null; // 业务编号
		for (int i = 0, len = strs.length; i < len; i++) {
			bizId = strs[i].toString();
		}
		
		 String fields=" * ";
	     StringBuilder sbf=new StringBuilder();
	     sbf.append(" uc_company com left join  own_seal seal on com.company_id=seal.own_seal_company");
	     sbf.append("  where own_seal_id="+bizId);

	 	List<Map<String, Object>> data 	= sealService.getData(fields,sbf.toString());
	
		List<TaskDefinition> taskDefinitions=	activitiService.nextTaskDefinition(taskid);

		List<Map<String, Object>> historyList = activitiService
				.getProcessComments(taskid);// 查询审批记录
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("history", historyList);
		mv.addObject("history", jsonObject);
		

		mv.addObject("taskName", taskName);
		mv.addObject("taskid", taskid);
		mv.addObject("processInstanceId", processInstanceId);
		mv.addObject("taskDefinitions", taskDefinitions);
	    mv.addObject("data",data.get(0));
		mv.setViewName("ownCenter/sealAudit");
		return mv;
	
	}
	  /**
	   * 盖章审核
	   * 
	   * */
	    @RequestMapping(value = "/pass_seal", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> pass_seal(HttpServletRequest request) {
	    	Map<String, Object> json=new HashMap<String, Object>();
           try {
        	  String nextUser=request.getParameter("username"); //下一个人审核人
		    sealService.pass_seal(request);
		    
		    String theme="盖章申请";
		 /*   String content="你有一张盖章申请单需要审核！";
			activitiService.sendEmail(theme, content, nextUser);*/
			json.put("Success", true);
			json.put("Msg", "已审核!");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "程序出错,请联系技术员");
	    	}
			return json;
	  }
	    
	    /**  
	     * 修改
	     * 
	     * */ 
	    @RequestMapping(value = "/update_Seal", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> updateSeal(Seal seal){
	    	Map<String, Object> json=new HashMap<String, Object>();
	    	
	    	try {
	    
	    	sealService.updateSeal(seal);
	    	json.put("Success", true);
			json.put("Msg", "已修改!");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "程序出错,请联系技术员");
	    	}
			return json;
	    }
	    
	    @RequestMapping(value = "/getsealViewUser", method = RequestMethod.GET)
	    @ResponseBody
        public List<Map<String, Object>> getsealViewUser(String nodeName) {
	    	
	    	List<Map<String, Object>> userList = supOpinionService.supOpinionUser(
	    			nodeName, "sealView");
			return userList;
		}
	
	    /**
	     *   获取节点审核人
	     * */
	    @RequestMapping(value = "/loadCourse", method = RequestMethod.GET)
	    @ResponseBody
	    public JSONArray loadCourse(String nodeName) throws Exception {
	    	List<Map<String, Object>> userList=new ArrayList<Map<String,Object>>();
		  JSONArray jsonArray=new JSONArray();
		
			try {
				if(nodeName != null && nodeName != ""){
				
					userList = supOpinionService.supOpinionUser(
			    			nodeName, "sealView");
				jsonArray=JSONArray.fromObject(userList);
				}
			} catch (Exception e) {
			
			}
			return jsonArray;
		}


}
