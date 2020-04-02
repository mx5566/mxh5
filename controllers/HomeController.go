package controllers

import (
	"strings"

	"mxh5/enums"
	"mxh5/models"
	"mxh5/utils"
	"time"
)

type HomeController struct {
	BaseController
}

func (c *HomeController) Index() {
	//判断是否登录
	c.checkLogin()
	c.SetTpl()
}
func (c *HomeController) Page404() {
	c.SetTpl()
}
func (c *HomeController) Error() {
	c.Data["error"] = c.GetString(":error")
	c.SetTpl("home/error.html", "shared/layout_pullbox.html")
}
func (c *HomeController) Login() {

	c.LayoutSections = make(map[string]string)
	c.LayoutSections["headcssjs"] = "home/login_headcssjs.html"
	c.LayoutSections["footerjs"] = "home/login_footerjs.html"
	c.SetTpl("home/login.html", "shared/layout_base.html")
}
func (c *HomeController) DoLogin() {
	username := strings.TrimSpace(c.GetString("UserName"))
	userpwd := strings.TrimSpace(c.GetString("UserPwd"))
	if len(username) == 0 || len(userpwd) == 0 {
		c.JsonResult(enums.JRCodeFailed, "用户名和密码不正确", "")
	}
	userpwd = utils.String2md5(userpwd)
	user, err := models.BackendUserOneByUserName(username, userpwd)
	if user != nil && err == nil {
		if user.Status == enums.Disabled {
			c.JsonResult(enums.JRCodeFailed, "用户被禁用，请联系管理员", "")
		}
		//保存用户信息到session
		c.setBackendUser2Session(user.Id)
		remoteAddr := c.Ctx.Request.RemoteAddr
		addrs := strings.Split(remoteAddr, "::1")
		if len(addrs) > 1 {
			remoteAddr = "localhost"
		}
		models.LoginTraceAdd(username, remoteAddr, time.Now())

		//获取用户信息
		c.JsonResult(enums.JRCodeSucc, "登录成功", "")
	} else {
		c.JsonResult(enums.JRCodeFailed, "用户名或者密码错误", "")
	}
}
func (c *HomeController) Logout() {
	user := models.BackendUser{}
	c.SetSession("backenduser", user)
	c.PageLogin()
}
