-- BUTTON SIZES
TukuiDB.buttonsize = TukuiDB.Scale(27)
TukuiDB.buttonspacing = TukuiDB.Scale(2)
TukuiDB.petbuttonsize = TukuiDB.Scale(25)
TukuiDB.petbuttonspacing = TukuiDB.Scale(2)

--BOTTOM FRAME (For Stats)
local bottompanel = CreateFrame("Frame", "TukuiBottomPanel", UIParent)
TukuiDB.CreatePanel(bottompanel, UIParent:GetWidth() + (TukuiDB.mult * 2), 23, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", -TukuiDB.mult, -TukuiDB.mult)
bottompanel:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.mult, -TukuiDB.mult)
bottompanel:SetFrameLevel(1)
TukuiDB.CreateShadow(bottompanel)
bottompanel:SetAlpha(0)

--Battleground Support for Bottom Frame
--if TukuiCF["datatext"].battleground == true then
--	bottompanel:SetScript("OnMouseDown", function(self) ToggleFrame(TukuiInfoBattleGround) end)
--	bottompanel:RegisterEvent("PLAYER_ENTERING_WORLD")
--	bottompanel:RegisterEvent("ZONE_CHANGED_NEW_AREA")
--	bottompanel:SetScript("OnEvent", function(self, event)
--		local inInstance, instanceType = IsInInstance()
--		if (inInstance and (instanceType == "pvp")) then
--			TukuiInfoBattleGround:Show()
--			TukuiBottomPanel:EnableMouse(true)
--		else
--			TukuiInfoBattleGround:Hide()
--			TukuiBottomPanel:EnableMouse(false)
--			end
--	end)
--end

----- [[    Local Variables    ]] -----

local panels = TukuiCF["panels"]
local chat = TukuiCF["chat"]

-- temp -- fucking move this shit later
--if TukuiCF["actionbar"].rightbars_vh then
--	TukuiCF["panels"].tinfowidth = 350
--else
--	TukuiCF["panels"].tinfowidth = (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 11) -- force this if vertical rightbars are disabled so people don't go "OMG ACTION BUTTONS DON'T FIT SIDE/CHAT PANELS"
--end

TukuiDB.infoheight = 19
if TukuiCF["actionbar"].rightbars_vh then
	TukuiDB.infowidth = TukuiCF["chat"].chatwidth
else
	TukuiDB.infowidth = (TukuiDB.buttonsize * 12 + TukuiDB.buttonspacing * 13)
end
TukuiDB.addonwidth = 230


----- [[    Top "Art" Panel    ]] -----

local tbar = CreateFrame("Frame", "TukuiTopBar", UIParent)
TukuiDB.CreatePanel(tbar, (GetScreenWidth() * UIParent:GetEffectiveScale()) * 2, 22, "TOP", UIParent, "TOP", 0, 5)
tbar:SetFrameLevel(0)


----- [[    Bottom "Art" Panel    ]] -----

local bbar = CreateFrame("Frame", "TukuiBottomBar", UIParent)
TukuiDB.CreatePanel(bbar, (GetScreenWidth() * UIParent:GetEffectiveScale()) * 2, 22, "BOTTOM", UIParent, "BOTTOM", 0, -5)
bbar:SetFrameLevel(0)

----- [[    Bottom Data Panel    ]] -----

if TukuiCF["panels"].bottom_panels then
	local dbottom = CreateFrame("Frame", "TukuiDataBottom", UIParent)
	TukuiDB.CreatePanel(dbottom, (TukuiDB.buttonsize * 12 + TukuiDB.buttonspacing * 13), TukuiDB.infoheight, "BOTTOM", UIParent, "BOTTOM", 0, 8)
end

----- [[    Left Data Panel    ]] -----

local dleft = CreateFrame("Frame", "TukuiDataLeft", UIParent)
TukuiDB.CreatePanel(dleft, TukuiDB.infowidth, TukuiDB.infoheight, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 8, 8)


