package enums

type JsonResultCode int

const (
	JRCodeSucc JsonResultCode = iota
	JRCodeFailed
	JRCode302 = 302 //跳转至地址
	JRCode401 = 401 //未授权访问
)

const (
	Deleted = iota - 1
	Disabled
	Enabled
)

type SwiperType int

const (
	SwiperTypeGame SwiperType = iota
	SwiperTypeNotice
)

type TabType int8

const (
	TabTypeMain TabType = iota + 1
	TabTypeGame
)

type StatusType int

const (
	StatusOpen StatusType = iota + 1
	StatusForbind
	StatusHide
)
