package controllers

import (
	"fmt"
	"mxh5/enums"
	"mxh5/models"
	"strconv"

	"github.com/astaxie/beego/orm"
)

type GameController struct {
	BaseController
}

func (this *GameController) Prepare() {
	this.BaseController.Prepare()

	this.CheckAuthor("GetGameListByPage", "GetTabs")
}

func (this *GameController) GetGameStatus() map[int]string {
	mapGameStatus := make(map[int]string)
	mapGameStatus[1] = "开启"
	mapGameStatus[2] = "禁用"
	mapGameStatus[3] = "隐藏"

	return mapGameStatus
}

func (this *GameController) Index() {

	this.Data["showMoreQuery"] = true
	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())

	this.TplName = "game/index.html"
	this.Layout = "shared/layout_page.html"

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "game/index_footerjs.html"
	this.LayoutSections["headcssjs"] = "game/index_headcssjs.html"
}

// 获取游戏列表
func (this *GameController) GetGameListByPage() {
	currentpage, _ := this.GetInt64("page", 1)
	gameName := this.GetString("gameName", "")
	gameType, _ := this.GetInt32("gameType", 0)
	isDel, _ := this.GetBool("isDel", false)

	pageSize := int64(6)

	var params models.GameQueryParam
	params.GameType = gameType
	params.NameLike = gameName
	params.Offset = int64((currentpage - 1) * pageSize)
	params.Limit = int(pageSize)
	params.BackUserId = 0

	//获取数据列表和总数
	data, total := models.GamePageList(&params)

	if currentpage < 1 {
		currentpage = 1
	}

	if isDel {
		if currentpage*pageSize >= pageSize+total {
			currentpage = currentpage
		}
	} else {
		if currentpage*pageSize >= pageSize+total {
			currentpage = 1
		}
	}

	st, end := pageSize*(currentpage-1), pageSize*currentpage
	if st > total || st < 0 {
		st = 0
	}
	if end > total || end < 0 {
		end = total
	}

	// 获取所有的游戏分类
	dataGameTypes := models.GameTypePageList()

	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	result["eachpage"] = params.Limit
	result["currentpage"] = currentpage
	result["dataGameTypes"] = dataGameTypes

	tp := total / int64(params.Limit)
	if total%int64(params.Limit) > 0 {
		tp = tp + 1
	}

	result["totalpage"] = tp
	result["page"] = currentpage

	this.JsonResult(enums.JRCodeSucc, "获取成功", result)
}

// save
func (this *GameController) save() {
	game := models.Game{}

	if err := this.ParseForm(&game); err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), game.GameId)
	}

	var str []string
	str = this.GetStrings("GameTabs", str)

	o := orm.NewOrm()
	// 把游戏对应的tabs选项更新到gameTab表里面
	//
	backend_id := this.GetCurrentId()

	backendUser := new(models.BackendUser)
	backendUser.Id = backend_id

	game.BackendUser = backendUser

	var ret bool
	ret = false
	var gameId int64
	gameId = game.GameId

	if game.GameId != 0 {
		if _, err := o.Update(&game); err != nil {
			this.JsonResult(enums.JRCodeFailed, err.Error(), game.GameId)
		} else {
			ret = true
		}
	} else {
		if _, err := o.Insert(&game); err != nil {
			this.JsonResult(enums.JRCodeFailed, "插入失败", game.GameId)
		} else {
			ret = true
		}
	}

	if ret {
		//删除老的标签
		_, err := o.QueryTable(models.GameTabTBName()).Filter("Game__GameId", game.GameId).Delete()
		if err != nil {
			this.JsonResult(enums.JRCodeFailed, "更新失败", game.GameId)
		}
		//插入新的标签
		var gameTabls []models.GameTab
		for i := 0; i < len(str); i++ {
			ii, _ := strconv.Atoi(str[i])

			var gTab models.GameTab

			tab := new(models.Tab)
			tab.TabId = ii
			gTab.Tab = tab

			tGame := new(models.Game)
			tGame.GameId = game.GameId
			gTab.Game = tGame

			gameTabls = append(gameTabls, gTab)
		}
		_, err = o.InsertMulti(len(gameTabls), gameTabls)
		if err != nil {
			this.JsonResult(enums.JRCodeFailed, "更新失败", game.GameId)
		}

		if gameId != 0 {
			this.JsonResult(enums.JRCodeSucc, "更新成功", game.GameId)
		} else {
			this.JsonResult(enums.JRCodeSucc, "插入成功", game.GameId)
		}
	}
}