----- [[    Right Data Panel    ]] -----

local dright = CreateFrame("Frame", "TukuiDataRight", UIParent)
TukuiDB.CreatePanel(dright, TukuiDB.infowidth, TukuiDB.infoheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8)


----- [[    Split Bar Data Panels    ]] -----

if TukuiCF["actionbar"].splitbar then
	local leftsd = CreateFrame("Frame", "TukuiLeftSplitBarData", UIParent)
	TukuiDB.CreatePanel(leftsd, (TukuiDB.buttonsize * 3 + TukuiDB.buttonspacing * 4), TukuiDB.infoheight, "RIGHT", TukuiDataBottom, "LEFT", TukuiDB.Scale(-3), 0)

	local rightsd = CreateFrame("Frame", "TukuiRightSplitBarData", UIParent)
	TukuiDB.CreatePanel(rightsd, (TukuiDB.buttonsize * 3 + TukuiDB.buttonspacing * 4), TukuiDB.infoheight, "LEFT", TukuiDataBottom, "RIGHT", TukuiDB.Scale(3), 0)
end
	
----- [[    Left Chat Background and Tabs    ]] -----

--local cleft = CreateFrame("Frame", "TukuiChatLeft", UIParent)
--TukuiDB.CreateFadedPanel(cleft, TukuiCF["panels"].tinfowidth, TukuiCF["chat"].chatheight - 3, "BOTTOM", dleft, "TOP", 0, 3)

--local cltabs = CreateFrame("Frame", "TukuiChatLeftTabs", UIParent)
--TukuiDB.CreateFadedPanel(cltabs, TukuiCF["panels"].tinfowidth, TukuiDB.infoheight + 2, "BOTTOM", cleft, "TOP", 0, 3)


----- [[    Right Chat Background and Tabs    ]] -----

--local cright = CreateFrame("Frame", "TukuiChatRight", UIParent)
--TukuiDB.CreateFadedPanel(cright, TukuiCF["panels"].tinfowidth, TukuiCF["chat"].chatheight - 3, "BOTTOM", dright, "TOP", 0, 3)

--local crtabs = CreateFrame("Frame", "TukuiChatRightTabs", UIParent)
--TukuiDB.CreateFadedPanel(crtabs, TukuiCF["panels"].tinfowidth, TukuiDB.infoheight + 2, "BOTTOM", cright, "TOP", 0, 3)


-- MINIMAP STAT FRAMES
if TukuiMinimap then
	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
	TukuiDB.CreatePanel(minimapstatsleft, ((TukuiMinimap:GetWidth() + 4) / 2) - 2, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))

	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
	TukuiDB.CreatePanel(minimapstatsright, ((TukuiMinimap:GetWidth() + 4) / 2) -2, 19, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
end

-- MAIN ACTION BAR
local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", TukuiDataBottom, "TOP", 0, TukuiDB.Scale(2))
barbg:SetWidth(((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13)))
barbg:SetFrameLevel(bottompanel:GetFrameLevel() + 2)
barbg:SetFrameStrata("LOW")
if TukuiCF["actionbar"].bottomrows == 2 then
	barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
else
	barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
end

--SPLIT BAR PANELS
if TukuiCF["actionbar"].splitbar == true then
	local splitleft = CreateFrame("Frame", "TukuiSplitActionBarLeftBackground", TukuiActionBarBackground)
	TukuiDB.CreatePanel(splitleft, (TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4), TukuiActionBarBackground:GetHeight(), "RIGHT", TukuiActionBarBackground, "LEFT", TukuiDB.Scale(-3), 0)
	splitleft:SetFrameLevel(TukuiActionBarBackground:GetFrameLevel())
	splitleft:SetFrameStrata(TukuiActionBarBackground:GetFrameStrata())
	
	local splitright = CreateFrame("Frame", "TukuiSplitActionBarRightBackground", TukuiActionBarBackground)
	TukuiDB.CreatePanel(splitright, (TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4), TukuiActionBarBackground:GetHeight(), "LEFT", TukuiActionBarBackground, "RIGHT", TukuiDB.Scale(3), 0)
	splitright:SetFrameLevel(TukuiActionBarBackground:GetFrameLevel())
	splitright:SetFrameStrata(TukuiActionBarBackground:GetFrameStrata())
end

-- RIGHT BAR
--if TukuiCF["actionbar"].enable == true then
--	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
--	TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(-8))
--	if TukuiCF["actionbar"].rightbars == 1 then
--		barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
--	elseif TukuiCF["actionbar"].rightbars == 2 then
--		barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
--	elseif TukuiCF["actionbar"].rightbars == 3 then
--		barbgr:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
--	else
--		barbgr:Hide()
--	end
--
--	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
--	if TukuiCF["actionbar"].rightbars > 0 then
--		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", barbgr, "LEFT", TukuiDB.Scale(-6), 0)
--	else
--		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-6), TukuiDB.Scale(-13.5))
--	end
--	
--	local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
--	TukuiDB.CreatePanel(ltpetbg1, 30, 265, "LEFT", petbg, "RIGHT", 0, 0)
--	ltpetbg1:SetFrameLevel(0)
--	ltpetbg1:SetAlpha(.8)
--end

