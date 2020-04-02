package controllers

import (
	"mxh5/enums"

	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"mxh5/models"
	"net/http"
	"os"
	"strconv"
	"time"

	"github.com/astaxie/beego/orm"
)

type ImageController struct {
	BaseController
}

// 生成32位MD5
func MD5(text string) string {
	ctx := md5.New()
	ctx.Write([]byte(text))
	return hex.EncodeToString(ctx.Sum(nil))
}

//Prepare 参考beego官方文档说明
func (this *ImageController) Prepare() {
	//先执行
	this.BaseController.Prepare()
	//如果一个Controller的多数Action都需要权限控制，则将验证放到Prepare
	this.CheckAuthor("ImageList", "UploadCkEditorImage")
	//如果一个Controller的所有Action都需要登录验证，则将验证放到Prepare
	//权限控制里会进行登录验证，因此这里不用再作登录验证
	//c.checkLogin()
}

// Index
func (this *ImageController) Index() {
	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "image/index_footerjs.html"
	this.LayoutSections["headcssjs"] = "image/index_headcssjs.html"

	this.Data["token"] = "upload"
	this.SetSession("imagetoken", "upload")
	this.Layout = "shared/layout_page.html"
	this.TplName = "image/index.html"
}

// upload image
func (this *ImageController) UploadImage() {
	//这里type没有用，只是为了演示传值
	files, err := this.GetFiles("input-b3[]")
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, "上传失败", "")
	}

	fmt.Printf("file size %d", len(files))

	var fileNames []string
	for key, _ := range files {
		fmt.Printf("file name %s", files[key].Filename)

		//fmt.Printf("file size %d", key)
		file, err := files[key].Open()
		defer file.Close()
		if err != nil {
			http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
			return
		}

		year, month, day := time.Now().Date()
		hour, min, sec := time.Now().Clock()

		filename := strconv.Itoa(hour) + strconv.Itoa(min) + strconv.Itoa(sec)

		var sep string
		sep = "/"

		//create destination file making sure the path is writeable.
		dir := "static" + sep + "upload" + sep + strconv.Itoa(year) + sep + strconv.Itoa(int(month)) + sep + strconv.Itoa(day)
		_, err = os.Stat(dir)

		// 不存在目录
		if err != nil {
			if os.IsNotExist(err) {
				err = os.MkdirAll(dir, 0777)
				if err != nil {
					http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
					return
				}
			} else {
				http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
				return
			}
		}

		path := dir + sep + filename + files[key].Filename
		dst, err := os.Create(path)
		defer dst.Close()
		if err != nil {
			http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
			return
		}
		//copy the uploaded file to the destination file
		if _, err := io.Copy(dst, file); err != nil {
			http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
			return
		}

		fileNames = append(fileNames, "/"+path)
	}

	this.JsonResult(enums.JRCodeSucc, "上传成功", fileNames)
}

func (this *ImageController) BasicInfoSave() {
	sToken := this.GetSession("imagetoken")
	if sToken == nil {
		this.JsonResult(enums.JRCodeFailed, "重复上传图片", "")
	}

	sTemp := sToken.(string)
	if len(sTemp) <= 0 {
		this.JsonResult(enums.JRCodeFailed, "重复上传图片", "")
	}

	Id := this.curUser.Id
	//获取form里的值
	paths := this.GetString("names", "")
	imageInfo := this.GetString("ImageInfo", "没有描述")
	imageName := this.GetString("ImageName", "没有名字")
	token := this.GetString("token", "upload")

	if sTemp != token {
		this.JsonResult(enums.JRCodeFailed, "token不一致", "")
	}

	this.DelSession("imagetoken")

	var sliceNames []string
	err := json.Unmarshal([]byte(paths), &sliceNames)
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, "错误的图片名字组合", "")
	}

	if len(sliceNames) <= 0 {
		this.JsonResult(enums.JRCodeFailed, "图片没有上传", "")
	}

	backUser := new(models.BackendUser)
	backUser.Id = Id

	mImage := &models.Image{}

	mImage.BackendUser = backUser

	var failNmaes []string
	for _, value := range sliceNames {
		mImage.ImageInfo = imageInfo
		mImage.ImageName = imageName

		mImage.ImagePath = value
		mImage.ImageNameMd5 = MD5(string(Id) + mImage.ImageName)

		o := orm.NewOrm()

		if _, err := o.Insert(mImage); err != nil {
			failNmaes = append(failNmaes, mImage.ImageName)
		}
	}

	if len(failNmaes) <= 0 {
		this.JsonResult(enums.JRCodeSucc, "保存上传的图片成功", "")
	} else {
		this.JsonResult(enums.JRCodeFailed, "部分失败", failNmaes)
	}
}

