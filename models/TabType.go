package models

import "github.com/astaxie/beego/orm"

// TableName 设置表名
func (a *TabType) TableName() string {
	return TabTypeTBName()
}

type TabTypeQueryParam struct {
	NameLike string
	BaseQueryParam
}

func TabTypePageList(params *TabTypeQueryParam) ([]*TabType, int64) {
	query := orm.NewOrm().QueryTable(TabTypeTBName())

	sortId := params.Sort
	if sortId == "" {
		sortId = "TabTypeId"
	}

	if params.Order == "desc" {
		sortId = "-" + sortId
	}

	data := make([]*TabType, 0)

	query = query.Filter("TabTypeName__istartswith", params.NameLike)

	count, _ := query.Count()

	query.OrderBy(sortId).Limit(params.Limit).All(&data)

	return data, count
}

func TabTypeDataList(params *TabTypeQueryParam) []*TabType {
	//query := orm.NewOrm().QueryTable(TabTBName())

	params.Limit = -1
	params.Order = "asc"
	params.Sort = "TabTypeWeight"

	data, _ := TabTypePageList(params)
	return data
}

// 理论上不允许删除
func DeleteBatchTabType(ids []int) (int64, error) {
	query := orm.NewOrm().QueryTable(TabTypeTBName())

	return query.Filter("TabTypeId__in", ids).Delete()
}

func GetOneTabTypeDetail(id int8) (*TabType, error) {
	tab := &TabType{TabTypeId: id}

	err := orm.NewOrm().Read(tab)

	return tab, err
}

type TabType struct {
	TabTypeId     int8   `form:"TabTypeId" orm:"pk"`
	TabTypeName   string `form:"TabTypeName" orm:"description(分类类型的明细);default()"`
	TabTypeWeight int8   `form:"TabTypeWeight"`
	TabTypeStatus int8   `form:"TabTypeStatus"`
	Tab           []*Tab `orm:"reverse(many)" json:"-"`
}