-- CHAT BACKGROUND LEFT
local chatlbgdummy = CreateFrame("Frame", "ChatLBackground", UIParent)
chatlbgdummy:SetWidth(TukuiDB.infowidth)
chatlbgdummy:SetHeight(TukuiCF["chat"].chatheight+6)
chatlbgdummy:SetPoint("BOTTOM", TukuiDataLeft, "TOP", 0,  TukuiDB.Scale(2))

-- CHAT BACKGROUND RIGHT
local chatrbgdummy = CreateFrame("Frame", "ChatRBackground", UIParent)
chatrbgdummy:SetWidth(TukuiDB.infowidth)
chatrbgdummy:SetHeight(TukuiCF["chat"].chatheight+6)
chatrbgdummy:SetPoint("BOTTOM", TukuiDataRight, "TOP", 0,  TukuiDB.Scale(2))

-- EDITBOX BACKGROUND LEFT
local editlbgdummy = CreateFrame("Frame", "EditLBackground", UIParent)
editlbgdummy:SetWidth(TukuiDB.infowidth)
editlbgdummy:SetHeight(TukuiDataBottom:GetHeight())
editlbgdummy:SetPoint("BOTTOM", ChatLBackground, "TOP", 0,  TukuiDB.Scale(4))

-- EDITBOX BACKGROUND RIGHT
--local editrbgdummy = CreateFrame("Frame", "EditRBackground", UIParent)
--editrbgdummy:SetWidth(TukuiCF["chat"].chatwidth)
--editrbgdummy:SetHeight(TukuiDataBottom:GetHeight())
--editrbgdummy:SetPoint("BOTTOM", ChatRBackground, "TOP", 0,  TukuiDB.Scale(4))

-- CHAT BACKGROUND UP LEFT
local chatulbgdummy = CreateFrame("Frame", "ChatULBackground", UIParent)
chatulbgdummy:SetWidth(TukuiDB.infowidth
)
chatulbgdummy:SetHeight(TukuiCF["chat"].chatheight+6)
chatulbgdummy:SetPoint("BOTTOM", EditLBackground, "TOP", 0,  TukuiDB.Scale(4))

