package alipay

import (
	"encoding/json"
	"fmt"
	"mxh5/controllers"
	"mxh5/enums"
	"mxh5/models"
	"net/url"
	"strconv"
	"strings"

	"github.com/astaxie/beego/orm"
	"github.com/smartwalle/alipay/v3"
)

type AlipayNewController struct {
	controllers.BaseController
}

//Prepare 参考beego官方文档说明
func (this *AlipayNewController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	//如果一个Controller的多数Action都需要权限控制，则将验证放到Prepare
	this.CheckAuthor("DataGrid", "DataList", "UpdateAppId")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//权限控制里会进行登录验证，因此这里不用再作登录验证
	//c.checkLogin()
}

func (this *AlipayNewController) Index() {
	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "alipay/index_footerjs.html"
	this.LayoutSections["headcssjs"] = "alipay/index_headcssjs.html"

	this.Layout = "shared/layout_page.html"
	this.TplName = "alipay/index.html"
}

func (this *AlipayNewController) Native() {
	this.TradeWapPay()
}

// 发送电脑网页支付
func (this *AlipayNewController) TradePcPay() {
	var privateKey = "MIIEowIBAAKCAQEA1uKYG1Wi9+iY/ksxHfFodmHy+76p9fuRE92qE/s++KxF0BdnzN0ndDtf7bpKGB/XlOk++qok0i6WQpdv6kw3X17ei1eU1H+7Y8JXE3J6CUJ5A2AdUsjvUER2M2uvkA4679Hp/IaSwOVCIrJvPgpnSJOn3uo+v/2M/w6Mzqn+XqttJ9wdHQuuJV16lyXowOVbjimtsQ2o12fdIUgdDFPxPdW6A9AQVXBtlkoRWydZeq97niJ7yIco6ZlW6fe1LzO0Z4L0SaM8+iCPdGaFUm3sWCLVMOzkcJ9vQAYl7fR3rNy+hszAd8I95jDiMq+bwiG0IrFKHOLT2RkxgBdaeUyYhwIDAQABAoIBABTuncKL5QQhNEYRLQetrG9buz+qowPDLa6xuQ+ZOdkfbu2GWiYqpN09q2qM6wrOj0GCNxBT4qJWx2xVNCGuqvYvV55bObQ5fReKptDOJfUg9IjPpAucZzN6d8kqhD+UI0mZOSHQOhtwObEHkK6KdOUs/P1J9DLfkAyIbk7zYEP4YT28adEhZrtEoKoTrXNkOop52LN2kNRMzZAjiXe6y0UKC9V9Tsw1fOK1iNruE1Dd53HUnoe7od3H43U81alkNUSFsfVOVFAwTmaTi8DY3+Ljk/f0dumwbiB39kZdGLX68mW2kndua2QMy7yL+GWiATBtsVKMpXYa6L0wgucw4AECgYEA9H8NBU/GPcX0ZqGutNZrOi8USs2i3jgRFsYw5COUPQnfSNYxojFcKLfLt0PPvyEQ63ZhdB3sRsSvpWoOyf0bVGmL+o3orCUdbN6SHLDrXXmlNtUk2g9mxXDHal+yVN06v/u4GZ/dYVfQRA62dlM6p3vf69ZpIm+5FIMNvSHhq4cCgYEA4P7gwUimpcJnUPaTIarkE/MePch/ytQLoegzEVHNDq0DPToVmL8s7UhC3FFzQyJkfEa1d3OpQV2f2/X0B9F1dhkdNj6avc3E9MFhd9ptWxGuGwJCod9Sp9lEPJXSiLPlqxu5N0jH4E6Hw57aJqbyUyFot3LT1oOqle1Eo3La6wECgYEArtZf6El4uNnjALVj6nteaFgcSbWtXv128vM9KRdsPQ3fNwW8roBfp9pu+hmq6MFriQW5gMCZIq4p8L7b3oN51K45ZC2wkdFkrmKm14+Ib+q6Q3C+DpVu54fTgnT2YItnJLyLlP9l3uNd0h03S3wO+I+zu8Eyo2aDUnC5FWOyLecCgYAIGUSP0ISnHMtJP8bmBFe3XB3vjWMEMwPELS6BZhdietnN/2Q9nkwIsnwtoATtGrTRQF5R0Wj7QFp7uWuySFjZCmhhxnkdceWwBbHzdXpQN9+zey5Y00gPYKOzJpVwdEFFGnddRRJkwY7jfLlPgNziHya8y7ZSV2Txhpvc4kp9AQKBgGXkt7NBnqhTVJgjuPn6nzeE5VAfWP/2Uu5djtPMruQCjF5fCkAEg9TsaHxb/WOT1hSws8aQWlvHRYVuhiTTEHdh6sjeQnKTkGmOfFNjIUvG6EbZg1wuKfg8dVg6ohmkpCgXokWDdVsyDzkORUP4XE6q66pbM8VVHjGT+v3iOB3q" // 必须，上一步中使用 RSA签名验签工具 生成的私钥
	var client, err = alipay.New("2016100100635615", privateKey, false)
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
		return
	}

	if client == nil {
		this.JsonResult(enums.JRCodeFailed, "创建alipay失败", "")
		return
	}

	err = client.LoadAppPublicCertFromFile("./conf/appCertPublicKey_2016100100635615.crt") // 加载应用公钥证书
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	err = client.LoadAliPayRootCertFromFile("./conf/alipayRootCert.crt") // 加载支付宝根证书
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	err = client.LoadAliPayPublicCertFromFile("./conf/alipayCertPublicKey_RSA2.crt") // 加载支付宝公钥证书
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	var p = alipay.TradePagePay{}
	p.NotifyURL = "http://xxx"
	p.ReturnURL = "http://xxx"
	p.Subject = "标题"
	p.OutTradeNo = "传递一个唯一单号"
	p.TotalAmount = "10.00"
	p.ProductCode = "FAST_INSTANT_TRADE_PAY"

	var urlTemp *url.URL
	urlTemp, err = client.TradePagePay(p)
	if err != nil {
		fmt.Println(err)
	}

	var payURL = urlTemp.String()
	fmt.Println(payURL)

	res := map[string]interface{}{"url": payURL}
	this.Data["json"] = res
	this.ServeJSON()

	// 这个 payURL 即是用于支付的 URL，可将输出的内容复制，到浏览器中访问该 URL 即可打开支付页面。
}

