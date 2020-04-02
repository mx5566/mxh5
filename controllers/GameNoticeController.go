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

type GameNoticeController struct {
	BaseController
}

func (this *GameNoticeController) GetNoticeStatus() map[int]string {
	mapNoticeStatus := make(map[int]string)
	mapNoticeStatus[1] = "开启"
	mapNoticeStatus[2] = "禁用"
	mapNoticeStatus[3] = "隐藏"

	return mapNoticeStatus
}

func (this *GameNoticeController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	this.CheckAuthor("DataGrid", "DataList", "UpdateSeq", "UpdateStatus")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//这里注释了权限控制，因此这里需要登录验证
	//this.checkLogin()
}

func (this *GameNoticeController) Index() {
	//需要权限控制
	this.CheckAuthor()

	id, _ := this.GetInt(":id", 2)
	gameId, _ := this.GetInt64(":gameid", 0)

	fmt.Printf("GameNoticeController::Index %d  %d\n", id, gameId)
	//将页面左边菜单的某项激活
	//this.Data["activeSidebarUrl"] = this.URLFor(this.controllerName + "." + this.actionName)
	this.TplName = "notice/index.html"
	this.Layout = "shared/layout_pullbox_tab.html"
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["headcssjs"] = "notice/index_headcssjs.html"
	this.LayoutSections["footerjs"] = "notice/index_footerjs.html"

	this.Data["tabId"] = id
	this.Data["gameId"] = gameId
	//页面里按钮权限控制
	this.Data["canEdit"] = this.CheckActionAuthor("GameNoticeController", "Edit")
	this.Data["canDelete"] = this.CheckActionAuthor("GameNoticeController", "Delete")
}

func (this *GameNoticeController) DataGrid() {
	//直接反序化获取json格式的requestbody里的值
	var params models.NoticeQueryParam
	json.Unmarshal(this.Ctx.Input.RequestBody, &params)
	//获取数据列表和总数
	data, total := models.NoticePageList(&params)
	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	this.Data["json"] = result
	this.ServeJSON()
}

func (this *GameNoticeController) DataList() {
	var params = models.NoticeQueryParam{}
	//获取数据列表和总数
	data := models.NoticeDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}

func (this *GameNoticeController) Edit() {
	if this.Ctx.Request.Method == "POST" {
		this.Save()
	}
	Id, _ := this.GetInt64(":id", 0)
	m := models.Notice{NoticeId: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}
	}

	gameId, _ := this.GetInt64(":gameId", 0)
	if gameId == 0 {
		this.PageError("错误的游戏")
	}

	this.Data["m"] = m
	this.Data["gameId"] = gameId
	this.Data["mapNoticeTabs"] = this.GetNoticeStatus()
	this.SetTpl("notice/edit.html", "shared/layout_pullbox.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "notice/edit_footerjs.html"
}

func (this *GameNoticeController) Save() {
	var err error
	m := models.Notice{}
	//获取form里的值
	if err = this.ParseForm(&m); err != nil {
		this.JsonResult(enums.JRCodeFailed, "获取数据失败", m.NoticeId)
	}

	game := new(models.Game)

	m.Game = game

	game.GameId, _ = this.GetInt64("GameId", 0)
	if game.GameId == 0 {
		this.JsonResult(enums.JRCodeFailed, "没指定游戏", m.NoticeId)
	}

	err, _ = models.FindOneGame(game.GameId)
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, "没有不存在", m.NoticeId)
	}

	o := orm.NewOrm()
	if m.NoticeId == 0 {
		if _, err = o.Insert(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "添加成功", m.NoticeId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "添加失败", m.NoticeId)
		}

	} else {
		if _, err = o.Update(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "编辑成功", m.NoticeId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "编辑失败", m.NoticeId)
		}
	}
}

func (this *GameNoticeController) Delete() {
	strs := this.GetString("ids")
	ids := make([]int64, 0, len(strs))
	for _, str := range strings.Split(strs, ",") {
		if id, err := strconv.ParseInt(str, 10, 64); err == nil {
			ids = append(ids, id)
		}
	}
	if num, err := models.DeleteBatchNotice(ids); err == nil {
		// 删除德华需要删除所有与这个游戏标签关联的游戏

		this.JsonResult(enums.JRCodeSucc, fmt.Sprintf("成功删除 %d 项", num), 0)
	} else {
		this.JsonResult(enums.JRCodeFailed, "删除失败", 0)
	}
}

func (this *GameNoticeController) UpdateStatus() {
	Id, _ := this.GetInt64("pk", 0)
	oM, err := models.GetOneNoticeDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}

	value, _ := this.GetInt8("status", 0)
	oM.NoticeStatus = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.NoticeId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.NoticeId)
	}
}

func (this *GameNoticeController) UpdateSeq() {
	Id, _ := this.GetInt64("pk", 0)
	oM, err := models.GetOneNoticeDetail(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}
	value, _ := this.GetInt8("value", 0)
	oM.NoticeWeight = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.NoticeId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.NoticeId)
	}
}

func (this *GameNoticeController) NoticeMgr() {

}
