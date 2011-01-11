-------------------- CONFIG --------------------

local VALUE_HEALTHPERCENT = 25;

local MESSAGE_ALERT_HEALTHWARNING = ">>> TARGET HEALTH IS BELOW ".. VALUE_HEALTHPERCENT .. "% USE DRAIN SOUL <<<";
local MESSAGE_ALERT_DRAINSOULTICK = ">>> DRAIN SOUL  %d<<<";

local COLOR_CHAT_MESSAGE = {1.0, 0.0, 1.0};
local COLOR_RAID_MESSAGE = {r = 1.0, g = 0.0, b = 1.0};

local SOUND_ALERT_HEALTHWARNING = "Interface\\AddOns\\gWarlock\\Media\\warn.mp3";
local SOUND_ALERT_DRAINSOULTICK = "Interface\\AddOns\\gWarlock\\Media\\tick.mp3";

------------------------------------------------

local EnemyHealthWarned = false;

local function OnEvent(self, event, ...)
	if(event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local timeStamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, amount, overkill = ...;
		
		if(sourceName == UnitName("player")) then
			if(eventType == "SPELL_PERIODIC_DAMAGE") then
				if(spellID == 1120) then
					local message = MESSAGE_ALERT_DRAINSOULTICK:format(amount);
					PlaySoundFile(SOUND_ALERT_DRAINSOULTICK);
					DEFAULT_CHAT_FRAME:AddMessage(message, unpack(COLOR_CHAT_MESSAGE));
					RaidNotice_AddMessage(RaidWarningFrame, message, COLOR_RAID_MESSAGE);
				end
			end
		end
	end
	
	
	
end

-- Create Frame
gWarlock = CreateFrame("Frame", "gWarlock", nil);
gWarlock:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
gWarlock:RegisterEvent("UNIT_HEALTH");
gWarlock:SetScript("OnEvent", OnEvent);


