--
-- Voicemodule callback functions
--
--

--CONFIGURATION START
local commandSomeoneTalking = "ENTER COMMAND HERE"

local commandNobodyTalking = nil --leave for same command as above - or replace

--CONFIGURATION END

--stores the current talk status on channel
local talkers = {}


local function isSomeoneTalking()
  talkStatus = 0
  for k in pairs(talkers) do talkStatus=talkStatus+talkers[k] end
  return talkStatus > 0
end

local function getCommand()
  if commandNobodyTalking == nil or isSomeoneTalking() then     
    return commandSomeoneTalking 
  else
    return commandNobodyTalking
  end
end

local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
    --clear out talker status
    talkers = {}
    --TODO: clear talker status on channel change
    --TODO: check talker status, if someone is talking mute immediately (maybe it's already happening)
    --TODO: fire event action if applicable, fold code from onTalkStatusChange and only customize talker change closures
end

local function onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
    previousTalk = isSomeoneTalking()
    
    talkers[clientID] = status
    
    currentTalk = isSomeoneTalking()
    
    print("VoiceAction: Change: ".. tostring(currentTalk ~= previousTalk))
    
    if currentTalk ~= previousTalk then 
      os.execute(getCommand()) 
    end
end


voiceaction_events = {
	onConnectStatusChangeEvent = onConnectStatusChangeEvent,
	onTalkStatusChangeEvent = onTalkStatusChangeEvent
}
