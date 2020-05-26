-- Author      : 洛阿神灵木事@一区-加丁-炉石旅馆
-- Create Date : 5/17/2020 3:55:19 PM

-- ===============================
--  @快捷发送消息
-- ===============================

local QuickMessageFrame = getglobal("QuickMessageFrame")
local QMButtonInit = getglobal("QMButtonInit")
local QMButtonHide = getglobal("QMButtonHide")
local QMButtonSendDaJiao = getglobal("QMButtonSendDaJiao")
local QMButtonSendParty = getglobal("QMButtonSendParty")
local QMButtonSendYell = getglobal("QMButtonSendYell")
local QMButtonSendGeneral = getglobal("QMButtonSendGeneral")
local QMEditBoxInputMessage = getglobal("QMEditBoxInputMessage")

function QuickMessageFrame:OnClick()
	QMEditBoxInputMessage:ClearFocus()
end

function QMButtonInit:OnClick()
	print("QMButtonInit:OnClick")
	local channelObjList = QuickMessageFrame:GetJoinedChannels()
end

function QMButtonHide:OnClick()
	print("QMButtonHide:OnClick")
	QuickMessageFrame:Hide()
end

function QuickMessageFrame:SendAllMessage(originFrame, button)
	print("SendAllMessage")
	local msg = QMEditBoxInputMessage:GetText()
	--SendMessageToChannelName(msg, "大脚世界频道")
	--SendMessageToChannelName(msg, "寻求组队")
	--SendMessageToChannelName(msg, "综合")
	--SendChatMessage(msg, "CHANNEL", nil, 7); 
	--QMButtonSend:SendMessageToEveryChannel(msg)
	--QMButtonSend:SendMessageToStaticChannelList(msg)
	QMEditBoxInputMessage:ClearFocus()
end

function QMButtonSendDaJiao:SendMessage(originFrame, button)
	print("QMButtonSendDaJiao:SendMessage")
	local msg = QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
	SendChatMessage(msg, "CHANNEL", nil, 7)
	--QuickMessageFrame:SendMessageToChannelName(msg, "大脚世界频道")
	QMEditBoxInputMessage:ClearFocus()
end

function QMButtonSendParty:SendMessage(originFrame, button)
	print("QMButtonSendParty:SendMessage")
	local msg = QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
	SendChatMessage(msg, "CHANNEL", nil, 6)
	--QuickMessageFrame:SendMessageToChannelName(msg, "寻求组队")
	QMEditBoxInputMessage:ClearFocus()
end

function QMButtonSendYell:SendMessage(originFrame, button)
	print("QMButtonSendYell:SendMessage")
	local msg = QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
	SendChatMessage(msg, "YELL"); 
	QMEditBoxInputMessage:ClearFocus()
end

function QMButtonSendGeneral:SendMessage(originFrame, button)
	print("QMButtonSendGeneral:SendMessage")
	local msg = QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
	SendChatMessage(msg, "CHANNEL", nil, 2)
	--QuickMessageFrame:SendMessageToChannelName(msg, "综合")
	--QuickMessageFrame:SendMessageToEveryChannel(msg)
	QMEditBoxInputMessage:ClearFocus()
end

function QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
	local msg = QMEditBoxInputMessage:GetText()
	local randomSuffix = math.random(100, 999)
	msg = msg .. "---" .. randomSuffix
	return msg
end

function QuickMessageFrame:SendMessageToStaticChannelList(msg)
	local channelObjList = QMButtonSend:GetJoinedChannels()
	SendChatMessage(msg, "CHANNEL", nil, 2); 
	SendChatMessage(msg, "CHANNEL", nil, 5); 
	SendChatMessage(msg, "CHANNEL", nil, 11); 
	SendChatMessage(msg, "CHANNEL", nil, 3); 
end

function QuickMessageFrame:SendMessageToEveryChannel(msg)
	local channelObjList = self:GetJoinedChannels()
	for i=1, #channelObjList do
		local _channelObj = channelObjList[i]
		if (channelObjList~=nil) then
			print("channelName:".._channelObj.name.." channelId:".._channelObj.id)
			if (_channelObj.name:lower():match(string.lower("大脚世界频道"))) then
				SendChatMessage(msg, "CHANNEL", nil, channelObjList.id)
				print("QMEditBoxInputMessage_SendMessage To: " .. channelObjList.name)
			elseif (_channelObj.name:lower():match(string.lower("寻求组队"))) then
				SendChatMessage(msg, "CHANNEL", nil, channelObjList.id)
				print("QMEditBoxInputMessage_SendMessage To: " .. channelObjList.name)
			elseif (_channelObj.name:lower():match(string.lower("综合"))) then
				SendChatMessage(msg, "CHANNEL", nil, channelObjList.id)
				print("QMEditBoxInputMessage_SendMessage To: " .. channelObjList.name)
			else 
				print("QMEditBoxInputMessage_SendMessage failed: " .. _channelObj.name)	
			end 
		end
	end
end

function QuickMessageFrame:SendMessageToChannelName(msg, channel)
	local index, channelName, _, __ = GetChannelName(channel) -- It finds General is a channel at index 1
	print("QMEditBoxInputMessage_SendMessage To index: " .. index)
	if (index~=nil and index~=0) then 
		SendChatMessage(msg, "CHANNEL", nil, index); 
	end
end

function QuickMessageFrame:GetJoinedChannels()
    local channels = { }
    local chanList = { GetChannelList() }
    for i=1, #chanList, 3 do
		local _channelObj = {
            id = chanList[i],
            name = chanList[i+1],
            isDisabled = chanList[i+2], -- Not sure what a state of "blocked" would be
        }
        table.insert(channels, _channelObj)
		print("channelName:".._channelObj.name.." channelId:".._channelObj.id)
    end
    return channels
end