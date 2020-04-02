package models

import "github.com/astaxie/beego/orm"

// TableName 设置表名
func (a *Image) TableName() string {
	return ImageTBName()
}

// RoleQueryParam 用于搜索的类
type ImageQueryParam struct {
	BaseQueryParam
	BackUserId int
}

// 图片结构
type Image struct {
	Id           int64        `orm:"auto;pk" form:"Id"`
	ImagePath    string       `orm:"size(100)" form:"ImagePath"`
	ImageName    string       `orm:"size(50)" form:"ImageName"`
	ImageNameMd5 string       `orm:"size(32)" form:"ImageNameMd5"`
	ImageInfo    string       `orm:"size(100)" form:"ImageInfo"`
	BackendUser  *BackendUser `orm:"rel(fk)"`
}

// ImageBatchDelete 批量删除
func ImageBatchDelete(ids []int64) (int64, error) {
	query := orm.NewOrm().QueryTable(ImageTBName())
	num, err := query.Filter("Id__in", ids).Delete()
	return num, err
}

// ImageDeleteOne 批量删除
func ImageDeleteOne(id int64) (int64, error) {
	query := orm.NewOrm().QueryTable(ImageTBName())
	num, err := query.Filter("Id", id).Delete()
	return num, err
}

// ImageOne 获取单条
func FindOneImage(id int64) (*Image, error) {
	o := orm.NewOrm()
	m := Image{Id: id}
	err := o.Read(&m)
	if err != nil {
		return nil, err
	}
	return &m, nil
}

// 获取列表
func GetImageLists(params *ImageQueryParam) ([]*Image, int64) {
	query := orm.NewOrm().QueryTable(ImageTBName())
	data := make([]*Image, 0)

	// 排序
	sortorder := "Id"

	switch params.Sort {
	case "Id":
		sortorder = "Id"
	}
	if params.Order == "desc" {
		sortorder = "-" + sortorder
	}
	if params.BackUserId != 0 {
		query = query.Filter("backend_user_id", params.BackUserId)
	}
	total, _ := query.Count()
	query.OrderBy(sortorder).Limit(params.Limit, params.Offset).All(&data)
	return data, total
}
