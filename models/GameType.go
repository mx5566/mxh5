package models

import "github.com/astaxie/beego/orm"

func (a *GameType) TableName() string {
	return GameTypeTBName()
}

type GameTypeQueryParam struct {
	NameLike string
	BaseQueryParam
}

type GameType struct {
	GameTypeId     int32  `form:"GameTypeId" orm:"auto;pk" `
	GameTypeName   string `form:"GameTypeName" orm:"size(16);description(类传奇)"`
	GameTypeWeight int8   `form:"GameTypeWeight" orm:"description(权重)"`
	GameTypeStatus int8   `form:"GameTypeStatus" orm:"default(1);description(status)"`
}

func GameTypePageList() []*GameType {
	query := orm.NewOrm().QueryTable(GameTypeTBName())

	data := make([]*GameType, 0)

	query.All(&data)

	return data
}

func GameTypePageListByParams(params *GameTypeQueryParam) ([]*GameType, int64) {
	query := orm.NewOrm().QueryTable(GameTypeTBName())

	sortId := params.Sort
	if sortId == "" {
		sortId = "GameTypeId"
	}

	if params.Order == "desc" {
		sortId = "-" + sortId
	}

	data := make([]*GameType, 0)

	query = query.Filter("GameTypeName__istartswith", params.NameLike)

	count, _ := query.Count()

	query.OrderBy(sortId).Limit(params.Limit).All(&data)

	return data, count
}

func GameTypeDataList(params *GameTypeQueryParam) []*GameType {
	params.Limit = -1
	params.Order = "asc"
	params.Sort = "GameTypeWeight"

	data, _ := GameTypePageListByParams(params)
	return data
}

// 理论上不允许删除
func DeleteBatchGameType(ids []int) (int64, error) {
	query := orm.NewOrm().QueryTable(GameTypeTBName())

	return query.Filter("GameTypeId__in", ids).Delete()
}

func GetOneGameTypeDetail(id int32) (*GameType, error) {
	gameType := &GameType{GameTypeId: id}

	err := orm.NewOrm().Read(gameType)

	return gameType, err
}
