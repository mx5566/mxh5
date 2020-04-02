package controllers

import (
	"encoding/json"

	"mxh5/enums"
	"mxh5/models"
)

type LogController struct {
	BaseController
}

func (this *LogController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	//如果一个Controller的多数Action都需要权限控制，则将验证放到Prepare
	this.CheckAuthor("DataGrid", "DataList")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//权限控制里会进行登录验证，因此这里不用再作登录验证
	//c.checkLogin()
}

func (this *LogController) Index() {
	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())
	this.Data["showMoreQuery"] = false

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "log/index_footerjs.html"
	this.LayoutSections["headcssjs"] = "log/index_headcssjs.html"

	this.Layout = "shared/layout_page.html"
	this.TplName = "log/index.html"
}

// DataGrid 日志管理 表格获取数据
func (this *LogController) DataGrid() {
	//直接反序化获取json格式的requestbody里的值
	var params models.LogQueryParam
	json.Unmarshal(this.Ctx.Input.RequestBody, &params)

	//获取数据列表和总数
	data, total := models.LogPageList(&params)
	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	this.Data["json"] = result
	this.ServeJSON()
}

//DataList 日志列表
func (this *LogController) DataList() {
	var params = models.LogQueryParam{}
	//获取数据列表和总数
	data := models.LogDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}
