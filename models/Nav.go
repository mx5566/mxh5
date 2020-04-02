package models

import (
	"github.com/astaxie/beego/orm"
)

func (a *Nav) TableName() string {
	return NavTBName()
}

type Nav struct {
	NavId     int32  `form:"NavId" orm:"auto;pk"`
	NavName   string `form:"NavName" orm:"size(16);description(导航名)"`
	NavWeight int8   `form:"NavWeight" orm:"description(权重)"`
	NavStatus int8   `form:"NavStatus" orm:"default(1);description(status)"`
}

type NavQueryParam struct {
	NameLike string
	BaseQueryParam
}

func NavList() []*Nav {
	query := orm.NewOrm().QueryTable(NavTBName())

	data := make([]*Nav, 0)
	query.All(&data)

	return data
}

func NavPageList(params *NavQueryParam) ([]*Nav, int64) {
	query := orm.NewOrm().QueryTable(NavTBName())

	sortId := params.Sort
	if sortId == "" {
		sortId = "NavId"
	}

	if params.Order == "desc" {
		sortId = "-" + sortId
	}

	data := make([]*Nav, 0)

	query = query.Filter("NavName__istartswith", params.NameLike)

	count, _ := query.Count()

	query.OrderBy(sortId).Limit(params.Limit).All(&data)

	return data, count
}

func NavDataList(params *NavQueryParam) []*Nav {
	params.Limit = -1
	params.Order = "asc"
	params.Sort = "NavWeight"

	data, _ := NavPageList(params)
	return data
}

// 理论上不允许删除
func DeleteBatchNav(ids []int) (int64, error) {
	query := orm.NewOrm().QueryTable(NavTBName())

	return query.Filter("NavId__in", ids).Delete()
}

func GetOneNavDetail(id int32) (*Nav, error) {
	nav := &Nav{NavId: id}

	err := orm.NewOrm().Read(nav)

	return nav, err
}