local rightbbg = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
rightbbg:SetPoint("BOTTOMRIGHT", ChatRBackground, "TOPRIGHT", TukuiDB.Scale(-3), TukuiDB.Scale(3))
if TukuiCF["actionbar"].rightbars_vh then
	TukuiDB.CreatePanel(rightbbg, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-8), 0)
	rightbbg:SetHeight((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].rightbars == 1 then
		rightbbg:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].splitbar and TukuiCF["actionbar"].rightbars == 2 then
		rightbbg:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	elseif not TukuiCF["actionbar"].splitbar and TukuiCF["actionbar"].rightbars == 3 then
		rightbbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	else
		rightbbg:Hide()
	end
else
	TukuiDB.CreatePanel(rightbbg, 1, 1, "BOTTOMRIGHT", ChatRBackground, "TOPRIGHT", 0, TukuiDB.Scale(3))
	rightbbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].rightbars == 1 then
		rightbbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].splitbar and TukuiCF["actionbar"].rightbars == 2 then
		rightbbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 2))
	elseif not TukuiCF["actionbar"].splitbar and TukuiCF["actionbar"].rightbars == 3 then
		rightbbg:SetHeight((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 3))
	else
		rightbbg:Hide()
	end
end

local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
if TukuiCF["actionbar"].rightbars_vh then
	if TukuiCF["actionbar"].rightbars > 0 then
		TukuiDB.CreatePanel(petbg, 1, 1, "BOTTOMRIGHT", TukuiActionBarBackgroundRight, "BOTTOMLEFT", TukuiDB.Scale(-3), 0)
	else
		TukuiDB.CreatePanel(petbg, 1, 1, "BOTTOMRIGHT", ChatRBackground, "TOPRIGHT", 0, TukuiDB.Scale(3))
	end
	
	petbg:SetWidth((TukuiDB.petbuttonsize) + (TukuiDB.buttonspacing * 2))
	petbg:SetHeight((TukuiDB.petbuttonsize * NUM_PET_ACTION_SLOTS) + (TukuiDB.buttonspacing * 11))

	if TukuiCF["actionbar"].rightbars > 0 then
		petbg:SetPoint("BOTTOMRIGHT", rightbbg, "BOTTOMLEFT", -3, 0)
	else
		petbg:SetPoint("BOTTOMRIGHT", ChatRBackground, "TOPRIGHT", 0, 3)
	end
else
	if TukuiCF["actionbar"].rightbars > 0 then
		TukuiDB.CreatePanel(petbg, 1, 1, "BOTTOMRIGHT", TukuiActionBarBackgroundRight, "TOPRIGHT", 0, TukuiDB.Scale(3))
	else
		TukuiDB.CreatePanel(petbg, 1, 1, "BOTTOMRIGHT", ChatRBackground, "TOPRIGHT", 0, TukuiDB.Scale(3))
	end
	petbg:SetWidth((TukuiDB.petbuttonsize * NUM_PET_ACTION_SLOTS) + (TukuiDB.buttonspacing * 11))
	petbg:SetHeight((TukuiDB.petbuttonsize) + (TukuiDB.buttonspacing * 2))

	if TukuiCF["actionbar"].rightbars > 0 then
		petbg:SetPoint("BOTTOMRIGHT", rightbbg, "TOPRIGHT", 0, 3)
	else
		petbg:SetPoint("BOTTOMRIGHT", ChatRBackground, "TOPRIGHT", 0, 3)
	end
end


