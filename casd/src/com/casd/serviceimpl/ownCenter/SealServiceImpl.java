package com.casd.serviceimpl.ownCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.casd.controller.web.Ref;
import com.casd.dao.activiti.ActivitiDao;
import com.casd.dao.ownCenter.SealDao;
import com.casd.entity.activiti.DataProcinst;
import com.casd.entity.ownCenter.Seal;
import com.casd.entity.uc.User;
import com.casd.service.hr.ActivitiService;
import com.casd.service.ownCenter.SealService;
import com.casd.service.uc.UserService;


@Service
public class SealServiceImpl implements SealService {
	@Autowired
	private SealDao sealDao;
	@Autowired
	private ActivitiService activitiService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private  RuntimeService runtimeService;
	
	@Autowired
	private UserService userService;
	@Autowired
	private  ActivitiDao activitiDao;
	
	@Override
	@Transactional
	public List<Map<String, Object>> getData(String fields,String where) {
		
		Map<String, Object> daoMap=new HashMap<String, Object>();
		daoMap.put("fields",fields);
		daoMap.put("where",where);
		return sealDao.getData(daoMap);
	}
	
	
	@Transactional
	public void save_seal(Seal seal) {
		sealDao.save_seal(seal);
	}



	@Override
	@Transactional
	public void delete_data(Map<String, Object> map) {
		 sealDao.delete_data(map);
		
	}



	@Override
	@Transactional
	public List<Map<String, Object>> sealList(int page, int pageSize,
			Ref<Integer> record, String fields, String where) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fields", fields);
		param.put("where", where);

	
		if (record != null) {
			Integer count = sealDao.getCount(param);
			record.setValue(count);
		}
		// 分页
		if (pageSize <= 0)
			throw new Exception("pageSize 必须 > 0");

		param.put("limit", String.format("limit %1$s,%2$s", page < 0 ? 0 : page
				* pageSize, pageSize));
		return sealDao.getList(param);
		
		
	
	}

  /**
   * 修改流程状态
   *  @param  execution  为流程设定参数
   *  @param status      流程设定状态
   * 
   * */
	@Override
	@Transactional
	public void updateSealProcess(DelegateExecution execution, String status) {
	    String bizkey= execution.getProcessBusinessKey();
		
			String[] strs=bizkey.split("\\.");
	        String bizId=null;
			for(int i=0,len=strs.length;i<len;i++){
				bizId=strs[i].toString();
			}
		
			Seal seal=new Seal();
			seal.setOwn_seal_id(Integer.valueOf(bizId));
			seal.setOwn_seal_status((Integer.valueOf(status)));
		
			
			sealDao.updateSeal(seal);
			
			
	}
	
	

    /**
     *  启动盖章流程
     * @throws Exception 
     *  
     * */
	@Override
	@Transactional
	public void start_seal(HttpServletRequest request, Seal seal) throws Exception {
		
	
		User user = (User) request.getSession().getAttribute("loginUser");
		String name = user.getUserid()+"";// 获取申请人
		seal.setOwn_user_id(name);
		sealDao.save_seal(seal);
		int own_seal_id=seal.getOwn_seal_id();	
	
		String processDefinitioKey ="sealView"; // 定义流程的key,不可修改
		
		 String  taskName=request.getParameter("taskName");
		Map<String, Object> vars = new HashMap<String, Object>();
		vars.put("username", name);// 设置第一个人审批人为申请人
		vars.put("sign", taskName);// 节点
		
		/*//不是经理以上级别的
		if (rolename.indexOf("经理")==-1&& rolename.indexOf("助理")==-1) {		
			   //只要有公章
			if(category.indexOf("1")!=-1){
				vars.put("category",1);
				vars.put("role","普通职员");	
				//业务章
		    }else if (category.indexOf("5")!=-1) {
		    	vars.put("category",5);
				vars.put("role", "普通职员");
		    }else {
			     //其余
		    	 vars.put("category", 1);
			     vars.put("role", "普通职员");
		       }
            //经理级别
		}else if(rolename.indexOf("总经理")!=-1 ||rolename.indexOf("助理")!=-1){	
			//只要有公章
			if(category.indexOf("1")!=-1){
				
				vars.put("role", "总经理");
				vars.put("category", 1);
				//项目章
			}else if (category.indexOf("5")!=-1) {
				vars.put("role", "总经理");
				vars.put("category", 5);
			 }else {
				 vars.put("category", 2);
				 vars.put("role", "总经理");
		       }
		}else {
		    //经理级别
			//只要有公章
			if(category.indexOf("1")!=-1){
				vars.put("category",1);
				vars.put("role","经理");
				
				//项目章
			}else if (category.indexOf("5")!=-1) {
				vars.put("category",5);
				vars.put("role","经理");
			 }else {
				 vars.put("category", 2);
				 vars.put("role","经理");
		       }
		}*/
	
				
		 String bizId = processDefinitioKey + "."
				+ own_seal_id; //获取业务id
		 ProcessInstance pi=runtimeService.startProcessInstanceByKey(
					processDefinitioKey, bizId, vars);
		   
	 	   DataProcinst dataProcinst=new  DataProcinst();
			dataProcinst.setProc_inst_id_(pi.getId());
			dataProcinst.setApplicant(user.getUsername());
			dataProcinst.setIllustrate(seal.getOwn_seal_fileName());
		    activitiDao.insertDataProcinst(dataProcinst);
		   
		   }


	@Override
	public Seal findSealById(String fields, String where) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("fields", fields);
		param.put("where", where);
		return sealDao.findSealById(param);
		
		
	}


	@Override
	@Transactional
	public void pass_seal(HttpServletRequest request) throws Exception {
		
		String taskid=request.getParameter("taskid");
		String taskName=request.getParameter("taskName");
		String options=request.getParameter("options");//获取审核意见
		
		User user=(User) request.getSession().getAttribute("loginUser");//当前办理人
	    String userid=user.getUserid()+"";  //当前审核人id
		String category=request.getParameter("category"); //获取公章类型
		String sign=request.getParameter("sign"); //获取公章类型 
		Map<String, Object> vars=new HashMap<String, Object>();
			vars.put("sign",taskName);
		activitiService.comment(taskid,userid,options);
		taskService.complete(taskid,vars);			
	  }


	@Override
	@Transactional
	public void updateSeal(Seal seal) {

       sealDao.updateSeal(seal);
		
	} 

	//流程定义类方法
	  public  String sealnextUser(DelegateExecution execution) {
		  HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			String nextUser = request.getParameter("username");// 下一个审核人	
			return nextUser;		
		
	    }
}
