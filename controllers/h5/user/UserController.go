package user

import "github.com/astaxie/beego"

type UserController struct {
	beego.Controller
}

func (this *UserController) Index() {

	this.TplName = "07073/h5.07073.com/wap.html"
}

func (this *UserController) MyIndex() {

	this.Layout = "usershared/layout_page.html"

	this.Data["bg"] = "bg"

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "h5/wap_footerjs.html"
	this.LayoutSections["headcssjs"] = "h5/wap_headcssjs.html"

	this.TplName = "h5/wap.html"
}