// 发送电脑网页支付
func (this *AlipayNewController) TradeWapPay() {
	var privateKey = "MIIEowIBAAKCAQEA1uKYG1Wi9+iY/ksxHfFodmHy+76p9fuRE92qE/s++KxF0BdnzN0ndDtf7bpKGB/XlOk++qok0i6WQpdv6kw3X17ei1eU1H+7Y8JXE3J6CUJ5A2AdUsjvUER2M2uvkA4679Hp/IaSwOVCIrJvPgpnSJOn3uo+v/2M/w6Mzqn+XqttJ9wdHQuuJV16lyXowOVbjimtsQ2o12fdIUgdDFPxPdW6A9AQVXBtlkoRWydZeq97niJ7yIco6ZlW6fe1LzO0Z4L0SaM8+iCPdGaFUm3sWCLVMOzkcJ9vQAYl7fR3rNy+hszAd8I95jDiMq+bwiG0IrFKHOLT2RkxgBdaeUyYhwIDAQABAoIBABTuncKL5QQhNEYRLQetrG9buz+qowPDLa6xuQ+ZOdkfbu2GWiYqpN09q2qM6wrOj0GCNxBT4qJWx2xVNCGuqvYvV55bObQ5fReKptDOJfUg9IjPpAucZzN6d8kqhD+UI0mZOSHQOhtwObEHkK6KdOUs/P1J9DLfkAyIbk7zYEP4YT28adEhZrtEoKoTrXNkOop52LN2kNRMzZAjiXe6y0UKC9V9Tsw1fOK1iNruE1Dd53HUnoe7od3H43U81alkNUSFsfVOVFAwTmaTi8DY3+Ljk/f0dumwbiB39kZdGLX68mW2kndua2QMy7yL+GWiATBtsVKMpXYa6L0wgucw4AECgYEA9H8NBU/GPcX0ZqGutNZrOi8USs2i3jgRFsYw5COUPQnfSNYxojFcKLfLt0PPvyEQ63ZhdB3sRsSvpWoOyf0bVGmL+o3orCUdbN6SHLDrXXmlNtUk2g9mxXDHal+yVN06v/u4GZ/dYVfQRA62dlM6p3vf69ZpIm+5FIMNvSHhq4cCgYEA4P7gwUimpcJnUPaTIarkE/MePch/ytQLoegzEVHNDq0DPToVmL8s7UhC3FFzQyJkfEa1d3OpQV2f2/X0B9F1dhkdNj6avc3E9MFhd9ptWxGuGwJCod9Sp9lEPJXSiLPlqxu5N0jH4E6Hw57aJqbyUyFot3LT1oOqle1Eo3La6wECgYEArtZf6El4uNnjALVj6nteaFgcSbWtXv128vM9KRdsPQ3fNwW8roBfp9pu+hmq6MFriQW5gMCZIq4p8L7b3oN51K45ZC2wkdFkrmKm14+Ib+q6Q3C+DpVu54fTgnT2YItnJLyLlP9l3uNd0h03S3wO+I+zu8Eyo2aDUnC5FWOyLecCgYAIGUSP0ISnHMtJP8bmBFe3XB3vjWMEMwPELS6BZhdietnN/2Q9nkwIsnwtoATtGrTRQF5R0Wj7QFp7uWuySFjZCmhhxnkdceWwBbHzdXpQN9+zey5Y00gPYKOzJpVwdEFFGnddRRJkwY7jfLlPgNziHya8y7ZSV2Txhpvc4kp9AQKBgGXkt7NBnqhTVJgjuPn6nzeE5VAfWP/2Uu5djtPMruQCjF5fCkAEg9TsaHxb/WOT1hSws8aQWlvHRYVuhiTTEHdh6sjeQnKTkGmOfFNjIUvG6EbZg1wuKfg8dVg6ohmkpCgXokWDdVsyDzkORUP4XE6q66pbM8VVHjGT+v3iOB3q" // 必须，上一步中使用 RSA签名验签工具 生成的私钥
	var client, err = alipay.New("2016100100635615", privateKey, false)

	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	if client == nil {
		this.JsonResult(enums.JRCodeFailed, "创建alipay失败", "")
	}

	err = client.LoadAppPublicCertFromFile("./conf/appCertPublicKey_2016100100635615.crt") // 加载应用公钥证书
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	err = client.LoadAliPayRootCertFromFile("./conf/alipayRootCert.crt") // 加载支付宝根证书
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	err = client.LoadAliPayPublicCertFromFile("./conf/alipayCertPublicKey_RSA2.crt") // 加载支付宝公钥证书
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	var p = alipay.TradeWapPay{}
	p.NotifyURL = "http://xxx"
	p.ReturnURL = "http://xxx"
	p.Subject = "标题"
	p.OutTradeNo = "传递一个唯一单号"
	p.TotalAmount = "10.00"
	p.ProductCode = "QUICK_WAP_WAY"

	var urlTemp *url.URL
	urlTemp, err = client.TradeWapPay(p)
	if err != nil {
		fmt.Println(err)
	}

	var payURL = urlTemp.String()
	fmt.Println(payURL)

	res := map[string]interface{}{"url": payURL}
	this.Data["json"] = res
	this.ServeJSON()
	// 这个 payURL 即是用于支付的 URL，可将输出的内容复制，到浏览器中访问该 URL 即可打开支付页面。

	/*	var aliPublicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqkkPvfZrn9WlOF0m67cFSelfzjbD6hR4gH+7RyIF5NU8X6W5FfVN5WnRDGdM7hHq50LyhjAu2mtENLtlngPQ5lvsxZMg5HjxfScYEwuX1oQLavPls4S5JtWLii7vRYZKPuAr1vhoVvmLbsvfPSylx2FfznvS6tqfbivGTB2trtg1WC200z3zxkdPLu0vCw+H+OJTMj8+3HOyzpKG5RxAu5V4Wynghd1saFE8TZDUxFmNVApWpOwOhAHAFxq9jTbdqGdWrmz/7jQ10EIH8/mgoN9/cDTeDT1/DA4QjkOKx4lY1GiCQXcJeXpKK1GcoCqV4MZeBWI1o+p6TQ9XoeYchQIDAQAB"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           // 可选，支付宝提供给我们用于签名验证的公钥，通过支付宝管理后台获取
		var privateKey = "MIIEowIBAAKCAQEAqkkPvfZrn9WlOF0m67cFSelfzjbD6hR4gH+7RyIF5NU8X6W5FfVN5WnRDGdM7hHq50LyhjAu2mtENLtlngPQ5lvsxZMg5HjxfScYEwuX1oQLavPls4S5JtWLii7vRYZKPuAr1vhoVvmLbsvfPSylx2FfznvS6tqfbivGTB2trtg1WC200z3zxkdPLu0vCw+H+OJTMj8+3HOyzpKG5RxAu5V4Wynghd1saFE8TZDUxFmNVApWpOwOhAHAFxq9jTbdqGdWrmz/7jQ10EIH8/mgoN9/cDTeDT1/DA4QjkOKx4lY1GiCQXcJeXpKK1GcoCqV4MZeBWI1o+p6TQ9XoeYchQIDAQABAoIBAQCTvhIvcgbMxZO1BHVJXCD1kMrz4uY2SQ6IBsrZG7bbZPsdzW55k7zDB/09cr73a4pQnfBH5rQwA5NI4TJ4V70+sJEMluuZ7ykuueWUWKGjmCtD31rzV3tBK1QHT1OAEdSHGv5OZHY6yAZm2fHVZNBs3Zo/T4WfCJH9B3PkBHf10ux5EXZUQo/FqEAwmJyUt+Eo7Bl8B7Cy9A+LBLYd+VOAFOfkpI1D9yVOZwuU/HZn9V6sFRvJJuYGrQZcKKxbPHTQ1GIuogg6/YbB2H/C23YebgJeuQeKYDti6pdbz29M8kbL7yi06Mpy4MoOJ2DGN6a9176npVNaQZTAzsioe87BAoGBANboA7He0EnuIZP33ynCzRLymideuRAqvMc7TTV7OX7ntmSCSI5zcX69oNGF3qyUhujvKj3MNAH7RD5hWhUCp5K1vCDp5SDP9fLetubZwFjgiIayGekO3CcArJKOxo/52rU/qd1yBp9HbQVLubdbDv7rRo6CY91AQgD7nolyCwYVAoGBAMrYyWRzi09ysc3+lHlHt55dXMjz5OxurFnu2oCm9fGDXr8ppvoWZlJpAT2lMf/4oHQGWRgu/d0nouzsuXBiuHXxVdI0sFMSh5FMWzkccT0Cce+vdAzMrUnJCVHY+QYltOzbpnEI3M7wOn53RU/aPvfcvUuEy2TQESnm5eNBjUixAoGAEPJa2Dvp0OqmWzTAtFpYMZZP8arWjR/RoyRaAk2lSwyapXJgplsUKBpsBBm6ZYGQ4e16N0VTFJTr3L9wixeaf0c1fqLzHpNHoc9OPQYO1PNf0L9aq7YwRiMXeLcpkVDynjhW/M9xFj5bqn8+NedIV3HWLoa5uUjH66vr5IrJs8ECgYAfP6ZGw0YCxzh882sMA/BVhSx2CJyLj8EdWZ5vk0jwG7zM1i3S+QBqUaLPTFOXi0Wsmg2/m/2fxCtlNFKc7ZhdEwCVkWhYY9Jen9Stx6PqMiY7Nlw6XI2VgFLfOP2j5MsqcewCHctmVbutH9KdqpFovairqZlrvmHmgpuHluGdAQKBgHD0kH91OrzE7VqIapawoP9vonVBDEGm6UEtqMQMbLNERlM3D9+WUoVWAARIvnFf29G35b3weWAEofvR3gshkak6lsWCw2AAxj63PJY2Mefifb2uT16PLzDtlwt4t9x8dBVUUavOcfIpWvS/NVBF+7M1heqOVy6RMrX1XF7ybaN/" // 必须，上一步中使用 RSA签名验签工具 生成的私钥
		var client = alipay.New("2016100100635615", aliPublicKey, privateKey, false)

		var p = alipay.AliPayTradeWapPay{}
		//p.NotifyURL = "http://xxx"
		//p.ReturnURL = "http://xxx"
		p.Subject = "标题"
		p.OutTradeNo = "1555840257782"
		p.TotalAmount = "10.00"
		p.ProductCode = "QUICK_WAP_WAY"

		var url, err = client.TradeWapPay(p)
		if err != nil {
			fmt.Println(err)
		}

		var payURL = url.String()
		fmt.Println(payURL)

		res := map[string]interface{}{"url": payURL}
		this.Data["json"] = res
		this.ServeJSON()*/

	// 这个 payURL 即是用于支付的 URL，可将输出的内容复制，到浏览器中访问该 URL 即可打开支付页面。
}

