--[[
  PvP Class Portraits — WoW Forever

  Successor to Simple Class Portraits. Replaces other players' unit-frame
  portraits with class icons only while you are in world PvP or structured PvP.
]]

local ADDON_NAME = ...

local CLASS_TEXTURE = "Interface\\TargetingFrame\\UI-Classes-Circles"

local function InPvPContext()
	local inInstance, instanceType = IsInInstance()
	if inInstance and (instanceType == "pvp" or instanceType == "arena") then
		return true
	end
	return UnitIsPVP("player") or UnitIsPVPFreeForAll("player")
end

local function ApplyClassPortrait(portrait, unit)
	local _, class = UnitClass(unit)
	local coords = class and CLASS_ICON_TCOORDS[class]
	if not coords then
		return
	end
	portrait:SetTexture(CLASS_TEXTURE)
	portrait:SetTexCoord(unpack(coords))
end

hooksecurefunc("UnitFramePortrait_Update", function(self)
	if not self or not self.portrait or not self.unit then
		return
	end

	local unit = self.unit
	if unit == "player" or unit == "pet" then
		return
	end

	if InPvPContext() and UnitIsPlayer(unit) then
		ApplyClassPortrait(self.portrait, unit)
	elseif UnitIsPlayer(unit) then
		-- Restore full texcoords after a class-icon override so faces show correctly.
		self.portrait:SetTexCoord(0, 1, 0, 1)
	else
		self.portrait:SetTexCoord(0, 1, 0, 1)
	end
end)

local function RefreshFrame(frame)
	if frame and frame.unit and frame.portrait then
		UnitFramePortrait_Update(frame)
	end
end

local function RefreshPortraits()
	RefreshFrame(TargetFrame)
	RefreshFrame(FocusFrame)
	RefreshFrame(TargetFrameToT)
	RefreshFrame(FocusFrameToT)

	for i = 1, 4 do
		RefreshFrame(_G["PartyMemberFrame" .. i])
		if PartyFrame then
			RefreshFrame(PartyFrame["MemberFrame" .. i])
		end
	end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
eventFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
eventFrame:RegisterEvent("UPDATE_FACTION")
eventFrame:SetScript("OnEvent", function(_, event, unit)
	if event == "PLAYER_FLAGS_CHANGED" and unit and unit ~= "player" then
		return
	end
	RefreshPortraits()
end)

SLASH_PVPCLASSPORTRAITS1 = "/pcp"
SLASH_PVPCLASSPORTRAITS2 = "/pvpclassportraits"
SlashCmdList.PVPCLASSPORTRAITS = function()
	local active = InPvPContext()
	local inInstance, instanceType = IsInInstance()
	print(string.format(
		"|cff33ff99%s:|r PvP portraits %s (instance=%s/%s, flagged=%s, ffa=%s)",
		ADDON_NAME,
		active and "|cff00ff00ACTIVE|r" or "|cffff0000inactive|r",
		tostring(inInstance),
		tostring(instanceType),
		tostring(UnitIsPVP("player")),
		tostring(UnitIsPVPFreeForAll("player"))
	))
end
