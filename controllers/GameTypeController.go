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

type GameTypeController struct {
	BaseController
}

func (this *GameTypeController) GetTabStatus() map[int]string {
	mapGameStatus := make(map[int]string)
	mapGameStatus[1] = "开启"
	mapGameStatus[2] = "禁用"
	mapGameStatus[3] = "隐藏"

	return mapGameStatus
}

func (this *GameTypeController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	this.CheckAuthor("DataGrid", "DataList", "UpdateSeq", "UpdateStatus")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//这里注释了权限控制，因此这里需要登录验证
	//this.checkLogin()
}

func (this *GameTypeController) Index() {
	//需要权限控制
	this.CheckAuthor()

	//将页面左边菜单的某项激活
	this.Data["activeSidebarUrl"] = this.URLFor(this.controllerName + "." + this.actionName)
	this.SetTpl()
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["headcssjs"] = "gametype/index_headcssjs.html"
	this.LayoutSections["footerjs"] = "gametype/index_footerjs.html"
	//页面里按钮权限控制
	this.Data["canEdit"] = this.CheckActionAuthor("GameTypeController", "Edit")
	this.Data["canDelete"] = this.CheckActionAuthor("GameTypeController", "Delete")
}

func (this *GameTypeController) DataGrid() {
	//直接反序化获取json格式的requestbody里的值
	var params models.GameTypeQueryParam
	json.Unmarshal(this.Ctx.Input.RequestBody, &params)
	//获取数据列表和总数
	data, total := models.GameTypePageListByParams(&params)
	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	this.Data["json"] = result
	this.ServeJSON()
}

func (this *GameTypeController) DataList() {
	var params = models.GameTypeQueryParam{}
	//获取数据列表和总数
	data := models.GameTypeDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}

func (this *GameTypeController) Edit() {
	if this.Ctx.Request.Method == "POST" {
		this.Save()
	}
	Id, _ := this.GetInt32(":id", 0)
	m := models.GameType{GameTypeId: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}
	}
	this.Data["m"] = m
	this.Data["mapGameTabs"] = this.GetTabStatus()
	this.SetTpl("gametype/edit.html", "shared/layout_pullbox.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "gametype/edit_footerjs.html"
}

func (this *GameTypeController) Save() {
	var err error
	m := models.GameType{}
	//获取form里的值
	if err = this.ParseForm(&m); err != nil {
		this.JsonResult(enums.JRCodeFailed, "获取数据失败", m.GameTypeId)
	}
	o := orm.NewOrm()
	if m.GameTypeId == 0 {
		if _, err = o.Insert(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "添加成功", m.GameTypeId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "添加失败", m.GameTypeId)
		}

	} else {
		if _, err = o.Update(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "编辑成功", m.GameTypeId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "编辑失败", m.GameTypeId)
		}
	}

}

func (this *GameTypeController) Delete() {
	strs := this.GetString("ids")
	ids := make([]int, 0, len(strs))
	for _, str := range strings.Split(strs, ",") {
		if id, err := strconv.Atoi(str); err == nil {
			ids = append(ids, id)
		}
	}
	if num, err := models.DeleteBatchGameType(ids); err == nil {
		// 删除德华需要删除所有与这个游戏标签关联的游戏

		this.JsonResult(enums.JRCodeSucc, fmt.Sprintf("成功删除 %d 项", num), 0)
	} else {
		this.JsonResult(enums.JRCodeFailed, "删除失败", 0)
	}
}

func (this *GameTypeController) UpdateStatus() {
	Id, _ := this.GetInt32("pk", 0)
	oM, err := models.GetOneGameTypeDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}

	value, _ := this.GetInt8("status", 0)
	oM.GameTypeStatus = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.GameTypeId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.GameTypeId)
	}
}

func (this *GameTypeController) UpdateSeq() {
	Id, _ := this.GetInt32("pk", 0)
	oM, err := models.GetOneGameTypeDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}
	value, _ := this.GetInt8("value", 0)
	oM.GameTypeWeight = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.GameTypeId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.GameTypeId)
	}
}
