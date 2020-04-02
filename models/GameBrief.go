package models

type MsgHeader struct {
	Opcode   uint16 // 消息号ID
	MsgSize  uint16 // 消息的长度
	Sequence uint32 // 消息的序列号
}