--Create Template frame for addon embedding
--if TukuiCF["actionbar"].rightbars_vh then
--	local rdummyframe = CreateFrame("Frame", "RDummyFrame", UIParent)
--	rdummyframe:SetWidth(TukuiDB.infowidth - TukuiActionBarBackgroundRight:GetWidth() - TukuiPetActionBarBackground:GetWidth() - TukuiDB.Scale(6))
--	rdummyframe:SetHeight(TukuiCF["chat"].chatheight+6)
--	if TukuiCF["actionbar"].rightbars > 0 then
--		rdummyframe:SetPoint("BOTTOMRIGHT", TukuiPetActionBarBackground, "BOTTOMLEFT", TukuiDB.Scale(-3), 0)
--	else
--		rdummyframe:SetPoint("BOTTOMRIGHT", TukuiPetActionBarBackground, "BOTTOMLEFT", TukuiDB.Scale(-7), 0)
--	end
--else
--	local rdummyframe = CreateFrame("Frame", "RDummyFrame", UIParent)
--	rdummyframe:SetWidth(petbg:GetWidth())
--	rdummyframe:SetHeight(TukuiCF["chat"].chatheight+6)
--	rdummyframe:SetPoint("BOTTOMRIGHT", TukuiPetActionBarBackground, "TOPRIGHT", 0,  TukuiDB.Scale(3))
-- 
--end
local rdummyframe = CreateFrame("Frame", "RDummyFrame", UIParent)
rdummyframe:SetWidth(TukuiDB.addonwidth)
rdummyframe:SetHeight(TukuiCF["chat"].chatheight)
rdummyframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", TukuiDB.buttonsize + TukuiDB.Scale(10) ,  -(TukuiDB.infoheight + TukuiDB.Scale(11)))

local omendummyframe = CreateFrame("Frame", "OmenDummyFrame", UIParent)
omendummyframe:SetWidth(TukuiDB.addonwidth)
omendummyframe:SetHeight(TukuiCF["chat"].chatheight)
omendummyframe:SetPoint("TOPLEFT", RDummyFrame, "BOTTOMLEFT", 0, TukuiDB.Scale(-1))



TukuiDB.ChatRightShown = false
if TukuiCF["chat"].showbackdrop == true then
	local chatlbg = CreateFrame("Frame", nil, GeneralDockManager)
	chatlbg:SetAllPoints(chatlbgdummy)
	TukuiDB.SetTemplate(chatlbg)
	chatlbg:SetFrameStrata("BACKGROUND")
	chatlbg:SetFrameLevel(0)
	chatlbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
	
	local chatrbg = CreateFrame("Frame", nil, GeneralDockManager)
	chatrbg:SetAllPoints(chatrbgdummy)
	TukuiDB.SetTemplate(chatrbg)
	chatrbg:SetFrameStrata("BACKGROUND")
	chatrbg:SetFrameLevel(0)
	chatrbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
	
	local chatulbg = CreateFrame("Frame", nil, GeneralDockManager)
	chatulbg:SetAllPoints(chatulbgdummy)
	TukuiDB.SetTemplate(chatulbg)
	chatulbg:SetFrameStrata("BACKGROUND")
	chatulbg:SetFrameLevel(0)
	chatulbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
	
	local editlbg = CreateFrame("Frame", nil, GeneralDockManager)
	editlbg:SetAllPoints(editlbgdummy)
	TukuiDB.SetTemplate(editlbg)
	editlbg:SetFrameStrata("BACKGROUND")
	editlbg:SetFrameLevel(0)
	editlbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
	
--	local editrbg = CreateFrame("Frame", nil, GeneralDockManager)
--	editrbg:SetAllPoints(editrbgdummy)
--	TukuiDB.SetTemplate(editrbg)
--	editrbg:SetFrameStrata("BACKGROUND")
--	editrbg:SetFrameLevel(0)
--	editrbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
end



--This was requested a lot.. and probably is a better way to do this but whatever this will work.
--local chatrbg = CreateFrame("Frame", nil, GeneralDockManager)
--chatrbg:SetAllPoints(rdummyframe)
--TukuiDB.SetTemplate(chatrbg)
--chatrbg:SetFrameStrata("BACKGROUND")
--chatrbg:SetFrameLevel(0)
--chatrbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
--chatrbg:SetAlpha(0)
--local t = 0
--chatrbg:SetScript("OnUpdate", function(self, elapsed)
--	t = t + 1
--	if t == 30 then
--		for i = 1, NUM_CHAT_WINDOWS do
--			local chat = _G[format("ChatFrame%s", i)]
--			local id = chat:GetID()
--			local point = GetChatWindowSavedPosition(id)
--			local _, _, _, _, _, _, _, _, docked, _ = GetChatWindowInfo(id)
--			
--			if point == "BOTTOMRIGHT" and chat:IsShown() and docked == nil then
--				if TukuiCF["chat"].showbackdrop == true then
--					chatrbg:SetAlpha(1)
--				end
--				TukuiDB.ChatRightShown = true
--				break
--			else
--				if TukuiCF["chat"].showbackdrop == true then
--					chatrbg:SetAlpha(0)
--				end
--				TukuiDB.ChatRightShown = false
--			end
--		end
--		t = 0
--	end
--end)