// edit game
func (this *GameController) EditGame() {
	if this.Ctx.Request.Method == "POST" {
		this.save()
	}

	id, _ := this.GetInt64(":id", 0)

	var game *models.Game
	game = &models.Game{GameId: id}

	var err error
	if id > 0 {
		err, game = models.FindOneGame(id)
		if err != nil {
			this.JsonResult(enums.JRCodeFailed, err.Error(), id)
		}
	}

	// 获取游戏
	var gameTabs []*models.GameTab
	if id > 0 {
		gameTabs = models.GetGameTabList(id)
	}

	// 用于显示默认select选中
	var tempGameTabs string
	for i := 0; i < len(gameTabs); i++ {
		tempGameTabs += strconv.Itoa(gameTabs[i].Tab.TabId)

		if i+1 != len(gameTabs) {
			tempGameTabs += ","
		}
	}

	// 获取所有的
	var params models.TabQueryParam
	params.Sort = "desc"

	data := models.TabDataList(&params)

	// 查找图片

	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), 0)
	}
	// 获取所有的游戏分类
	dataGameTypes := models.GameTypePageList()

	this.Data["mapGameStatus"] = this.GetGameStatus()
	this.Data["gameTypes"] = dataGameTypes

	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())
	this.Data["game"] = *game
	this.Data["hasImage"] = len(game.GameIcovStr) > 0
	this.Data["tabs"] = data
	this.Data["gameTabs"] = tempGameTabs

	fmt.Printf("----------------------------------------%s", tempGameTabs)

	var image map[string]string

	image = make(map[string]string)
	image["ImageName"] = "test"
	image["ImagePath"] = game.GameIcovStr
	this.Data["image"] = image

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "game/edit_footerjs.html"
	this.LayoutSections["headcssjs"] = "game/edit_headcssjs.html"

	this.TplName = "game/edit.html"
	this.Layout = "shared/layout_pullbox.html"
}

// del game
func (this *GameController) DelGame() {

	id, _ := this.GetInt64(":id", 0)

	if id == 0 {
		this.JsonResult(enums.JRCodeFailed, "错误的游戏id", 0)
	}

	_, err := models.DelGame(id)
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), 0)
	}

	//pageSize := int64(6)

	fmt.Printf("删除成功了啊")
	this.JsonResult(enums.JRCodeSucc, "删除成功", 0)
}

// add game
func (this *GameController) AddGame() {
	//this.EditGame()
	if this.Ctx.Request.Method == "POST" {
		this.save()
	}
	// 获取所有的游戏分类
	data := models.GameTypePageList()

	// 获取所有的
	var params models.TabQueryParam
	params.Sort = "desc"
	dataTabs := models.TabDataList(&params)

	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())
	this.Data["mapGameStatus"] = this.GetGameStatus()
	this.Data["gameTypes"] = data
	this.Data["tabs"] = dataTabs

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "game/add_footerjs.html"
	this.LayoutSections["headcssjs"] = "game/add_headcssjs.html"

	this.TplName = "game/add.html"
	this.Layout = "shared/layout_page.html"
}

// 按照名字模糊匹配
func (this *GameController) SeachGame() {
	var params = models.GameQueryParam{}
	//获取数据列表和总数
	data := models.GameDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}

func (this *GameController) GameManger() {

	id, _ := this.GetInt64(":id", 0)

	this.Data["gameId"] = id
	this.TplName = "game/manager.html"
	this.Layout = "shared/layout_pullbox_tab.html"
}

type Tabs struct {
	TabId   int32
	TabName string
	TabUrl  string
}

func (this *GameController) GetTabs() {
	result := make(map[string]interface{})

	tabs := make([]*Tabs, 0)

	tab := &Tabs{}
	tab.TabId = 1
	tab.TabName = "你好按钮1"
	tab.TabUrl = this.URLFor("GameNoticeController.Index")
	tabs = append(tabs, tab)

	tab = &Tabs{}
	tab.TabId = 2
	tab.TabName = "你好按钮2"
	tab.TabUrl = this.URLFor("GameNoticeController.Index")

	fmt.Printf(this.URLFor("GameNoticeController.Index"))
	tabs = append(tabs, tab)

	result["tabs"] = tabs

	this.JsonResult(enums.JRCodeSucc, "", result)
}