// remove Images
func (this *ImageController) RemoveImages() {
	id, _ := this.GetInt64("id")

	if id <= 0 {
		this.JsonResult(enums.JRCodeFailed, "错误的图片ID", "")
	}

	m := models.Image{Id: id}
	o := orm.NewOrm()
	err := o.Read(&m)
	if err != nil {
		this.PageError("数据无效，请刷新后重试")
	}

	if len(m.ImagePath) <= 0 {
		this.JsonResult(enums.JRCodeFailed, "图片不存在", "")
	}

	err = os.Remove(m.ImagePath[1:])
	if err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	if _, err := o.Delete(&models.Image{Id: id}); err != nil {
		this.JsonResult(enums.JRCodeFailed, err.Error(), "")
	}

	this.JsonResult(enums.JRCodeSucc, "成功", "")
}

func (this *ImageController) UpdateImage() {
	Id, _ := this.GetInt64("id", 0)
	m := models.Image{Id: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}

		imageInfo := this.GetString("ImageInfo", "没有描述")
		imageName := this.GetString("ImageName", "没有名字")
		paths := this.GetString("names", "")

		m.ImageName = imageName
		m.ImageInfo = imageInfo
		m.ImagePath = paths
		UserId := this.curUser.Id

		m.ImageNameMd5 = MD5(string(UserId) + m.ImageName)

		_, err = o.Update(&m, "ImagePath", "ImageName", "ImageNameMd5", "ImageInfo")
		if err != nil {
			this.JsonResult(enums.JRCodeFailed, "更新失败", "")
		}

		this.JsonResult(enums.JRCodeSucc, "更新成功", m)

	} else {
		this.JsonResult(enums.JRCodeFailed, "图片没指定", "")
	}
}

func (this *ImageController) UploadSingleImage() {
	//这里type没有用，只是为了演示传值
	f, h, err := this.GetFile("input-b3")

	if err != nil {
		this.JsonResult(enums.JRCodeFailed, "上传失败", "")
	}
	defer f.Close()

	year, month, day := time.Now().Date()
	hour, min, sec := time.Now().Clock()

	filename := strconv.Itoa(hour) + strconv.Itoa(min) + strconv.Itoa(sec)

	var sep string
	sep = "/"

	//create destination file making sure the path is writeable.
	dir := "static" + sep + "upload" + sep + strconv.Itoa(year) + sep + strconv.Itoa(int(month)) + sep + strconv.Itoa(day)
	_, err = os.Stat(dir)

	// 不存在目录
	if err != nil {
		if os.IsNotExist(err) {
			err = os.MkdirAll(dir, 0777)
			if err != nil {
				http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
				return
			}
		} else {
			http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
			return
		}
	}

	path := dir + sep + filename + h.Filename

	// 保存位置在 static/upload, 没有文件夹要先创建
	this.SaveToFile("input-b3", path)
	this.JsonResult(enums.JRCodeSucc, "上传成功", "/"+path)
}