-- BATTLEGROUND STATS FRAME
--if TukuiCF["datatext"].battleground == true then
--	local bgframe = CreateFrame("Frame", "TukuiInfoBattleGround", UIParent)
--	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
--	bgframe:SetAllPoints(TukuiBottomPanel)
--	bgframe:SetFrameLevel(TukuiBottomPanel:GetFrameLevel() + 1)
--	bgframe:SetFrameStrata("LOW")
--	bgframe:SetBackdrop({
--	  bgFile = TukuiCF["media"].normTex, 
--	  edgeFile = TukuiCF["media"].blank, 
--	  tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
--	  insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult}
--	})
--	bgframe:SetBackdropColor(unpack(TukuiCF["media"].bordercolor))
--	bgframe:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
--	bgframe:SetScript("OnEnter", function(self)
--		local numScores = GetNumBattlefieldScores()
--		for i=1, numScores do
--			local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
--			if name then
--				if name == TukuiDB.myname then
--					local color = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
--					local classcolor = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
--					GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
--					GameTooltip:ClearLines()
--					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttstatsfor, classcolor..name.."|r")
--					GameTooltip:AddLine' '
--					--Add extra statistics to watch based on what BG you are in.
--					if GetRealZoneText() == "Arathi Basin" then --
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
--					elseif GetRealZoneText() == "Warsong Gulch" then --
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagsreturned,GetBattlefieldStatData(i, 2),1,1,1)
--					elseif GetRealZoneText() == "Eye of the Storm" then --
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
--					elseif GetRealZoneText() == "Alterac Valley" then
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_graveyardsassaulted,GetBattlefieldStatData(i, 1),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_graveyardsdefended,GetBattlefieldStatData(i, 2),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_towersassaulted,GetBattlefieldStatData(i, 3),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_towersdefended,GetBattlefieldStatData(i, 4),1,1,1)
--					elseif GetRealZoneText() == "Strand of the Ancients" then
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_demolishersdestroyed,GetBattlefieldStatData(i, 1),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_gatesdestroyed,GetBattlefieldStatData(i, 2),1,1,1)
--					elseif GetRealZoneText() == "Isle of Conquest" then
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
--						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
--					end			
--					GameTooltip:Show()
--				end
--			end
--		end
--	end) 
--
--	bgframe:SetScript("OnMouseDown", function(self) ToggleFrame(TukuiInfoBattleGround) end)
--	bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
--	bgframe:RegisterEvent("PLAYER_ENTERING_WORLD")
--	bgframe:RegisterEvent("ZONE_CHANGED_NEW_AREA")
--	bgframe:SetScript("OnEvent", function(self, event)
--		local inInstance, instanceType = IsInInstance()
--		if (inInstance and (instanceType == "pvp")) then
--			bgframe:Show()
--			TukuiBottomPanel:EnableMouse(true)
--		else
--			bgframe:Hide()
--			TukuiBottomPanel:EnableMouse(false)
--		end
--	end)
--end

local ileft = CreateFrame("Frame", "TukuiInfoLeft", barbg)
local iright = CreateFrame("Frame", "TukuiInfoRight", barbg)

--BATTLEGROUND STATS FRAME
if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(dleft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end

