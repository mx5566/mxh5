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
type TabTypeController struct {
	BaseController
}

func (this *TabTypeController) GetTabStatus() map[enums.StatusType]string {
	mapGameStatus := make(map[enums.StatusType]string)
	mapGameStatus[enums.StatusOpen] = "开启"
	mapGameStatus[enums.StatusForbind] = "禁用"
	mapGameStatus[enums.StatusHide] = "隐藏"

	return mapGameStatus
}

func (this *TabTypeController) GetTabTypes() map[enums.TabType]string {
	mapTabTypes := make(map[enums.TabType]string)
	mapTabTypes[enums.TabTypeMain] = "游戏主页"
	mapTabTypes[enums.TabTypeGame] = "游戏详情"

	return mapTabTypes
}

func (this *TabTypeController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	this.CheckAuthor("DataGrid", "DataList", "UpdateSeq", "UpdateStatus")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//这里注释了权限控制，因此这里需要登录验证
	//this.checkLogin()
}

// Tab列表
func (this *TabTypeController) Index() {

	//将页面左边菜单的某项激活
	this.Data["activeSidebarUrl"] = this.URLFor(this.controllerName + "." + this.actionName)
	this.SetTpl()
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["headcssjs"] = "tabtype/index_headcssjs.html"
	this.LayoutSections["footerjs"] = "tabtype/index_footerjs.html"
	//页面里按钮权限控制
	this.Data["canEdit"] = this.CheckActionAuthor("TabController", "Edit")
	this.Data["canDelete"] = this.CheckActionAuthor("TabController", "Delete")
}

// DataGrid tab管理首页 表格获取数据
func (this *TabTypeController) DataGrid() {
	//直接反序化获取json格式的requestbody里的值
	var params models.TabTypeQueryParam
	json.Unmarshal(this.Ctx.Input.RequestBody, &params)
	//获取数据列表和总数
	data, total := models.TabTypePageList(&params)
	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	this.Data["json"] = result
	this.ServeJSON()
}

//DataList tab列表
func (this *TabTypeController) DataList() {
	var params = models.TabTypeQueryParam{}
	//获取数据列表和总数
	data := models.TabTypeDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}

//Edit 添加、编辑tab
func (this *TabTypeController) Edit() {
	if this.Ctx.Request.Method == "POST" {
		this.Save()
	}

	Id, _ := this.GetInt8(":id", 0)
	m := models.TabType{TabTypeId: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}
	}
	this.Data["m"] = m
	this.Data["mapGameTabs"] = this.GetTabStatus()
	this.Data["mapGameTabType"] = this.GetTabTypes()

	tt, _ := this.GetInt(":type", 1)

	this.Data["editType"] = tt
	this.SetTpl("tabtype/edit.html", "shared/layout_pullbox.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "tabtype/edit_footerjs.html"
}

//Save 添加、编辑页面 保存
func (this *TabTypeController) Save() {
	var err error
	m := models.TabType{}
	//获取form里的值
	if err = this.ParseForm(&m); err != nil {
		this.JsonResult(enums.JRCodeFailed, "获取数据失败", m.TabTypeId)
	}

	o := orm.NewOrm()

	// 根据类型判断对应的数据库处理
	tt, _ := this.GetInt("EditType", 1)
	if tt == 1 {
		if _, err = o.Insert(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "添加成功", m.TabTypeId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "添加失败", m.TabTypeId)
		}
	} else if tt == 2 {
		if _, err = o.Update(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "编辑成功", m.TabTypeId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "编辑失败", m.TabTypeId)
		}
	}
}

//Delete 批量删除
func (this *TabTypeController) Delete() {
	strs := this.GetString("ids")
	ids := make([]int, 0, len(strs))
	for _, str := range strings.Split(strs, ",") {
		if id, err := strconv.Atoi(str); err == nil {
			ids = append(ids, id)
		}
	}
	if num, err := models.DeleteBatchTabType(ids); err == nil {
		// 删除德华需要删除所有与这个游戏标签关联的游戏

		this.JsonResult(enums.JRCodeSucc, fmt.Sprintf("成功删除 %d 项", num), 0)
	} else {
		this.JsonResult(enums.JRCodeFailed, "删除失败", 0)
	}
}

func (this *TabTypeController) UpdateSeq() {
	Id, _ := this.GetInt8("pk", 0)
	oM, err := models.GetOneTabTypeDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}
	value, _ := this.GetInt8("value", 0)
	oM.TabTypeWeight = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.TabTypeId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.TabTypeId)
	}
}

func (this *TabTypeController) UpdateStatus() {
	Id, _ := this.GetInt8("pk", 0)
	oM, err := models.GetOneTabTypeDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}

	value, _ := this.GetInt8("status", 0)
	oM.TabTypeStatus = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.TabTypeId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.TabTypeId)
	}
}
