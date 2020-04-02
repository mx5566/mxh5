package controllers

import (
	"encoding/json"
	"fmt"
	"mxh5/enums"
	"mxh5/models"
	"strconv"
	"strings"

	"github.com/astaxie/beego/orm"
)

// 平台的游戏tab选项
type TabController struct {
	BaseController
}

func (this *TabController) GetTabStatus() map[int]string {
	mapGameStatus := make(map[int]string)
	mapGameStatus[1] = "开启"
	mapGameStatus[2] = "禁用"
	mapGameStatus[3] = "隐藏"

	return mapGameStatus
}

func (this *TabController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	this.CheckAuthor("DataGrid", "DataList", "UpdateSeq", "UpdateStatus")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//这里注释了权限控制，因此这里需要登录验证
	//this.checkLogin()
}

// Tab列表
func (this *TabController) Index() {

	//将页面左边菜单的某项激活
	this.Data["activeSidebarUrl"] = this.URLFor(this.controllerName + "." + this.actionName)
	this.SetTpl()
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["headcssjs"] = "tab/index_headcssjs.html"
	this.LayoutSections["footerjs"] = "tab/index_footerjs.html"

	var params = models.TabTypeQueryParam{}
	//获取数据列表和总数
	data := models.TabTypeDataList(&params)
	this.Data["mapTabTypes"] = data

	//页面里按钮权限控制
	this.Data["canEdit"] = this.CheckActionAuthor("TabController", "Edit")
	this.Data["canDelete"] = this.CheckActionAuthor("TabController", "Delete")
}

// DataGrid tab管理首页 表格获取数据
func (this *TabController) DataGrid() {
	//直接反序化获取json格式的requestbody里的值
	var params models.TabQueryParam
	json.Unmarshal(this.Ctx.Input.RequestBody, &params)
	//获取数据列表和总数
	data, total := models.TabPageList(&params)
	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	this.Data["json"] = result
	this.ServeJSON()
}

//DataList tab列表
func (this *TabController) DataList() {
	var params = models.TabQueryParam{}
	//获取数据列表和总数
	data := models.TabDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}

//Edit 添加、编辑tab
func (this *TabController) Edit() {
	if this.Ctx.Request.Method == "POST" {
		this.Save()
	}
	Id, _ := this.GetInt(":id", 0)
	m := models.Tab{TabId: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}
	}
	var params = models.TabTypeQueryParam{}
	//获取数据列表和总数
	data := models.TabTypeDataList(&params)

	this.Data["m"] = m
	this.Data["mapGameTabs"] = this.GetTabStatus()
	this.Data["mapTabTypes"] = data
	this.SetTpl("tab/edit.html", "shared/layout_pullbox.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "tab/edit_footerjs.html"
}

//Save 添加、编辑页面 保存
func (this *TabController) Save() {
	var err error
	m := models.Tab{}
	//获取form里的值
	if err = this.ParseForm(&m); err != nil {
		this.JsonResult(enums.JRCodeFailed, "获取数据失败", m.TabId)
	}

	tabType, err := this.GetInt8("TabType", 1)

	if err != nil {
		this.JsonResult(enums.JRCodeFailed, "获取数据失败", m.TabId)
	}

	var nTabType models.TabType
	nTabType.TabTypeId = tabType

	m.TabType = &nTabType

	o := orm.NewOrm()
	if m.TabId == 0 {
		if _, err = o.Insert(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "添加成功", m.TabId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "添加失败", m.TabId)
		}

	} else {
		if _, err = o.Update(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "编辑成功", m.TabId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "编辑失败", m.TabId)
		}
	}

}

//Delete 批量删除
func (this *TabController) Delete() {
	strs := this.GetString("ids")
	ids := make([]int, 0, len(strs))
	for _, str := range strings.Split(strs, ",") {
		if id, err := strconv.Atoi(str); err == nil {
			ids = append(ids, id)
		}
	}
	if num, err := models.DeleteBatchTab(ids); err == nil {
		// 删除德华需要删除所有与这个游戏标签关联的游戏

		this.JsonResult(enums.JRCodeSucc, fmt.Sprintf("成功删除 %d 项", num), 0)
	} else {
		this.JsonResult(enums.JRCodeFailed, "删除失败", 0)
	}
}

func (this *TabController) UpdateSeq() {
	Id, _ := this.GetInt("pk", 0)
	oM, err := models.GetOneTabDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}
	value, _ := this.GetInt8("value", 0)
	oM.TabWeight = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.TabId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.TabId)
	}
}

func (this *TabController) UpdateStatus() {
	Id, _ := this.GetInt("pk", 0)
	oM, err := models.GetOneTabDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}

	value, _ := this.GetInt8("status", 0)
	oM.TabStatus = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.TabId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.TabId)
	}
}

func (this *TabController) UpdateTabType() {
	Id, _ := this.GetInt("pk", 0)
	oM, err := models.GetOneTabDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}

	value, _ := this.GetInt8("tabtype", 0)

	var tabType models.TabType
	tabType.TabTypeId = value

	oM.TabType = &tabType
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.TabId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.TabId)
	}
}
