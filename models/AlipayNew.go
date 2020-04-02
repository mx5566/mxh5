package models

import "github.com/astaxie/beego/orm"

// TableName 设置表名
func (a *AlipayUser) TableName() string {
	return AlipayUserTBName()
}

// RoleQueryParam 用于搜索的类
type AlipayQueryParam struct {
	BaseQueryParam
	NameLike   string
	BackUserId int
}

// Alipay 支付宝 实体类
type AlipayUser struct {
	AlipayId            int          `form:"AlipayId" orm:"auto;pk"`
	AlipayBsName        string       `form:"AlipayBsName"`
	AlipayPublicSecret  string       `from:"AlipayPublicSecret"`
	AlipayAppid         string       `from:"AlipayAppid"`
	AlipayPrivateSecret string       `from:"AlipayPrivateSecret"`
	BackendUser         *BackendUser `orm:"rel(fk)"`
}

// RolePageList 获取分页数据
func AlipayPageList(params *AlipayQueryParam) ([]*AlipayUser, int64) {
	query := orm.NewOrm().QueryTable(AlipayUserTBName())
	data := make([]*AlipayUser, 0)
	//默认排序
	sortorder := "AlipayId"
	switch params.Sort {
	case "AlipayId":
		sortorder = "AlipayId"
	}
	if params.Order == "desc" {
		sortorder = "-" + sortorder
	}
	query = query.Filter("alipay_bs_name__istartswith", params.NameLike)
	if params.BackUserId != 0 {
		query = query.Filter("backend_user_id", params.BackUserId)
	}
	total, _ := query.Count()
	query.OrderBy(sortorder).Limit(params.Limit, params.Offset).All(&data)
	return data, total
}

// RoleDataList 获取角色列表
func AlipayDataList(params *AlipayQueryParam) []*AlipayUser {
	params.Limit = -1
	params.Sort = "AlipayId"
	params.Order = "asc"
	data, _ := AlipayPageList(params)
	return data
}

// AlipayUserBatchDelete 批量删除
func AlipayUserBatchDelete(ids []int) (int64, error) {
	query := orm.NewOrm().QueryTable(AlipayUserTBName())
	num, err := query.Filter("AlipayId__in", ids).Delete()
	return num, err
}

// AlipayUserOne 获取单条
func AlipayUserOne(id int) (*AlipayUser, error) {
	o := orm.NewOrm()
	m := AlipayUser{AlipayId: id}
	err := o.Read(&m)
	if err != nil {
		return nil, err
	}
	return &m, nil
}
