package com.casd.entity.construct;

import java.io.Serializable;
import java.sql.Date;

/**
 *    采购单头 construct_purchase_head_class
 * */
public class PurchaseHeadClass implements Serializable{
	
	private int construct_purchase_id;					//采购单id
	private Date construct_purchase_planDate;			//计划日期
	private Date construct_purchase_arriveDate;		//希望送达时间
	private String construct_purchase_planMan;			//计划员
	private String construct_purchase_reviewer;			//复核员
	private String construct_purchase_supplier;			//供应商
	private String construct_purchase_supplierTel;		//供应商联系方式
	private int construct_purchase_projectId;			//项目id
	private int construct_purchase_status;				//状态
	private int construct_purchase_applyId;				//采购申请单id

	
	public int getConstruct_purchase_id() {
		return construct_purchase_id;
	}
	public void setConstruct_purchase_id(int construct_purchase_id) {
		this.construct_purchase_id = construct_purchase_id;
	}
	public Date getConstruct_purchase_planDate() {
		return construct_purchase_planDate;
	}
	public void setConstruct_purchase_planDate(Date construct_purchase_planDate) {
		this.construct_purchase_planDate = construct_purchase_planDate;
	}
	public Date getConstruct_purchase_arriveDate() {
		return construct_purchase_arriveDate;
	}
	public void setConstruct_purchase_arriveDate(Date construct_purchase_arriveDate) {
		this.construct_purchase_arriveDate = construct_purchase_arriveDate;
	}
	public String getConstruct_purchase_planMan() {
		return construct_purchase_planMan;
	}
	public void setConstruct_purchase_planMan(String construct_purchase_planMan) {
		this.construct_purchase_planMan = construct_purchase_planMan;
	}
	public String getConstruct_purchase_reviewer() {
		return construct_purchase_reviewer;
	}
	public void setConstruct_purchase_reviewer(String construct_purchase_reviewer) {
		this.construct_purchase_reviewer = construct_purchase_reviewer;
	}
	public String getConstruct_purchase_supplier() {
		return construct_purchase_supplier;
	}
	public void setConstruct_purchase_supplier(String construct_purchase_supplier) {
		this.construct_purchase_supplier = construct_purchase_supplier;
	}
	public String getConstruct_purchase_supplierTel() {
		return construct_purchase_supplierTel;
	}
	public void setConstruct_purchase_supplierTel(
			String construct_purchase_supplierTel) {
		this.construct_purchase_supplierTel = construct_purchase_supplierTel;
	}
	public int getConstruct_purchase_projectId() {
		return construct_purchase_projectId;
	}
	public void setConstruct_purchase_projectId(int construct_purchase_projectId) {
		this.construct_purchase_projectId = construct_purchase_projectId;
	}
	public int getConstruct_purchase_status() {
		return construct_purchase_status;
	}
	public void setConstruct_purchase_status(int construct_purchase_status) {
		this.construct_purchase_status = construct_purchase_status;
	}
	public int getConstruct_purchase_applyId() {
		return construct_purchase_applyId;
	}
	public void setConstruct_purchase_applyId(int construct_purchase_applyId) {
		this.construct_purchase_applyId = construct_purchase_applyId;
	}

	

}
