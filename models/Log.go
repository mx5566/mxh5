package models

import (
	"time"

	"github.com/astaxie/beego/orm"
)

// TableName 设置表名
func (a *LogUserLogin) TableName() string {
	return LogUserTBName()
}

// LogQueryParam 用于搜索的类
type LogQueryParam struct {
	BaseQueryParam
	NameLike string
}

type LogUserLogin struct {
	Id        int       `orm:"auto;pk" from:"Id"`
	UserName  string    `orm:"size(32)" form:"UserName"`
	LoginIp   string    `orm:"size(16)" form:"LoginIp"`
	LoginTime time.Time `orm:"auto_now;type(datetime)" form:"LoginTime"`
}

// LogPageList 获取分页数据
func LogPageList(params *LogQueryParam) ([]*LogUserLogin, int64) {
	query := orm.NewOrm().QueryTable(LogUserTBName())
	data := make([]*LogUserLogin, 0)
	//默认排序
	sortorder := "Id"
	switch params.Sort {
	case "Id":
		sortorder = "Id"
	}
	if params.Order == "desc" {
		sortorder = "-" + sortorder
	}
	query = query.Filter("user_name__istartswith", params.NameLike)

	total, _ := query.Count()
	query.OrderBy(sortorder).Limit(params.Limit, params.Offset).All(&data)
	return data, total
}

// LogDataList 所有的登录日志
func LogDataList(params *LogQueryParam) []*LogUserLogin {
	params.Limit = -1
	params.Sort = "Id"
	params.Order = "asc"
	data, _ := LogPageList(params)
	return data
}

func LoginTraceAdd(_user string, _remote_add string, _login_time time.Time) error {
	m := LogUserLogin{UserName: _user, LoginIp: _remote_add, LoginTime: _login_time}

	o := orm.NewOrm()
	if _, err := o.Insert(&m); err == nil {
		return nil
	} else {
		return err
	}
}
