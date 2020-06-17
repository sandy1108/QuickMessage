-- Author      : 洛阿神灵木事@一区-加丁-炉石旅馆
-- Create Date : 5/17/2020 3:55:19 PM

-- ===============================
--  @快捷发送消息
-- ===============================

local buttonHeight = 28
local buttonOffsetY = -15
local unitSizeHeight = buttonHeight - buttonOffsetY

local QMButtonPool = { }

local QuickMessageFrame = getglobal("QuickMessageFrame")
local QMButtonInit = getglobal("QMButtonInit")
local QMButtonHide = getglobal("QMButtonHide")
local QMEditBoxInputMessage = getglobal("QMEditBoxInputMessage")

local function InitSendButton(buttonNumber, aboveButton, channelObj)
	local initButton
	if #QMButtonPool < buttonNumber then
		-- 需要初始化的按钮数量超过了已存在的按钮数量，故需要加一个按钮
		local newButton = CreateFrame("Button", nil, QuickMessageFrame, "OptionsButtonTemplate")
		newButton:SetSize(130, buttonHeight)
		newButton:SetPoint("TOP", aboveButton, "BOTTOM", 0, buttonOffsetY)
		newButton:SetText("发送到" .. channelObj.name)
		-- 保存频道信息在发送按钮中
		newButton.channelObj = channelObj
		-- 设置点击事件
		newButton:SetScript("OnClick", function(self)
			QMEditBoxInputMessage:ClearFocus()
			local msg = QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
			QuickMessageFrame:SendMessageToChannel(msg, channelObj)
		end)
		-- 调整对话框大小
		local frameWidth = QuickMessageFrame:GetWidth()
		local frameHeight = QuickMessageFrame:GetHeight()
		QuickMessageFrame:SetSize(frameWidth, frameHeight + unitSizeHeight)
		QMButtonPool[buttonNumber] = newButton
		initButton = newButton
	else
	    -- 创建好的按钮够用了，不需要再增加
		initButton = QMButtonPool[buttonNumber]
		initButton:SetText("发送到" .. channelObj.name)
		-- 保存频道信息在发送按钮中
		initButton.channelObj = channelObj
		-- 设置点击事件
		initButton:SetScript("OnClick", function(self)
			QMEditBoxInputMessage:ClearFocus()
			local msg = QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
			QuickMessageFrame:SendMessageToChannel(msg, channelObj)
		end)
	end
	return initButton
end

function QuickMessageFrame:OnClick()
	QMEditBoxInputMessage:ClearFocus()
end

function QMButtonInit:OnClick()
	print("QMButtonInit:OnClick")
	local aboveFrame = QMEditBoxInputMessage
	local channelYell = {
		id = -1,
		name = "喊话",
		isDisabled = false
    }
	aboveFrame = InitSendButton(1, aboveFrame, channelYell)
	local channelSay = {
		id = -2,
		name = "说话",
		isDisabled = false
	}
	aboveFrame = InitSendButton(2, aboveFrame, channelSay)
	local staticChannelCount = 2 -- 这里是指上面的喊话和说话这两种消息方式是固定的，所以后面的InitSendButton里携带的序号就是基础上再递增
	local channelObjList = QuickMessageFrame:GetJoinedChannels()
	for i=1, #channelObjList do
		local _channelObj = channelObjList[i]
		aboveFrame = InitSendButton(staticChannelCount + i, aboveFrame, _channelObj)
	end
end

function QMButtonHide:OnClick()
	print("QMButtonHide:OnClick")
	QuickMessageFrame:Hide()
end

function QMEditBoxInputMessage:getQMEditBoxInputMsgWithRandom()
	local msg = QMEditBoxInputMessage:GetText()
	local randomSuffix = math.random(100, 999)
	msg = msg .. "---" .. randomSuffix
	return msg
end

function QuickMessageFrame:SendMessageToChannel(msg, channel)
	local index = channel.id
	print("QMEditBoxInputMessage_SendMessage To index: " .. index)
	if (index~=nil and index~=0) then 
		if (not channel.isDisabled) then
			if (channel.id == -1) then
				-- 喊话
				SendChatMessage(msg, "YELL");
			elseif (channel.id == -2) then
				-- 说话
				SendChatMessage(msg, "SAY");
			else 
				SendChatMessage(msg, "CHANNEL", nil, index);
			end
		end
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