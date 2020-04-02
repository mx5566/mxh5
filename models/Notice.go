package models

import (
	"time"

	"github.com/astaxie/beego/orm"
)

func (a *Notice) TableName() string {
	return NoticeTBName()
}

type Notice struct {
	NoticeId         int64     `form:"NoticeId" orm:"auto;pk"`
	NoticeTitle      string    `form:"NoticeTitle" orm:"size(128);description(公告标题)"`
	NoticeContent    string    `form:"NoticeContent" orm:"type(text);description(公告内容)"`
	NoticeWeight     int8      `form:"NoticeWeight" orm:"description(权重)"`
	NoticeStatus     int8      `form:"NoticeStatus" orm:"default(1);description(status)"`
	NoticeCreateTime time.Time `form:"-" orm:"auto_now_add;type(datetime)"`
	NoticeEditTime   time.Time `form:"-" orm:"auto_now;type(datetime)"`
	Game             *Game     `orm:"rel(fk)"`
}

type NoticeQueryParam struct {
	NameLike string
	GameId   int64
	BaseQueryParam
}

func NoticeList() []*Notice {
	query := orm.NewOrm().QueryTable(NoticeTBName())

	data := make([]*Notice, 0)
	query.All(&data)

	return data
}

func NoticePageList(params *NoticeQueryParam) ([]*Notice, int64) {
	query := orm.NewOrm().QueryTable(NoticeTBName())

	sortId := params.Sort
	if sortId == "" {
		sortId = "NavId"
	}

	if params.Order == "desc" {
		sortId = "-" + sortId
	}

	if params.GameId != 0 {
		query = query.Filter("game_id", params.GameId)
	}

	data := make([]*Notice, 0)

	query = query.Filter("NoticeTitle__istartswith", params.NameLike)

	count, _ := query.Count()

	query.OrderBy(sortId).Limit(params.Limit).All(&data)

	return data, count
}

func NoticeDataList(params *NoticeQueryParam) []*Notice {
	params.Limit = -1
	params.Order = "asc"
	params.Sort = "NoticeWeight"

	data, _ := NoticePageList(params)
	return data
}

// 理论上不允许删除
func DeleteBatchNotice(ids []int64) (int64, error) {
	query := orm.NewOrm().QueryTable(NoticeTBName())

	return query.Filter("NoticeId__in", ids).Delete()
}

func GetOneNoticeDetail(id int64) (*Notice, error) {
	notice := &Notice{NoticeId: id}

	err := orm.NewOrm().Read(notice)

	return notice, err
}
