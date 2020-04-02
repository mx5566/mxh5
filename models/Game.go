package models

import "github.com/astaxie/beego/orm"

// TableName 设置表名
func (a *Game) TableName() string {
	return GameTBName()
}

type GameQueryParam struct {
	BaseQueryParam
	NameLike   string
	GameType   int32
	BackUserId int
}

type Game struct {
	GameId          int64        `form:"GameId" orm:"auto;pk"`
	GameName        string       `form:"GameName" orm:"size(32);unique"`
	GameType        int32        `form:"GameType"`
	GameIcov        int64        `form:"GameIcov"`
	GamePerNum      int64        `form:"GamePerNum"`
	GameStatus      int8         `form:"GameStatus"`
	GameWeight      int32        `form:"GameWeight"`
	GameIcovStr     string       `form:"GameIcovStr" orm:"size(32)"`
	GameDescription string       `form:"GameDescription" orm:"size(512)"`
	GameTab         []*GameTab   `orm:"reverse(many)" json:"-"`
	BackendUser     *BackendUser `orm:"rel(fk)"`
}

func GamePageList(params *GameQueryParam) ([]*Game, int64) {
	query := orm.NewOrm().QueryTable(GameTBName())
	data := make([]*Game, 0)
	//默认排序
	sortorder := "GameId"
	switch params.Sort {
	case "GameId":
		sortorder = "GameId"
	case "GameWeight":
		sortorder = "GameWeight"
	}
	if params.Order == "desc" {
		sortorder = "-" + sortorder
	}

	if params.BackUserId != 0 {
		query = query.Filter("backend_user_id__istartswith", params.BackUserId)
	}

	if params.NameLike != "" {
		query = query.Filter("game_name__istartswith", params.NameLike)
	}

	if params.GameType != 0 {
		query = query.Filter("game_type", params.GameType)
	}

	total, _ := query.Count()
	query.OrderBy(sortorder).Limit(params.Limit, params.Offset).All(&data, "GameId", "GameName", "GameType", "GameIcov", "GamePerNum", "GameStatus", "GameWeight", "GameIcovStr", "GameDescription")
	return data, total
}

// 获取游戏了列表
func GameDataList(params *GameQueryParam) []*Game {
	params.Limit = -1
	params.Sort = "GameWeight"
	params.Order = "desc"
	data, _ := GamePageList(params)
	return data
}

// 删除游戏
func DelGame(id int64) (int64, error) {
	query := orm.NewOrm().QueryTable(GameTBName())
	num, err := query.Filter("game_id", id).Delete()

	if err != nil {
		return num, err
	}

	// 删除tab映射表里的所有的游戏数据
	query = orm.NewOrm().QueryTable(GameTabTBName())
	num, err = query.Filter("game_id", id).Delete()

	return num, err
}

// 批量删除
func DelsGames(ids []int64) (int64, error) {
	query := orm.NewOrm().QueryTable(GameTBName())
	num, err := query.Filter("GameId__in", ids).Delete()

	// 删除tab映射表里的所有的游戏数据
	query = orm.NewOrm().QueryTable(TabTBName())
	num, err = query.Filter("__in").Delete()

	return num, err
}

// 查找游戏
func FindOneGame(id int64) (error, *Game) {
	query := orm.NewOrm().QueryTable(GameTBName())

	game := Game{}
	err := query.Filter("GameId", id).One(&game)

	return err, &game
}
