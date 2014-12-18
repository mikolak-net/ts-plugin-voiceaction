--
-- VoiceAction initialisation
--

require("ts3init")            -- Required for ts3RegisterModule
require("voiceaction/events")  -- Forwarded TeamSpeak 3 callbacks

local MODULE_NAME = "voiceaction"

--TODO: add menu support
local registeredEvents = {
	onConnectStatusChangeEvent = voiceaction_events.onConnectStatusChangeEvent,
	onTalkStatusChangeEvent = voiceaction_events.onTalkStatusChangeEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)
