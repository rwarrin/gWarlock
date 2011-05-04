-------------------- CONFIG --------------------

local OUTPUT_CHATMESSAGE_FRAME = true;
local OUTPUT_RAIDWARNING_FRAME = true;

local VALUE_HEALTHPERCENT = 25;

local MESSAGE_ALERT_HEALTHWARNING = ">>> TARGET HEALTH IS BELOW ".. VALUE_HEALTHPERCENT .. "% USE DRAIN SOUL <<<";
local MESSAGE_ALERT_DRAINSOULTICK = ">>> Drain Soul  (%d) <<<";

local COLOR_CHAT_MESSAGE = {186/255, 149/255, 222/255}; --  Defaults: {186/255, 149/255, 222/255};
local COLOR_RAID_MESSAGE = {r = 186/255, g = 149/255, b = 222/255}; --  Defualts{r = 186/255, g = 149/255, b = 222/255};

local SOUND_ALERT_HEALTHWARNING = "Interface\\AddOns\\gWarlock\\Media\\warn.mp3";
local SOUND_ALERT_DRAINSOULTICK = "Interface\\AddOns\\gWarlock\\Media\\tick.mp3";

------------------------------------------------

local EnemyHealthWarned = false;

local function OnEvent(self, event, ...)
	if(event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local timeStamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, amount, overkill = ...;
		
		if(sourceName == UnitName("player")) then
			if(eventType == "SPELL_PERIODIC_DAMAGE") then
				if(spellID == 1120) then
					local message = MESSAGE_ALERT_DRAINSOULTICK:format(amount);
					PlaySoundFile(SOUND_ALERT_DRAINSOULTICK);
					if(OUTPUT_CHATMESSAGE_FRAME == true) then DEFAULT_CHAT_FRAME:AddMessage(message, unpack(COLOR_CHAT_MESSAGE)); end
					if(OUTPUT_RAIDWARNING_FRAME == true) then RaidNotice_AddMessage(RaidWarningFrame, message, COLOR_RAID_MESSAGE); end
				end
			end
		end
	end
	
	if(event == "UNIT_HEALTH") then
		if(EnemyHealthWarned == false and UnitIsEnemy("player", "target")) then
			if(UnitIsDead("target") == nil) then
				if(UnitLevel("target") >= (UnitLevel("player") - 5)) then
					if(((UnitHealth("target") / UnitHealthMax("target")) * 100) <= VALUE_HEALTHPERCENT) then
						PlaySoundFile(SOUND_ALERT_HEALTHWARNING);
						if(OUTPUT_CHATMESSAGE_FRAME == true) then DEFAULT_CHAT_FRAME:AddMessage(MESSAGE_ALERT_HEALTHWARNING, unpack(COLOR_CHAT_MESSAGE)); end
						if(OUTPUT_RAIDWARNING_FRAME == true) then RaidNotice_AddMessage(RaidWarningFrame, MESSAGE_ALERT_HEALTHWARNING, COLOR_RAID_MESSAGE); end
						EnemyHealthWarned = true;
					end
				end
			end
		end
	end
	
	if(event == "PLAYER_TARGET_CHANGED") then
		EnemyHealthWarned = false;
	end
end

-- Create Frame
gWarlock = CreateFrame("Frame", "gWarlock", nil);
gWarlock:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
gWarlock:RegisterEvent("UNIT_HEALTH");
gWarlock:RegisterEvent("PLAYER_TARGET_CHANGED");
gWarlock:SetScript("OnEvent", OnEvent);