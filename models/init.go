package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

// init 初始化
func init() {
	orm.RegisterModel(new(BackendUser), new(Resource), new(Role), new(RoleResourceRel), new(RoleBackendUserRel), new(AlipayUser), new(LogUserLogin), new(Image), new(Game), new(GameTab), new(Tab))
	orm.RegisterModel(new(GameType), new(Nav), new(Notice), new(TabType))
}

// TableName 下面是统一的表名管理
func TableName(name string) string {
	prefix := beego.AppConfig.String("db_dt_prefix")
	return prefix + name
}

// BackendUserTBName 获取 BackendUser 对应的表名称
func BackendUserTBName() string {
	return TableName("backend_user")
}

// ResourceTBName 获取 Resource 对应的表名称
func ResourceTBName() string {
	return TableName("resource")
}

// RoleTBName 获取 Role 对应的表名称
func RoleTBName() string {
	return TableName("role")
}

// RoleResourceRelTBName 角色与资源多对多关系表
func RoleResourceRelTBName() string {
	return TableName("role_resource_rel")
}

// RoleBackendUserRelTBName 角色与用户多对多关系表
func RoleBackendUserRelTBName() string {
	return TableName("role_backenduser_rel")
}

// AlipayUserTBName 获取AlipayUSer对应的表明
func AlipayUserTBName() string {
	return TableName("alipay_user")
}

// LogTBName 用户登录的表明
func LogUserTBName() string {
	return TableName("log_user_login")
}

// ImageTBName 图片表
func ImageTBName() string {
	return TableName("image")
}

// 游戏了列表
func GameTBName() string {
	return TableName("game")
}

func TabTBName() string {
	return TableName("tab")
}

func NavTBName() string {
	return TableName("nav")
}

func GameTabTBName() string {
	return TableName("game_tab_rel")
}

func GameTypeTBName() string {
	return TableName("game_type")
}

func NoticeTBName() string {
	return TableName("notice")
}

func TabTypeTBName() string {
	return TableName("tab_type")
}
