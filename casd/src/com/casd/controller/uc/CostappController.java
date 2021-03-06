package com.casd.controller.uc;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.casd.controller.web.Ref;
import com.casd.entity.uc.Costapp;
import com.casd.entity.uc.User;
import com.casd.service.hr.ActivitiService;
import com.casd.service.manage.SupOpinionService;
import com.casd.service.uc.CostappService;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
@RequestMapping("/admin")
public class CostappController<costapp> {

	@Autowired
	private CostappService costappService;
	@Autowired
	private ActivitiService activitiService;
	@Autowired
	private SupOpinionService supOpinionService;

	@RequestMapping(value = "/costappList", method = RequestMethod.GET)
	public ModelAndView costappList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("uc/costappList");
		return mv;

	}

	@RequestMapping(value = "/costappList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> costappList(HttpServletRequest request)
			throws Exception {
		Map<String, Object> jsonMap = new HashMap<String, Object>();

		StringBuilder sBuilder = new StringBuilder();
		int pageSize = Integer.parseInt(request.getParameter("rows"));
		int pageIndex = Integer.parseInt(request.getParameter("page")) - 1;
		Ref<Integer> record = new Ref<Integer>();
		String fields = "*";
		sBuilder.append(" uc_costapp ");
		sBuilder.append(" where 1=1");

		String costapp_company = request.getParameter("costapp_company");
		if (StringUtils.hasText(costapp_company)) {
			sBuilder.append(" and costapp_company like '%" + costapp_company
					+ "%'");
		}
	
		sBuilder.append(" order by costapp_id desc ");
	
		// 部门列表
		List<Map<String, Object>> data = costappService.costappList(pageIndex,
				pageSize, record, fields, sBuilder.toString());
		jsonMap.put("rows", data);
		jsonMap.put("total", record.getValue());

		return jsonMap;

	}

	/**
	 * 绩效考核新增界面,修改界面
	 * 
	 * @throws Exception
	 * 
	 * */
	@RequestMapping(value = "/costappNew", method = RequestMethod.GET)
	public ModelAndView costappNew(HttpServletRequest request, Model model)
			throws Exception {
		ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();

		// List<Map<String, Object>>userList =
		// supOpinionService.supOpinionUser("绩效考核申请","achReviewView");

		if (request.getParameter("costapp_id") != "") {
			int costapp_id = Integer.valueOf(request.getParameter("costapp_id")
					.toString());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("costapp_id", costapp_id);
			data = costappService.getData(map);
			model.addAttribute("data", data.get(0));
			mv.addObject("edit", false);
		} else {
			mv.addObject("edit", true);
		}
		// mv.addObject("userList", userList);
		mv.setViewName("uc/costappNew");
		return mv;

	}

	/**
	 * 申请查看界面
	 * 
	 * */
	@RequestMapping(value = "/costappView", method = RequestMethod.GET)
	public ModelAndView costappView(HttpServletRequest request, Model model) {
		int costapp_id = Integer.valueOf(request.getParameter("bizId")
				.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("costapp_id", costapp_id);
		List<Map<String, Object>> data = costappService.getData(map);
		model.addAttribute("data", data.get(0));
		ModelAndView mv = new ModelAndView();
		mv.setViewName("uc/costappView");
		return mv;
	}

	/**
	 * 绩效考核删除
	 * 
	 * */
	@RequestMapping(value = "/delect_costapp", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delect_costapp(HttpServletRequest request) {
	
		Map<String, Object> json = new HashMap<String, Object>();

		try {
			String costapp_id = request.getParameter("costapp_id");
			System.out.println(costapp_id);
			Map<String, Object> map = new HashMap<String, Object>();
			StringBuffer sbf = new StringBuffer();
			sbf.append(" uc_costapp where costapp_id=" + costapp_id);
			map.put("where", sbf);
			costappService.delete_data(map);
           activitiService.deleteRecord(costapp_id, "costappView");
			json.put("Success", true);
			json.put("Msg", "提交成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "保存失败");
        }

		return json;

	}

	/**
	 * 申请保存
	 * 
	 * */
	@RequestMapping(value = "/save_costapp", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save_costapp(HttpServletRequest request)
			throws Exception {

		Map<String, Object> json = new HashMap<String, Object>();

		try {
			Costapp costapp = new Costapp();
			String costapp_amount = request.getParameter("costapp_amount");
			String costapp_id = request.getParameter("costapp_id");
			boolean off = false; // 定义开关是否启动流程
			if (costapp_id == null || StringUtils.isEmpty(costapp_id)) {
				costapp.setCostapp_id(0);
				//设置申请时间
				 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
				costapp.setCostapp_time(df.format(new Date()));

				User user=(User) request.getSession().getAttribute("loginUser");//当前办理人
			    int userid=user.getUserid();  //申请人
			    costapp.setUserid(userid);	    
				off = true;
			} else {
				costapp.setCostapp_id(Integer.valueOf(request.getParameter(
						"costapp_id").toString()));
				
			}
			if (costapp_amount == null || StringUtils.isEmpty(costapp_amount)) {
				costapp.setCostapp_amount((double) 0);

			} else {
				costapp.setCostapp_amount(Double.valueOf(request.getParameter(
						"costapp_amount").toString()));
			}
			costapp.setCostapp_appitem(request.getParameter("costapp_appitem"));
			costapp.setCostapp_company(request.getParameter("costapp_company"));
			costapp.setCostapp_application(request
					.getParameter("costapp_application"));
			costapp.setCostapp_managerview(request
					.getParameter("costapp_managerview"));
			costapp.setCostapp_chairmanview(request
					.getParameter("costapp_chairmanview"));
			costapp.setCostapp_majoyview(request
					.getParameter("costapp_majoyview"));
			costapp.setCostapp_financeview(request
					.getParameter("costapp_financeview").trim());
			costappService.save_costapp(costapp);

			// 保存成功后启动流程
			if (off) {
				User user = (User) request.getSession().getAttribute(
						"loginUser");
				String userid = user.getUserid() + "";// 获取申请人
				String processDefinitioKey = "costappView"; // 定义流程的key,不可修改
				String title = "费用申请"; // 请注意
				String bizId = processDefinitioKey + "."
						+ costapp.getCostapp_id();
				activitiService.startProcesses(bizId, userid,
						processDefinitioKey, title);
			}

			json.put("Success", true);
			json.put("Msg", "保存成功");
		    }catch (Exception e) {
			e.printStackTrace();
			json.put("Success", false);
			json.put("Msg", "保存失败");
		  }
		return json;
	   }

	@RequestMapping(value = "/costappAudit", method = RequestMethod.GET)
	public ModelAndView costappAudit(String taskid,String taskName) {
		ModelAndView mv = new ModelAndView();
		
		String bizkey = activitiService.getBusinessBizId(taskid);// 获取业务编号

		String[] strs = bizkey.split("\\.");
		String bizId = null; // 业务编号
		for (int i = 0, len = strs.length; i < len; i++) {
			bizId = strs[i].toString();
		}
		String fields="*";
		String where=" uc_costapp where costapp_id="+bizId;
		Map<String, Object> param=costappService.findCostapp(fields, where);		
		List<Map<String, Object>> userList = supOpinionService.supOpinionUser(
				taskName, "costappView"); //查询审核人	
		
		List<String> bot = activitiService.findOutComeListByTaskId(taskid);// 查看当前有几条线	
		
		mv.addAllObjects(param);
		
		mv.addObject("taskid", taskid);
		mv.addObject("taskName", taskName);
	    mv.addObject("userList",userList);  
	    mv.addObject("bot",bot);  
		mv.setViewName("uc/costappAudit");
		return mv;
	  }
	
	     /**
	      * 费用申请审核
	      * 
	      * */
    	@RequestMapping(value = "/pass_costapp", method = RequestMethod.POST)
    	@ResponseBody
	  public Map<String, Object> pass_costapp(HttpServletRequest request,Costapp costapp) {
    		Map<String, Object> json=new HashMap<String, Object>();
    		try {
			    Map<String, Object> map=new HashMap<String, Object>();
    			String taskName=request.getParameter("taskName");
    			if (!taskName.equals("申请人")&&!taskName.equals("管理公司")){
	    			User user=(User) request.getSession().getAttribute("loginUser");//当前办理人
				    String auditor=request.getParameter("auditor").toString();
			    	String param=request.getParameter("param").toString()+"--"
			    			+user.getUsername()+ new SimpleDateFormat("yyyy-MM-dd").format(new Date()).toString();
	
			    	String costapp_id=request.getParameter("costapp_id").toString();
			    	
				    StringBuffer stringBuffer=new StringBuffer();
				    stringBuffer.append( auditor+" = '"+param +"' where costapp_id="+costapp_id+" ");
				    map.put("what", stringBuffer);
    			}
    	       costappService.pass_costapp(request, costapp,map);
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
    	 * 打印费用申请表
    	 * @throws DocumentException 
    	 * @throws IOException 
    	 * 
    	 * */
    	@RequestMapping(value = "/costappPrint", method = RequestMethod.GET)
        public void costappPrint(HttpServletResponse response,String biz,HttpServletRequest request) throws IOException, DocumentException{
    		
    		OutputStream out=null;
    		ByteArrayOutputStream baos=null;
    	try {
		
    		String fields="us.username,cst.costapp_company,cst.costapp_application,";
    		fields +="cst.costapp_appitem,cst.costapp_amount,cst.costapp_majoyview,";
    		fields +="cst.costapp_managerview,cst.costapp_financeview,";
    		fields +="cst.costapp_assistant,cst.costapp_chairmanview";

    		StringBuffer sbf=new StringBuffer();
    		sbf.append(" uc_costapp cst LEFT JOIN  uc_user us on cst.userid=us.userid");
    		sbf.append(" WHERE cst.costapp_id="+biz);
    		
    	  Map<String, Object> dataMap=costappService.findCostapp(fields,sbf.toString());
    		
		 baos=this.simplePDF(request,dataMap); 
		//设置请求返回类型 
		String fileName=System.currentTimeMillis()+".pdf";
		response.setContentType("application/pdf"); 
		response.setHeader("Content-Disposition", "attachment;filename="+fileName); 
		response.setContentLength(baos.size()); 
		 out = response.getOutputStream(); 
		baos.writeTo(out); 
		out.flush(); 
		out.close(); 
		
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			if (out!=null) {
				out.close(); 
			}if(baos!=null){
				baos.close();
			}
			
			
			
		}
    	  
    	  

    	 
		}
    	
    	
    	
         //下载输出
    	public  ByteArrayOutputStream simplePDF(HttpServletRequest request,Map<String, Object> dataMap) {
    	    ByteArrayOutputStream baos = new ByteArrayOutputStream();  
    	    PdfWriter writer =null;
    	    Document document=null;
    	    try {
    	    	String realPath = request.getSession().getServletContext().getRealPath("/");
    			String fontPath =realPath+"res/print/simsun.ttc";
    	        BaseFont bfChinese = BaseFont.createFont(fontPath+",1",
    					BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
    	  
    	        Font yahei1px = FontFactory.getFont(fontPath+",1", BaseFont.IDENTITY_H, 20);
    	        Font yahei10px = new Font(bfChinese, 12.0F, 0);
    	       
    	         document = new Document();
    	        writer = PdfWriter.getInstance(document,baos);  
    	           document.open();	        	
    	        	 PdfPCell cell = cell("费用报销", yahei1px, Element.ALIGN_CENTER, Element.ALIGN_MIDDLE);
                     cell.setColspan(2);
    	             PdfPTable  table = new PdfPTable(2);
	    	             cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
	    	             cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    	             cell.setBorder(0);
	    	             cell.setColspan(2);
	    	             table.addCell(cell);
    	             
    	             PdfPCell cell1 = new PdfPCell();
	    	             cell1 = new PdfPCell(new Paragraph("  ", yahei10px));
	    	             cell1.setBorder(0);
	    	             cell1.setColspan(2);
	    	             table.addCell(cell1);
	    	            
    	                //设置表格具体宽度
    	                table.setTotalWidth(120);
    	                //设置每一列所占的长度
    	                    table.setWidths(new float[]{7f, 25f});
    	                    table.addCell(cell("公司/部门", yahei10px));    
    	    	            table.addCell(cell(dataMap.get("costapp_company")+"", yahei10px));
    	    	            table.addCell(cell("申请事项", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_appitem")+"", yahei10px));
    	    	            table.addCell(cell("申请类型", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_application")+"", yahei10px));
    	    	            table.addCell(cell("费用金额", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_amount")+"", yahei10px));
    	    	            table.addCell(cell("主办部门意见", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_majoyview")+"", yahei10px));
    	    	            table.addCell(cell("总经理意见", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_managerview")+"", yahei10px));
    	    	            table.addCell(cell("财务经理意见", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_financeview")+"", yahei10px));
    	    	            table.addCell(cell("董事助理意见", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_assistant")+"", yahei10px));
    	    	            table.addCell(cell("董事长意见", yahei10px));
    	    	            table.addCell(cell(dataMap.get("costapp_chairmanview")+"", yahei10px));
    	    	            table.addCell(cell("管理公司", yahei10px));
    	    	            table.addCell(cell("出纳", yahei10px));
    	                document.add(table);
    	                document.close();
    	    } catch (Exception e) {
    	        e.printStackTrace();
    	    }finally{
    	    	if(document!=null){
    	    		 document.close();
    	    	}
    	    	 
    	    }
    	    
    	    return baos;
    	}
    
    
    	//
     private static PdfPCell cell(String content, Font font) {
  	        PdfPCell cell = new PdfPCell(new Phrase(content, font));
  	        cell.setBorderColor(new BaseColor(196, 196, 196));
  	        cell.setPadding(5.0f);
  	        cell.setMinimumHeight(60);  
  	        
  	        cell.setPaddingTop(1.0f);
  	      /*  cell.setHorizontalAlignment(Element.ALIGN_CENTER); //水平居中
  	        cell.setVerticalAlignment(Element.ALIGN_MIDDLE); //垂直居中
*/  	        return cell;
  	    }

  	    private static PdfPCell cell(String content, Font font, int hAlign, int vAlign) {
  	        PdfPCell cell = new PdfPCell(new Phrase(content, font));
  	        cell.setBorderColor(new BaseColor(196, 196, 196));
  	        cell.setVerticalAlignment(vAlign);
  	        cell.setHorizontalAlignment(hAlign);
  	        cell.setPadding(5.0f);
  	        cell.setPaddingTop(1.0f);
  	        return cell;
  	    }

}
