package models

import "github.com/astaxie/beego/orm"

func (a *GameTab) TableName() string {
	return GameTabTBName()
}

type GameTab struct {
	Id   int64
	Tab  *Tab  `orm:"rel(fk)"`
	Game *Game `orm:"rel(fk)"`
}

func GetGameTabList(id int64) []*GameTab {
	query := orm.NewOrm().QueryTable(GameTabTBName())

	data := make([]*GameTab, 0)

	query.Filter("game_id", id).RelatedSel("Tab").All(&data)

	return data
}
