package com.casd.controller.manage;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

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
import com.casd.controller.web.utils.DownloadUtil;
import com.casd.entity.manage.Contractapprove;
import com.casd.entity.uc.User;
import com.casd.service.hr.ActivitiService;
import com.casd.service.manage.ContractapproveService;
import com.casd.service.manage.SupOpinionService;

@Controller
@RequestMapping("/admin")
public class ContractapproveController {

	@Autowired
	private ContractapproveService contractapproveService;
	@Autowired
	private ActivitiService activitiService;

	@Autowired
	private SupOpinionService supOpinionService;

	/**
	 * 合同审批列表
	 * 
	 * */
	@RequestMapping(value = "/contractapproveList", method = RequestMethod.GET)
	public ModelAndView contractapproveList() {
		ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Calendar now = Calendar.getInstance();
		int yearNum = now.get(Calendar.YEAR) - 2016;
		for (int j = 0; j < yearNum + 1; j++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("yearMon", 2016 + j);
			list.add(map);
		}

		mv.addObject("yearMon", list);
		mv.setViewName("manage/contractapproveList");
		return mv;

	}

	@RequestMapping(value = "/contractapproveList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> contractapproveList(HttpServletRequest request)
			throws Exception {
		Map<String, Object> jsonMap = new HashMap<String, Object>();

		StringBuilder sBuilder = new StringBuilder();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		int pageIndex = Integer.parseInt(request.getParameter("page")) - 1;
		Ref<Integer> record = new Ref<Integer>();
		String fields = "*";
		sBuilder.append(" manage_contractapprove ");
		sBuilder.append(" where 1=1");

		String manage_contractapprove_num = request
				.getParameter("manage_contractapprove_num");
		if (StringUtils.hasText(manage_contractapprove_num)) {
			sBuilder.append(" and manage_contractapprove_num like '%"
					+ manage_contractapprove_num + "%'");
		}
		String manage_contractapprove_name = request
				.getParameter("manage_contractapprove_name");
		if (StringUtils.hasText(manage_contractapprove_name)) {
			sBuilder.append(" and manage_contractapprove_name like '%"
					+ manage_contractapprove_name + "%'");
		}

		String manage_contractapprove_company = request
				.getParameter("manage_contractapprove_company");
		if (StringUtils.hasText(manage_contractapprove_company))
			sBuilder.append(" and manage_contractapprove_company like '%"
					+ manage_contractapprove_company + "%'");
		
		sBuilder.append(" order by manage_contractapprove_id DESC");

		List<Map<String, Object>> data = contractapproveService
				.contractapproveList(pageIndex, pageSize, record, fields,
						sBuilder.toString());
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> footMap = new HashMap<String, Object>();
		list.add(footMap);
		jsonMap.put("footer", list);
		jsonMap.put("rows", data);
		jsonMap.put("total", record.getValue());

		return jsonMap;
	}

	/**
	 * 新增，修改合同
	 * 
	 * */
	@RequestMapping(value = "/contractapproveNew", method = RequestMethod.GET)
	public ModelAndView contractapproveNew(HttpServletRequest request,
			Model model) throws Exception {
		ModelAndView mv = new ModelAndView();
		String bizId = request.getParameter("manage_contractapprove_id");
		Map<String, Object> contractapprove = new HashMap<String, Object>();
		JSONObject jsonObject = new JSONObject();
		List<Map<String, Object>> historyList = new ArrayList<Map<String, Object>>();
		String type = "";
		if (bizId.equals("")) {
			contractapprove.put("manage_contractapprove_id", 0);
			contractapprove.put("manage_contractapprove_amount", 0);
			contractapprove.put("manage_contractapprove_taxIncluded", 1);

			type = "'new'";
		} else {
			contractapprove = contractapproveService.getData(bizId);
			type = request.getParameter("type");
			String beyId = "contractapproveView"; // 流程实例key 请勿改动
			historyList = activitiService.viewHisComments(bizId, beyId);
			jsonObject.put("history", historyList);

		}
		mv.addObject("history", jsonObject);
		mv.addObject("type", type);
		mv.addObject("rows", jsonObject);
		mv.addObject("contractapprove", contractapprove);
		mv.setViewName("manage/contractapproveNew");
		return mv;
	}

	/**
	 * 
	 * 保存提交
	 * 
	 * */
	@RequestMapping(value = "/save_conApprove", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save_conApprove(Contractapprove contractapprove,
			HttpServletRequest request) throws IOException {
		Map<String, Object> json = new HashMap<String, Object>();

		try {
			// 获取原始文件名
			String timeStr="";
			if(!StringUtils.isEmpty(contractapprove.getContractFile().getOriginalFilename())){
				
				MultipartFile file = contractapprove.getContractFile();
				String fileName = file.getOriginalFilename();
	
				if (StringUtils.isEmpty(fileName)) {
					json.put("Success", false);
					json.put("Msg", "请选择要导的文件");
					return json;
				}
	
				File file2 = new File("e:/uploadfile/photo/contractFile");
				if (!file2.exists()) {
					file2.mkdirs();
				}
				// 定义文件路径
				String fileUploadBasePath = "e:/uploadfile/photo/contractFile/";
				timeStr = System.currentTimeMillis() + fileName;
				String newFilePath = fileUploadBasePath + timeStr;
				File newFile = new File(newFilePath);
				file.transferTo(newFile); // 写入文件到服务器目录
			}
			User user = (User) request.getSession().getAttribute("loginUser");
			String userid = user.getUserid() + "";// 获取申请人
			contractapprove.setManage_contractapprove_attachAddress(timeStr);
			contractapproveService.saveContractapprove(contractapprove, userid,user.getUsername());

			json.put("Success", true);
			json.put("Msg", "操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "上传失败" + e);
		}
		return json;

	}

	/**
	 * 合同审批删除
	 * 
	 * */
	@RequestMapping(value = "/delete_Contractapprove", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete_Contractapprove(HttpServletRequest request)
			throws Exception {
		String bizId = request.getParameter("manage_contractapprove_id");

		contractapproveService.delete_Contractapprove(bizId);
		return null;

	}

	/**
	 * 合同审批
	 * 
	 * @throws Exception
	 * 
	 * */
	@RequestMapping(value = "/contractapproveAut", method = RequestMethod.GET)
	public ModelAndView contractapproveAut(HttpServletRequest request)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		String taskid = request.getParameter("taskid");// 获取任务id
		String taskName = request.getParameter("taskName");
		String bizkey = activitiService.getBusinessBizId(taskid);// 获取业务编号

		String[] strs = bizkey.split("\\.");
		String bizId = null; // 业务编号
		for (int i = 0, len = strs.length; i < len; i++) {
			bizId = strs[i].toString();
		}

		List<String> bot = activitiService.findOutComeListByTaskId(taskid);// 查看当前有几条线

		if (bot.size() > 1) {
			mv.addObject("bot", "提交");
			mv.addObject("both", "驳回");
		} else {
			mv.addObject("bot", "提交");
		}

		mv.addObject("botlist", bot);

		String string = "*";
		StringBuffer sBuffer = new StringBuffer();
		sBuffer.append(" manage_contractapprove  where manage_contractapprove_id="
				+ bizId + "");

		Map<String, Object> contractapprove = contractapproveService
				.findContractapprove(string, sBuffer.toString());
		List<Map<String, Object>> userList = supOpinionService.supOpinionUser(
				taskName, "contractapproveView");

		List<Map<String, Object>> historyList = activitiService
				.getProcessComments(taskid);// 查询审批记录

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("history", historyList);
		mv.addObject("history", jsonObject);

		mv.addObject("contractapprove", contractapprove);
		mv.addObject("userList", userList);
		mv.addObject("taskid", taskid);
		mv.addObject("taskName", taskName);
		mv.setViewName("manage/contractapproveAut");
		return mv;

	}

	/**
	 * 项目合同审核
	 * 
	 * */
	@RequestMapping(value = "/contractapprovePass", method = RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> contractapprovePass(HttpServletRequest request) {
		Map<String, Object> json = new HashMap<String, Object>();
		try {
			contractapproveService.contractapprovePass(request);
			json.put("Success", true);
			json.put("Msg", "已审核");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "操作失败,请联系管理员");
		}
		return json;

	}

	// 下载
	@RequestMapping(value = "/downloadCon", method = RequestMethod.POST)
	@ResponseBody
	public void downloadCon(HttpServletRequest request,
			HttpServletResponse response) {
		String fileurl = "e:/uploadfile/photo/contractFile/"+request.getParameter("attachAddress");
		DownloadUtil downloadUtil = new DownloadUtil();
		downloadUtil.saveUrlAs(fileurl, request, response);
	}

}
