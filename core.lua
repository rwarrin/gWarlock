-------------------- CONFIG --------------------

local VALUE_HEALTHPERCENT = 25;

local MESSAGE_ALERT_HEALTHWARNING = ">>> TARGET HEALTH IS BELOW ".. VALUE_HEALTHPERCENT .. "% USE DRAIN SOUL <<<";
local MESSAGE_ALERT_DRAINSOULTICK = ">>> DRAIN SOUL TICK <<<";

local MESSAGE_COLOR = {r = 1.0, g = 0.0, b = 1.0};

local SOUND_ALERT_HEALTHWARNING = "Interface\\AddOns\\gWarlock\\Media\\warn.mp3";
local SOUND_ALERT_DRAINSOULTICK = "Interface\\AddOns\\gWarlock\\Media\\tick.mp3";

------------------------------------------------

local function OnEvent(self, event, ...)

end

-- Create Frame
gWarlock = CreateFrame("Frame", "gWarlock", nil);
gWarlock:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
gWarlock:RegisterEvent("UNIT_HEALTH");
gWarlock:SetScript("OnEvent", OnEvent);
