package models

import "github.com/astaxie/beego/orm"

// TableName 设置表名
func (a *Tab) TableName() string {
	return TabTBName()
}

type TabQueryParam struct {
	NameLike string
	BaseQueryParam
}

func TabPageList(params *TabQueryParam) ([]*Tab, int64) {
	query := orm.NewOrm().QueryTable(TabTBName())

	sortId := params.Sort
	if sortId == "" {
		sortId = "TabId"
	}

	if params.Order == "desc" {
		sortId = "-" + sortId
	}

	data := make([]*Tab, 0)

	query = query.Filter("TabName__istartswith", params.NameLike)

	count, _ := query.Count()

	query.OrderBy(sortId).Limit(params.Limit).All(&data)

	return data, count
}

func TabDataList(params *TabQueryParam) []*Tab {
	//query := orm.NewOrm().QueryTable(TabTBName())

	params.Limit = -1
	params.Order = "asc"
	params.Sort = "TabWeight"

	data, _ := TabPageList(params)
	return data
}

// 理论上不允许删除
func DeleteBatchTab(ids []int) (int64, error) {
	query := orm.NewOrm().QueryTable(TabTBName())

	return query.Filter("TabId__in", ids).Delete()
}

func GetOneTabDetail(id int) (*Tab, error) {
	tab := &Tab{TabId: id}

	err := orm.NewOrm().Read(tab)

	return tab, err
}

type Tab struct {
	TabId     int        `form:"TabId" orm:"auto;pk"`
	TabName   string     `form:"TabName"`
	TabWeight int8       `form:"TabWeight"`
	TabStatus int8       `form:"TabStatus"`
	GameTab   []*GameTab `orm:"reverse(many)" json:"-"`
	TabType   *TabType   `orm:"rel(fk);null;on_delete(set_null)"`
}