func (this *ImageController) UploadCkEditorImage() {
	ret := make(map[string]interface{})

	type retCk struct {
		uploaded int
		error    interface{}
	}

	CKEditorFuncNum, err := this.GetInt("CKEditorFuncNum", 1)
	if err != nil {
		//str := `{
		//	"uploaded": 0,
		//	"error": {
		//		"message": "The file is too big."
		//	}
		//}`

		ret["uploaded"] = 0
		ret["error"] = `{"message": ".CKEditorFuncNum error " }`
		this.Data["json"] = ret
		this.ServeJSON()
		this.StopRun()

		//this.JsonResult(enums.JRCodeFailed, "上传失败", "")
	}

	//这里type没有用，只是为了演示传值
	f, h, err := this.GetFile("upload")

	if err != nil {
		ret["uploaded"] = 0
		ret["error"] = `{message: ".CKEditorFuncNum  " }`
		this.Data["json"] = ret
		this.ServeJSON()
		this.StopRun()

		//this.JsonResult(enums.JRCodeFailed, "上传失败", "")
	}

	defer f.Close()

	year, month, day := time.Now().Date()
	hour, min, sec := time.Now().Clock()

	filename := strconv.Itoa(hour) + strconv.Itoa(min) + strconv.Itoa(sec)

	var sep string
	sep = "/"

	//create destination file making sure the path is writeable.
	dir := "static" + sep + "upload" + sep + strconv.Itoa(year) + sep + strconv.Itoa(int(month)) + sep + strconv.Itoa(day)
	_, err = os.Stat(dir)

	// 不存在目录
	if err != nil {
		if os.IsNotExist(err) {
			err = os.MkdirAll(dir, 0777)
			if err != nil {
				http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
				return
			}
		} else {
			http.Error(this.Ctx.ResponseWriter, err.Error(), http.StatusInternalServerError)
			return
		}
	}

	path := dir + sep + filename + h.Filename

	// 保存位置在 static/upload, 没有文件夹要先创建
	this.SaveToFile("upload", path)

	ret["uploaded"] = strconv.Itoa(CKEditorFuncNum)
	ret["fileName"] = filename + h.Filename
	ret["url"] = "/" + path
	ret["error"] = `{"message": ""}`

	this.Data["json"] = ret
	this.ServeJSON()
	this.StopRun()

	//this.JsonResult(enums.JRCodeSucc, "上传成功", ret)
}

// edit image
func (this *ImageController) EditImage() {

	fmt.Printf("EditImage-------------")
	if this.Ctx.Request.Method == "POST" {
		this.UpdateImage()
	}
	Id, _ := this.GetInt64(":id", 0)
	m := models.Image{Id: Id}
	if Id > 0 {
		o := orm.NewOrm()
		err := o.Read(&m)
		if err != nil {
			this.PageError("数据无效，请刷新后重试")
		}
	}

	this.Data["image"] = m
	this.Data["hasImage"] = len(m.ImagePath) > 0
	this.SetTpl("image/edit.html", "shared/layout_pullbox.html")
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["footerjs"] = "image/edit_footerjs.html"
	this.LayoutSections["headcssjs"] = "image/edit_headcssjs.html"
}

// image list
func (this *ImageController) ImageList() {
	this.Data["activeSidebarUrl"] = this.URLFor(this.GetControllerName() + "." + this.GetActionName())

	currentpage, _ := this.GetInt64(":page", 1)

	backUser := new(models.BackendUser)
	backUser.Id = this.GetCurrentId()
	pageSize := int64(6)

	var params models.ImageQueryParam
	params.Offset = int64((currentpage - 1) * pageSize)
	params.Limit = int(pageSize)
	params.BackUserId = this.GetCurrentId()

	//获取数据列表和总数
	data, total := models.GetImageLists(&params)

	if currentpage < 1 || currentpage*pageSize >= pageSize+total {
		currentpage = 1
	}

	st, end := pageSize*(currentpage-1), pageSize*currentpage
	if st > total || st < 0 {
		st = 0
	}
	if end > total || end < 0 {
		end = total
	}

	//定义返回的数据结构
	result := make(map[string]interface{})
	result["total"] = total
	result["rows"] = data
	result["eachpage"] = params.Limit
	result["currentpage"] = currentpage

	tp := total / int64(params.Limit)
	if total%int64(params.Limit) > 0 {
		tp = tp + 1
	}

	result["totalpage"] = tp
	result["page"] = currentpage
	this.Data["json"] = result

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["headcssjs"] = "image/imagelist_headcssjs.html"
	this.LayoutSections["footerjs"] = "image/imagelist_footerjs.html"

	this.SetTpl("image/imagelist.html", "shared/layout_page.html")
}
