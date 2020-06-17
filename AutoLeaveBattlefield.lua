-- ===============================
--  @自动离开战场，躲避互刷场次
-- ===============================

local AutoLeaveBattlefield = CreateFrame("Frame")
-- AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_GUILD")
-- AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_OFFICER")
AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_RAID")
AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_PARTY")
AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_SAY")
-- AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_BATTLEGROUND")
-- AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_BATTLEGROUND_LEADER")
-- AutoLeaveBattlefield:RegisterEvent("instance_chat")
-- AutoLeaveBattlefield:RegisterEvent("INSTANCE_CHAT")
AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE")
AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE")
AutoLeaveBattlefield:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
AutoLeaveBattlefield:SetScript("OnEvent", function(self,event,...) self["OnEvent"](self,event,...);end)

local Tag = "@" .. UnitName("player"):lower()

local sounds = {"ding","all","notifications\\Europa","notifications\\Ceres"}

local function printHint(event, text, arg2)
  print(event, text, arg2)
end

function AutoLeaveBattlefield:OnEvent(event, text, arg2, ...)
  if text:lower():match(string.lower("OO"))
    then 
      printHint(event, text, arg2)
      if text:lower():match(string.lower("搞错了"))
        then 
          printHint(event, text, arg2)
          if text:lower():match(string.lower("好像"))
            then 
              printHint(event, text, arg2)
              if text:lower():match(string.lower("。。。"))
                then 
                  PlaySoundFile("Interface\\AddOns\\!AutoLeaveBattlefield\\media\\" .. sounds[4] ..".ogg")
                  LeaveBattlefield()
                  printHint(event, text, arg2)
              end
          end
      end
  end
end

-- 关闭聊天时的语言过滤器
-- https://bbs.nga.cn/read.php?&tid=21756775&pid=422231126&to=1

-- if GetLocale() == "zhCN" then
--   ConsoleExec("SET portal \"US\"")
--   ConsoleExec("SET profanityFilter \"0\"")
--   ConsoleExec("SET overrideArchive \"0\"")
-- end