func (this *AlipayNewController) AlipayList() {
	//是否显示更多查询条件的按钮
	this.Data["showMoreQuery"] = true
	//将页面左边菜单的某项激活
	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())
	this.SetTpl("alipay/alipaylist.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["headcssjs"] = "alipay/alipaylist_headcssjs.html"
	this.LayoutSections["footerjs"] = "alipay/alipaylist_footerjs.html"
	//页面里按钮权限控制
	this.Data["canEdit"] = this.CheckActionAuthor("AlipayNewController", "Edit")
	this.Data["canDelete"] = this.CheckActionAuthor("AlipayNewController", "Delete")
}

func (this *AlipayNewController) Delete() {
	strs := this.GetString("ids")
	ids := make([]int, 0, len(strs))
	for _, str := range strings.Split(strs, ",") {
		if id, err := strconv.Atoi(str); err == nil {
			ids = append(ids, id)
		}
	}
	if num, err := models.AlipayUserBatchDelete(ids); err == nil {
		this.JsonResult(enums.JRCodeSucc, fmt.Sprintf("成功删除 %d 项", num), 0)
	} else {
		this.JsonResult(enums.JRCodeFailed, "删除失败", 0)
	}
}

func (this *AlipayNewController) UpdateAppId() {
	Id, _ := this.GetInt("pk", 0)
	oM, err := models.AlipayUserOne(Id)
	if err != nil || oM == nil {
		this.JsonResult(enums.JRCodeFailed, "选择的数据无效", 0)
	}
	value := this.GetString("value", "")
	oM.AlipayAppid = value
	o := orm.NewOrm()
	if _, err := o.Update(oM); err == nil {
		this.JsonResult(enums.JRCodeSucc, "修改成功", oM.AlipayId)
	} else {
		this.JsonResult(enums.JRCodeFailed, "修改失败", oM.AlipayId)
	}
}

