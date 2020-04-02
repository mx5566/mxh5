package main

import (
	_ "mxh5/routers"
	_ "mxh5/sysinit"

	"github.com/astaxie/beego"
)

func main() {
	beego.Run()

}
