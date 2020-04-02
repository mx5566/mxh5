package routers

import (
	"mxh5/controllers"
	"mxh5/controllers/alipay"
	"mxh5/controllers/h5/user"

	"github.com/astaxie/beego"
)

func init() {
	//用户角色路由
	beego.Router("/role/index", &controllers.RoleController{}, "*:Index")
	beego.Router("/role/datagrid", &controllers.RoleController{}, "Get,Post:DataGrid")
	beego.Router("/role/edit/?:id", &controllers.RoleController{}, "Get,Post:Edit")
	beego.Router("/role/delete", &controllers.RoleController{}, "Post:Delete")
	beego.Router("/role/datalist", &controllers.RoleController{}, "Post:DataList")
	beego.Router("/role/allocate", &controllers.RoleController{}, "Post:Allocate")
	beego.Router("/role/updateseq", &controllers.RoleController{}, "Post:UpdateSeq")

	//资源路由
	beego.Router("/resource/index", &controllers.ResourceController{}, "*:Index")
	beego.Router("/resource/treegrid", &controllers.ResourceController{}, "POST:TreeGrid")
	beego.Router("/resource/edit/?:id", &controllers.ResourceController{}, "Get,Post:Edit")
	beego.Router("/resource/parent", &controllers.ResourceController{}, "Post:ParentTreeGrid")
	beego.Router("/resource/delete", &controllers.ResourceController{}, "Post:Delete")
	//快速修改顺序
	beego.Router("/resource/updateseq", &controllers.ResourceController{}, "Post:UpdateSeq")

	//通用选择面板
	beego.Router("/resource/select", &controllers.ResourceController{}, "Get:Select")
	//用户有权管理的菜单列表（包括区域）
	beego.Router("/resource/usermenutree", &controllers.ResourceController{}, "POST:UserMenuTree")
	beego.Router("/resource/checkurlfor", &controllers.ResourceController{}, "POST:CheckUrlFor")

	//后台用户路由
	beego.Router("/backenduser/index", &controllers.BackendUserController{}, "*:Index")
	beego.Router("/backenduser/datagrid", &controllers.BackendUserController{}, "POST:DataGrid")
	beego.Router("/backenduser/edit/?:id", &controllers.BackendUserController{}, "Get,Post:Edit")
	beego.Router("/backenduser/delete", &controllers.BackendUserController{}, "Post:Delete")
	//后台用户中心
	beego.Router("/usercenter/profile", &controllers.UserCenterController{}, "Get:Profile")
	beego.Router("/usercenter/basicinfosave", &controllers.UserCenterController{}, "Post:BasicInfoSave")
	beego.Router("/usercenter/uploadimage", &controllers.UserCenterController{}, "Post:UploadImage")
	beego.Router("/usercenter/passwordsave", &controllers.UserCenterController{}, "Post:PasswordSave")

	beego.Router("/home/index", &controllers.HomeController{}, "*:Index")
	beego.Router("/home/login", &controllers.HomeController{}, "*:Login")
	beego.Router("/home/dologin", &controllers.HomeController{}, "Post:DoLogin")
	beego.Router("/home/logout", &controllers.HomeController{}, "*:Logout")

	beego.Router("/home/404", &controllers.HomeController{}, "*:Page404")
	beego.Router("/home/error/?:error", &controllers.HomeController{}, "*:Error")

	//
	beego.Router("/alipay/native", &alipay.AlipayNewController{}, "*:Native")
	beego.Router("/alipay/index", &alipay.AlipayNewController{}, "*:Index")
	beego.Router("/alipay/list", &alipay.AlipayNewController{}, "*:AlipayList")
	beego.Router("/alipay/datagrid", &alipay.AlipayNewController{}, "Get,Post:DataGrid")
	beego.Router("/alipay/edit/?:id", &alipay.AlipayNewController{}, "Get,Post:Edit")
	beego.Router("/alipay/delete", &alipay.AlipayNewController{}, "Post:Delete")
	beego.Router("/alipay/datalist", &alipay.AlipayNewController{}, "Post:DataList")
	beego.Router("/alipay/updateappid", &alipay.AlipayNewController{}, "Post:UpdateAppId")

	// 日志管理模块
	beego.Router("/log/index", &controllers.LogController{}, "*:Index")
	beego.Router("/log/datalist", &controllers.LogController{}, "Post:DataList")
	beego.Router("/log/datagrid", &controllers.LogController{}, "Get,Post:DataGrid")

	// 图片上传
	beego.Router("/image/index", &controllers.ImageController{}, "*:Index")
	beego.Router("/image/uploadimage", &controllers.ImageController{}, "Post:UploadImage")
	beego.Router("/image/uploadsingleimage", &controllers.ImageController{}, "Post:UploadSingleImage")
	beego.Router("/image/uploadckimage", &controllers.ImageController{}, "Post:UploadCkEditorImage")
	beego.Router("/image/removeimages", &controllers.ImageController{}, "Get,Post:RemoveImages")
	beego.Router("/image/imagelist/?:page", &controllers.ImageController{}, "Get,Post:ImageList")
	beego.Router("/image/editimage/?:id", &controllers.ImageController{}, "Get,Post:EditImage")
	beego.Router("/image/basicinfosave", &controllers.ImageController{}, "Get,Post:BasicInfoSave")

	beego.Router("/", &controllers.HomeController{}, "*:Index")

	// 用户模块开始了啊
	beego.Router("/07073/wap", &user.UserController{}, "*:Index")
	beego.Router("/h5/wap", &user.UserController{}, "*:MyIndex")

	// 平台后台的数据模板 游戏编辑
	beego.Router("/game/index", &controllers.GameController{}, "*:Index")
	beego.Router("/game/getgamebypage/?:page", &controllers.GameController{}, "*:GetGameListByPage")
	beego.Router("/game/edit/?:id", &controllers.GameController{}, "*:EditGame")
	beego.Router("/game/del/?:id", &controllers.GameController{}, "*:DelGame")
	beego.Router("/game/add", &controllers.GameController{}, "*:AddGame")
	beego.Router("/game/seach", &controllers.GameController{}, "*:SeachGame")
	beego.Router("/game/tabs", &controllers.GameController{}, "*:GetTabs")
	beego.Router("/game/manager/?:id", &controllers.GameController{}, "*:GameManger")

	//标签管理路由
	beego.Router("/tab/index", &controllers.TabController{}, "*:Index")
	beego.Router("/tab/datagrid", &controllers.TabController{}, "Get,Post:DataGrid")
	beego.Router("/tab/edit/?:id", &controllers.TabController{}, "Get,Post:Edit")
	beego.Router("/tab/delete", &controllers.TabController{}, "Post:Delete")
	beego.Router("/tab/datalist", &controllers.TabController{}, "Post:DataList")
	beego.Router("/tab/updateseq", &controllers.TabController{}, "Post:UpdateSeq")
	beego.Router("/tab/updatestatus", &controllers.TabController{}, "Post:UpdateStatus")
	beego.Router("/tab/updatetabtype", &controllers.TabController{}, "Post:UpdateTabType")

	//标签管理路由
	beego.Router("/tabtype/index", &controllers.TabTypeController{}, "*:Index")
	beego.Router("/tabtype/datagrid", &controllers.TabTypeController{}, "Get,Post:DataGrid")
	beego.Router("/tabtype/edit/?:id/?:type", &controllers.TabTypeController{}, "Get,Post:Edit")
	beego.Router("/tabtype/delete", &controllers.TabTypeController{}, "Post:Delete")
	beego.Router("/tabtype/datalist", &controllers.TabTypeController{}, "Post:DataList")
	beego.Router("/tabtype/updateseq", &controllers.TabTypeController{}, "Post:UpdateSeq")
	beego.Router("/tabtype/updatestatus", &controllers.TabTypeController{}, "Post:UpdateStatus")

	//游戏类型管理路由
	beego.Router("/gametype/index", &controllers.GameTypeController{}, "*:Index")
	beego.Router("/gametype/datagrid", &controllers.GameTypeController{}, "Get,Post:DataGrid")
	beego.Router("/gametype/edit/?:id", &controllers.GameTypeController{}, "Get,Post:Edit")
	beego.Router("/gametype/delete", &controllers.GameTypeController{}, "Post:Delete")
	beego.Router("/gametype/datalist", &controllers.GameTypeController{}, "Post:DataList")
	beego.Router("/gametype/updateseq", &controllers.GameTypeController{}, "Post:UpdateSeq")
	beego.Router("/gametype/updatestatus", &controllers.GameTypeController{}, "Post:UpdateStatus")

	//导航管理路由
	beego.Router("/nav/index", &controllers.NavController{}, "*:Index")
	beego.Router("/nav/datagrid", &controllers.NavController{}, "Get,Post:DataGrid")
	beego.Router("/nav/edit/?:id", &controllers.NavController{}, "Get,Post:Edit")
	beego.Router("/nav/delete", &controllers.NavController{}, "Post:Delete")
	beego.Router("/nav/datalist", &controllers.NavController{}, "Post:DataList")
	beego.Router("/nav/updateseq", &controllers.NavController{}, "Post:UpdateSeq")
	beego.Router("/nav/updatestatus", &controllers.NavController{}, "Post:UpdateStatus")

	//导航管理路由
	beego.Router("/notice/index/?:id/?:gameid", &controllers.GameNoticeController{}, "*:Index")
	beego.Router("/notice/datagrid", &controllers.GameNoticeController{}, "Get,Post:DataGrid")
	beego.Router("/notice/edit/?:id/?:gameId", &controllers.GameNoticeController{}, "Get,Post:Edit")
	beego.Router("/notice/delete", &controllers.GameNoticeController{}, "Post:Delete")
	beego.Router("/notice/datalist", &controllers.GameNoticeController{}, "Post:DataList")
	beego.Router("/notice/updateseq", &controllers.GameNoticeController{}, "Post:UpdateSeq")
	beego.Router("/notice/updatestatus", &controllers.GameNoticeController{}, "Post:UpdateStatus")

}