//Edit 添加、编辑商铺的支付宝后台配置界面
func (this *AlipayNewController) Edit() {
	if this.Ctx.Request.Method == "POST" {
		this.Save()
	}
	Id, _ := this.GetInt(":id", 0)
	m := models.AlipayUser{AlipayId: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}
	}
	this.Data["m"] = m
	this.SetTpl("alipay/edit.html", "shared/layout_pullbox.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "alipay/edit_footerjs.html"
}

//Save 添加、编辑页面 保存
func (this *AlipayNewController) Save() {
	var err error
	m := models.AlipayUser{}
	//获取form里的值
	if err = this.ParseForm(&m); err != nil {
		this.JsonResult(enums.JRCodeFailed, "获取数据失败", m.AlipayId)
	}

	backUser := new(models.BackendUser)
	backUser.Id = this.BaseController.GetCurrentId()

	m.BackendUser = backUser
	o := orm.NewOrm()
	if m.AlipayId == 0 {
		if _, err = o.Insert(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "添加成功", m.AlipayId)
		} else {
			fmt.Printf("%s", err)

			this.JsonResult(enums.JRCodeFailed, "添加失败", m.AlipayId)
		}

	} else {
		if _, err = o.Update(&m); err == nil {
			this.JsonResult(enums.JRCodeSucc, "编辑成功", m.AlipayId)
		} else {
			this.JsonResult(enums.JRCodeFailed, "编辑失败", m.AlipayId)
		}
	}

}

// DataGrid 角色管理首页 表格获取数据
func (this *AlipayNewController) DataGrid() {
	//直接反序化获取json格式的requestbody里的值
	var params models.AlipayQueryParam
	json.Unmarshal(this.Ctx.Input.RequestBody, &params)

	params.BackUserId = this.GetCurrentId()
	//获取数据列表和总数
	data, total := models.AlipayPageList(&params)
	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	this.Data["json"] = result
	this.ServeJSON()
}

//DataList 角色列表
func (this *AlipayNewController) DataList() {
	var params = models.AlipayQueryParam{}
	//获取数据列表和总数
	data := models.AlipayDataList(&params)
	//定义返回的数据结构
	this.JsonResult(enums.JRCodeSucc, "", data)
}
