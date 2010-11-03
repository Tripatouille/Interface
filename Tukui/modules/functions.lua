function TukuiDB.UIScale()
	if TukuiCF["general"].autoscale == true then
		-- i'm putting a autoscale feature mainly for an easy auto install process
		-- we all know that it's not very effective to play via 1024x768 on an 0.64 uiscale :P
		-- with this feature on, it should auto choose a very good value for your current reso!
		if TukuiCF["general"].autoscale ~= true then return end
		TukuiCF["general"].uiscale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
	end
end
TukuiDB.UIScale()

-- pixel perfect script of custom ui scale.
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/TukuiCF["general"].uiscale
local function scale(x)
    return mult*math.floor(x/mult+.5)
end

function TukuiDB.Scale(x) return scale(x) end
TukuiDB.mult = mult

----- [[    Skin    ]] -----

function TukuiDB.SkinPanel(f)
	f:SetBackdrop(textures.normbg)
	f:SetBackdropColor(unpack(media.backdropcolor))
	f:SetBackdropBorderColor(unpack(media.bordercolor))
	
	TukuiDB.StyleOverlay(f)
	TukuiDB.StyleShadow(f)
end

function TukuiDB.SkinFadedPanel(f)
	f:SetBackdrop(textures.fadebg)
	f:SetBackdropColor(unpack(media.fadedbackdropcolor))
	f:SetBackdropBorderColor(unpack(media.bordercolor))

	TukuiDB.StyleShadow(f)
	TukuiDB.StyleInnerBorder(f)
	TukuiDB.StyleOuterBorder(f)
end


function TukuiDB.CreatePanel(f, w, h, a1, p, a2, x, y)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile = TukuiCF["media"].blank, 
	  edgeFile = TukuiCF["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
	if TukuiCF["general"].classcolortheme == true then
		f:SetBackdropBorderColor(r, g, b)
	else
		f:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
	end
end

-- setup shadow border texture.
local shadows = {
	edgeFile = TukuiCF["media"].glowTex, 
	edgeSize = 3.7,
	insets = { left = mult, right = mult, top = mult, bottom = mult }
}

-- create shadow frame
function TukuiDB.CreateShadow(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -3.7, 3.7)
	shadow:SetPoint("BOTTOMRIGHT", 3.7, -3.7)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(0, 0, 0, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, .75)
	f.shadow = shadow
	return shadow
end

function TukuiDB.SetTemplate(f)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	f:SetBackdrop({
	  bgFile = TukuiCF["media"].blank, 
	  edgeFile = TukuiCF["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
	if TukuiCF["general"].classcolortheme == true then
		f:SetBackdropBorderColor(r, g, b)
	else
		f:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
	end
end

function TukuiDB.Kill(object)
	object.Show = TukuiDB.dummy
	object:Hide()
end

function round(number, decimals)
    return (("%%.%df"):format(decimals)):format(number)
end


function RGBPercToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

--Set Datatext Postitions
--function TukuiDB.PP(p, obj)
--	local x = TukuiDB.Scale(((UIParent:GetWidth() / 3) / 3))
--	if p == 1 then
--		obj:SetHeight(TukuiBottomPanel:GetHeight())
--		obj:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", (x*p)-x/2, -TukuiDB.mult)
--	elseif p == 2 then
--		obj:SetHeight(TukuiBottomPanel:GetHeight())
--		obj:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", (x*p)-x/2, -TukuiDB.mult)
--	elseif p == 3 then
--		obj:SetHeight(TukuiBottomPanel:GetHeight())
--		obj:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", (x*p)-x/2, -TukuiDB.mult)
--	elseif p == 4 then
--		obj:SetHeight(TukuiBottomPanel:GetHeight())
--		local p = 6 --Swap these so its like how its always been..
--		obj:SetPoint("BOTTOM", UIParent,"BOTTOMRIGHT", -(x*(p-3))+x/2, -TukuiDB.mult)
--	elseif p == 5 then
--		obj:SetHeight(TukuiBottomPanel:GetHeight())
--		obj:SetPoint("BOTTOM", UIParent,"BOTTOMRIGHT", -(x*(p-3))+x/2, -TukuiDB.mult)
--	elseif p == 6 then
--		obj:SetHeight(TukuiBottomPanel:GetHeight())
--		local p = 4 --Swap these so its like how its always been..
--		obj:SetPoint("BOTTOM", UIParent,"BOTTOMRIGHT", -(x*(p-3))+x/2, -TukuiDB.mult)
--	end
--	
--	if TukuiMinimap then
--		if p == 7 then
--			obj:SetHeight(TukuiMinimapStatsLeft:GetHeight())
--			obj:SetPoint("CENTER", TukuiMinimapStatsLeft, 0, 0)
--		elseif p == 8 then
--			obj:SetHeight(TukuiMinimapStatsRight:GetHeight())
--			obj:SetPoint("CENTER", TukuiMinimapStatsRight, 0, 0)
--		end
--	end
--end

-- Return true if the talent matching the name of the spell given by (Credit Pitbull4)
-- spellid has at least one point spent in it or false otherwise
function CheckForKnownTalent(spellid)
	local wanted_name = GetSpellInfo(spellid)
	if not wanted_name then return nil end
	local num_tabs = GetNumTalentTabs()
	for t=1, num_tabs do
		local num_talents = GetNumTalents(t)
		for i=1, num_talents do
			local name_talent, _, _, _, current_rank = GetTalentInfo(t,i)
			if name_talent and (name_talent == wanted_name) then
				if current_rank and (current_rank > 0) then
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

--Check Player's Role
local RoleUpdater = CreateFrame("Frame")
local function CheckRole(self, event, unit)
	local resilience
	if GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)*0.02828 > GetDodgeChance() then
		resilience = true
	else
		resilience = false
	end
	--print(dodge, resil)
	if ((TukuiDB.myclass == "PALADIN" and GetPrimaryTalentTree() == 2) or 
	(TukuiDB.myclass == "WARRIOR" and GetPrimaryTalentTree() == 3) or 
	(TukuiDB.myclass == "DEATHKNIGHT" and GetPrimaryTalentTree() == 1)) and
	resilience == false or
	--Check for 'Thick Hide' tanking talent
	(TukuiDB.myclass == "DRUID" and GetPrimaryTalentTree() == 2 and GetBonusBarOffset() == 3) then
		TukuiDB.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if ((playerap > playerint) or (playeragi > playerint)) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139))) then
			TukuiDB.Role = "Melee"
		else
			TukuiDB.Role = "Caster"
		end
	end
end	
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", CheckRole)
CheckRole()

if IsAddOnLoaded("Recount") then
	if (TukuiCF["general"].recountscript == 1 or TukuiCF["general"].recountscript == 2) and IsAddOnLoaded("Recount") then
		local recounttoggler = CreateFrame("Frame", nil, UIParent)
		local function OnEvent()
		local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "raid" or instanceType == "party") then
					if TukuiCF["general"].recountscript == 1 then
						if InCombatLockdown() then
							Recount_MainWindow:Show()
						end
					elseif TukuiCF["general"].recountscript == 2 then
						if InCombatLockdown() then
							Recount_MainWindow:Hide()
						else
							Recount_MainWindow:Show()
						end				
					end
			end
		end
		recounttoggler:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		recounttoggler:RegisterEvent("PLAYER_ENTERING_WORLD")
		recounttoggler:RegisterEvent("PLAYER_REGEN_ENABLED")
		recounttoggler:RegisterEvent("PLAYER_REGEN_DISABLED")
		recounttoggler:SetScript("OnEvent", OnEvent)
	end
end

------------------------------------------------------------------------
--	ActionBar Functions
------------------------------------------------------------------------
-- styleButton function authors are Chiril & Karudon.
function TukuiDB.StyleButton(b, checked) 
    local name = b:GetName()

    local button          = _G[name]
    local icon            = _G[name.."Icon"]
    local count           = _G[name.."Count"]
    local border          = _G[name.."Border"]
    local hotkey          = _G[name.."HotKey"]
    local cooldown        = _G[name.."Cooldown"]
    local nametext        = _G[name.."Name"]
    local flash           = _G[name.."Flash"]
    local normaltexture   = _G[name.."NormalTexture"]
	local icontexture	  = _G[name.."IconTexture"]
 
    local hover = b:CreateTexture("frame", nil, self) -- hover
    hover:SetTexture(1,1,1,0.3)
    hover:SetHeight(button:GetHeight())
    hover:SetWidth(button:GetWidth())
    hover:SetPoint("TOPLEFT",button,2,-2)
    hover:SetPoint("BOTTOMRIGHT",button,-2,2)
    button:SetHighlightTexture(hover)
 
    local pushed = b:CreateTexture("frame", nil, self) -- pushed
    pushed:SetTexture(0.1,0.1,0.1,0.5)
    pushed:SetHeight(button:GetHeight())
    pushed:SetWidth(button:GetWidth())
    pushed:SetPoint("TOPLEFT",button,2,-2)
    pushed:SetPoint("BOTTOMRIGHT",button,-2,2)
    button:SetPushedTexture(pushed)
	
	if checked then
		local checked = b:CreateTexture("frame", nil, self) -- checked
		checked:SetTexture(1,1,1,0.3)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:SetPoint("TOPLEFT",button,2,-2)
		checked:SetPoint("BOTTOMRIGHT",button,-2,2)
		button:SetCheckedTexture(checked)
	end
		
	if cooldown then
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)	
	end
end

function TukuiDB.TukuiPetBarUpdate(self, event)
	local petActionButton, petActionIcon, petAutoCastableTexture, petAutoCastShine
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		petActionButton = _G[buttonName]
		petActionIcon = _G[buttonName.."Icon"]
		petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		
		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end
		
		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext

		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(petActionButton)
			end
		else
			petActionButton:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(petActionButton)
			end			
		end
		
		if autoCastAllowed then
			petAutoCastableTexture:Show()
		else
			petAutoCastableTexture:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(petAutoCastShine)
		else
			AutoCastShine_AutoCastStop(petAutoCastShine)
		end
		
		-- grid display
		if name then
			if not TukuiCF["actionbar"].showgrid then
				petActionButton:SetAlpha(1)
			end			
		else
			if not TukuiCF["actionbar"].showgrid then
				petActionButton:SetAlpha(0)
			end
		end
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(petActionIcon, nil)
			else
				SetDesaturation(petActionIcon, 1)
			end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end
		
		-- between level 1 and 10 on cata, we don't have any control on Pet. (I lol'ed so hard)
		-- Setting desaturation on button to true until you learn the control on class trainer.
		-- you can at least control "follow" button.
		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetChecked(0)
		end
	end
end

function TukuiDB.TukuiShiftBarUpdate()
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = _G["ShapeshiftButton"..i]
		icon = _G["ShapeshiftButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)
			
			cooldown = _G["ShapeshiftButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if isActive then
				ShapeshiftBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

if not TukuiCF["unitframes"].enable == true and not TukuiCF["raidframes"].enable == true then return end
------------------------------------------------------------------------
--	UnitFrame Functions
------------------------------------------------------------------------
local SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup("Flash")
	self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
	self.anim.fadein:SetChange(1)
	self.anim.fadein:SetOrder(2)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetChange(-1)
	self.anim.fadeout:SetOrder(1)
end

local Flash = function(self, duration)
	if not self.anim then
		SetUpAnimGroup(self)
	end

	self.anim.fadein:SetDuration(duration)
	self.anim.fadeout:SetDuration(duration)
	self.anim:Play()
end

local StopFlash = function(self)
	if self.anim then
		self.anim:Finish()
	end
end

function TukuiDB.SpawnMenu(self)
	local unit = self.unit:gsub("(.)", string.upper, 1)
	if self.unit == "targettarget" then return end
	if _G[unit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
	elseif (self.unit:match("party")) then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
	end
end

function TukuiDB.PostUpdatePower(element, unit, min, max)
	element:GetParent().Health:SetHeight(max ~= 0 and 20 or 22)
end

TukuiDB.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

local ShortValueNegative = function(v)
	if v <= 999 then return v end
	if v >= 1000000 then
		local value = string.format("%.1fm", v/1000000)
		return value
	elseif v >= 1000 then
		local value = string.format("%.1fk", v/1000)
		return value
	end
end

TukuiDB.AuraFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)	
	local inInstance, instanceType = IsInInstance()
	icon.owner = caster
	if unit == "target" then
		if TukuiCF["auras"].playerdebuffsonly == true then
			-- Show all debuffs on friendly targets
			if UnitIsFriend("player", "target") then return true end
			
			local isPlayer
			
			if(caster == 'player' or caster == 'vehicle') then
				isPlayer = true
			else
				isPlayer = false
			end

			if isPlayer then
				return true
			elseif DebuffWhiteList[name] or (inInstance and ((instanceType == "pvp" or instanceType == "arena") and TargetPVPOnly[name])) then
				return true
			else
				return false
			end
		else
			return true
		end
	else
		if unit ~= "player" and unit ~= "targettarget" and unit ~= "focus" and TukuiCF["auras"].arenadebuffs == true and inInstance and (instanceType == "pvp" or instanceType == "arena") then
			if DebuffWhiteList[name] or TargetPVPOnly[name] then
				return true
			else
				return false
			end
		else
			if DebuffBlacklist[name] then
				return false
			else
				return true
			end
		end
	end
end

TukuiDB.ArenaBuffFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	if ArenaBuffWhiteList[name] then
		return true
	else
		return false
	end
end

TukuiDB.ArenaDebuffFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	if DebuffWhiteList[name] then
		return true
	else
		return false
	end	
end

TukuiDB.HealerFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)
	local inInstance, instanceType = IsInInstance()
	
	if inInstance and (instanceType == "pvp" or instanceType == "arena") then
		if DebuffWhiteList[name] or TargetPVPOnly[name] then
			return true
		else
			return false
		end
	else
		if DebuffHealerWhiteList[name] then
			return true
		else
			return false
		end
	end

end


TukuiDB.PostUpdateHealth = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_offline.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_dead.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_ghost.."|r")
		end
	else
		if min ~= max then
			local r, g, b
			r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				if TukuiCF["unitframes"].showtotalhpmp == true then
					health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", ShortValue(min), ShortValue(max))
				else
					health.value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			elseif unit == "target" or unit == "focus" or (unit and unit:find("boss%d")) then
				if TukuiCF["unitframes"].showtotalhpmp == true then
					health.value:SetFormattedText("|cff559655%s|r |cffD7BEA5|||r |cff559655%s|r", ShortValue(min), ShortValue(max))
				else
					health.value:SetFormattedText("|cffAF5050%s|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
				end
			elseif (unit and unit:find("arena%d")) then
				health.value:SetText("|cff559655"..ShortValue(min).."|r")
			else
				health.value:SetFormattedText("|cffAF5050%d|r |cffD7BEA5-|r |cff%02x%02x%02x%d%%|r", min, r * 255, g * 255, b * 255, floor(min / max * 100))
			end
		else
			if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
				health.value:SetText("|cff559655"..max.."|r")
			elseif unit == "target" or unit == "focus" or (unit and unit:find("arena%d")) then
				health.value:SetText("|cff559655"..ShortValue(max).."|r")
			else
				health.value:SetText("|cff559655"..max.."|r")
			end
		end
	end
end

TukuiDB.PostUpdatePowerRaid = function(self, unit, min, max)
	local powertype, _ = UnitPowerType(unit)
	if powertype ~= SPELL_POWER_MANA then
		self:Hide()
	else
		self:Show()
	end
end

TukuiDB.CheckPowerRaid = function(self, event)
	local unit = self.unit
	local powertype, _ = UnitPowerType(unit)
	if powertype ~= SPELL_POWER_MANA then
		self.Health:SetHeight(self.Health:GetParent():GetHeight())
		if self.Power then
			self.Power:Hide()
		end
	else
		if IsAddOnLoaded("Tukui_Heal_Layout") and self:GetParent():GetName() == "oUF_TukuiHealR6R25" then
				self.Health:SetHeight(self.Health:GetParent():GetHeight() * 0.85)
		elseif self:GetParent():GetName() == "oUF_TukuiDPSR6R25" then
			self.Health:SetHeight(self.Health:GetParent():GetHeight() * 0.75)
		else
			self.Health:SetHeight(self.Health:GetParent():GetHeight())	
		end
		if self.Power then
			self.Power:Show()
		end
	end	
end

TukuiDB.PostUpdateHealthParty = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_offline.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_dead.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_ghost.."|r")
		end
	else
			if min ~= max then
				health.value:SetText("|cffffffff-"..ShortValueNegative(max-min).."|r")
			else
				health.value:SetText(" ")
			end
	end
end

TukuiDB.PostUpdateHealthRaid = function(health, unit, min, max)
	if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
		if not UnitIsConnected(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_offline.."|r")
		elseif UnitIsDead(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_dead.."|r")
		elseif UnitIsGhost(unit) then
			health.value:SetText("|cffD7BEA5"..tukuilocal.unitframes_ouf_ghost.."|r")
		end
	else
			if min ~= max then
				health.value:SetText("|cff559655-"..ShortValueNegative(max-min).."|r")
			else
				health.value:SetText(" ")
			end
	end
	if TukuiCF["raidframes"].hidenonmana == true then
		local powertype, _ = UnitPowerType(unit)
		if powertype ~= SPELL_POWER_MANA then
			health:SetHeight(health:GetParent():GetHeight())
		else
			if IsAddOnLoaded("Tukui_Heal_Layout") and health:GetParent():GetParent():GetName() == "oUF_TukuiHealR6R25" then
				health:SetHeight(health:GetParent():GetHeight() * 0.85)
			elseif health:GetParent():GetParent():GetName() == "oUF_TukuiDPSR6R25" then
				health:SetHeight(health:GetParent():GetHeight() * 0.75)
			else
				health:SetHeight(health:GetParent():GetHeight())	
			end
		end	
	end
end

TukuiDB.PostNamePosition = function(self)
	self.Name:ClearAllPoints()
	if (self.Power.value:GetText() and UnitIsEnemy("player", "target") and TukuiCF["unitframes"].targetpowerpvponly == true) or (self.Power.value:GetText() and TukuiCF["unitframes"].targetpowerpvponly == false) then
		self.Name:SetPoint("CENTER", self.health, "CENTER", 0, 1)
	else
		self.Power.value:SetAlpha(0)
		self.Name:SetPoint("LEFT", self.health, "LEFT", 4, 1)
	end
end

TukuiDB.PreUpdatePower = function(power, unit)
	local _, pType = UnitPowerType(unit)
	
	local color = TukuiDB.oUF_colors.power[pType]
	if color then
		power:SetStatusBarColor(color[1], color[2], color[3])
	end
end

TukuiDB.PostUpdatePower = function(power, unit, min, max)
	local self = power:GetParent()
	local pType, pToken = UnitPowerType(unit)
	local color = TukuiDB.oUF_colors.power[pToken]

	if color then
		power.value:SetTextColor(color[1], color[2], color[3])
	end
		
	if min == 0 then 
			power.value:SetText("") 
	else
		if not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit) then
			power.value:SetText()
		elseif UnitIsDead(unit) or UnitIsGhost(unit) then
			power.value:SetText()
		else
			if min ~= max then
				if pType == 0 then
					if unit == "target" then
						if TukuiCF["unitframes"].showtotalhpmp == true then
							power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ShortValue(max - (max - min)), ShortValue(max))
						else
							power.value:SetFormattedText("%d%% |cffD7BEA5-|r %s", floor(min / max * 100), ShortValue(max - (max - min)))
						end
					elseif unit == "player" and self:GetAttribute("normalUnit") == "pet" or unit == "pet" then
						if TukuiCF["unitframes"].showtotalhpmp == true then
							power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ShortValue(max - (max - min)), ShortValue(max))
						else
							power.value:SetFormattedText("%d%%", floor(min / max * 100))
						end
					elseif (unit and unit:find("arena%d")) then
						power.value:SetText(ShortValue(min))
					else
						if TukuiCF["unitframes"].showtotalhpmp == true then
							power.value:SetFormattedText("%s |cffD7BEA5|||r %s", ShortValue(max - (max - min)), ShortValue(max))
						else
							power.value:SetFormattedText("%d%% |cffD7BEA5-|r %d", floor(min / max * 100), max - (max - min))
						end
					end
				else
					power.value:SetText(max - (max - min))
				end
			else
				if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) then
					power.value:SetText(ShortValue(min))
				else
					power.value:SetText(min)
				end
			end
		end
	end
	if self.Name then
		if unit == "target" then TukuiDB.PostNamePosition(self, power) end
	end
end

TukuiDB.CustomCastTimeText = function(self, duration)
	self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or self.max - duration, self.max))
end

TukuiDB.CustomCastDelayText = function(self, duration)
	self.Time:SetText(("%.1f |cffaf5050%s %.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
end

local FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", ceil(s / hour))
	elseif s >= hour then
		return format("%dh", ceil(s / hour))
	elseif s >= minute then
		return format("%dm", ceil(s / minute))
	elseif s >= minute / 12 then
		return floor(s)
	end
	return format("%.1f", s)
end



local CreateAuraTimer = function(self, elapsed)
	if self.timeLeft then
		self.elapsed = (self.elapsed or 0) + elapsed
		if self.elapsed >= 0.1 then
			if not self.first then
				self.timeLeft = self.timeLeft - self.elapsed
			else
				self.timeLeft = self.timeLeft - GetTime()
				self.first = false
			end
			if self.timeLeft > 0 then
				local time = FormatTime(self.timeLeft)
				self.remaining:SetText(time)
				if self.timeLeft <= 5 then
					self.remaining:SetTextColor(0.99, 0.31, 0.31)
				else
					self.remaining:SetTextColor(1, 1, 1)
				end
			else
				self.remaining:Hide()
				self:SetScript("OnUpdate", nil)
			end
			self.elapsed = 0
		end
	end
end

local CancelAura = function(self, button)
	if button == "RightButton" and not self.debuff then
		--CancelUnitBuff("player", self:GetID()) Protected in cata
	end
end

function TukuiDB.PostCreateAura(element, button)
	TukuiDB.SetTemplate(button)
	button.remaining = TukuiDB.SetFontString(button, TukuiCF["media"].font, TukuiCF["auras"].auratextscale, "THINOUTLINE")
	button.remaining:SetPoint("CENTER", TukuiDB.Scale(0), TukuiDB.mult)
	
	button.cd.noOCC = true		 	-- hide OmniCC CDs
	button.cd.noCooldownCount = true	-- hide CDC CDs
	
	button.cd:SetReverse()
	button.icon:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	button.icon:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:SetPoint("BOTTOMRIGHT", TukuiDB.mult, TukuiDB.Scale(1.5))
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(TukuiCF["media"].font, TukuiCF["auras"].auratextscale*0.8, "THINOUTLINE")

	
	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)	   
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:SetPoint("TOPLEFT", button, "TOPLEFT", TukuiDB.Scale(-3), TukuiDB.Scale(3))
	button.Glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", TukuiDB.Scale(3), TukuiDB.Scale(-3))
	button.Glow:SetFrameStrata("BACKGROUND")	
	button.Glow:SetBackdrop{edgeFile = TukuiCF["media"].glowTex, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
end

function TukuiDB.PostCreateAuraSmall(element, button)
	TukuiDB.SetTemplate(button)
	button.remaining = TukuiDB.SetFontString(button, TukuiCF["media"].font, TukuiCF["auras"].auratextscale*0.85, "THINOUTLINE")
	button.remaining:SetPoint("CENTER", TukuiDB.Scale(0), TukuiDB.mult*1.5)
	
	button.cd.noOCC = true		 	-- hide OmniCC CDs
	button.cd.noCooldownCount = true	-- hide CDC CDs
	
	button.cd:SetReverse()
	button.icon:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	button.icon:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:SetPoint("BOTTOMRIGHT", 0, TukuiDB.Scale(1.5))
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(TukuiCF["media"].font, TukuiCF["auras"].auratextscale*0.8, "THINOUTLINE")

	
	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)	   
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:SetPoint("TOPLEFT", button, "TOPLEFT", TukuiDB.Scale(-3), TukuiDB.Scale(3))
	button.Glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", TukuiDB.Scale(3), TukuiDB.Scale(-3))
	button.Glow:SetFrameStrata("BACKGROUND")	
	button.Glow:SetBackdrop{edgeFile = TukuiCF["media"].glowTex, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
end

function TukuiDB.PostCreateAuraSmallHealer25(element, button)
	button:EnableMouse(false)
	button:SetFrameLevel(15)
	TukuiDB.SetTemplate(button)
	button.remaining = TukuiDB.SetFontString(button, TukuiCF["media"].font, TukuiCF["auras"].auratextscale*0.85, "THINOUTLINE")
	button.remaining:SetPoint("CENTER", TukuiDB.Scale(0), TukuiDB.mult*1.5)
	
	button.cd.noOCC = true		 	-- hide OmniCC CDs
	button.cd.noCooldownCount = true	-- hide CDC CDs
	
	button.cd:SetReverse()
	button.icon:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	button.icon:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.icon:SetDrawLayer('ARTWORK')
	
	button.count:SetPoint("BOTTOMRIGHT", 0, TukuiDB.Scale(1.5))
	button.count:SetJustifyH("RIGHT")
	button.count:SetFont(TukuiCF["media"].font, TukuiCF["auras"].auratextscale*0.8, "THINOUTLINE")

	
	button.overlayFrame = CreateFrame("frame", nil, button, nil)
	button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
	button.cd:ClearAllPoints()
	button.cd:SetPoint("TOPLEFT", button, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	button.cd:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 1)	   
	button.overlay:SetParent(button.overlayFrame)
	button.count:SetParent(button.overlayFrame)
	button.remaining:SetParent(button.overlayFrame)
			
	button.Glow = CreateFrame("Frame", nil, button)
	button.Glow:SetPoint("TOPLEFT", button, "TOPLEFT", TukuiDB.Scale(-3), TukuiDB.Scale(3))
	button.Glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", TukuiDB.Scale(3), TukuiDB.Scale(-3))
	button.Glow:SetFrameLevel(button:GetFrameLevel() -1)
	button.Glow:SetBackdrop{edgeFile = TukuiCF["media"].glowTex, edgeSize = 3, insets = {left = 0, right = 0, top = 0, bottom = 0}}
	button.Glow:SetBackdropColor(0, 0, 0, 0)
	button.Glow:SetBackdropBorderColor(0, 0, 0)
end

function TukuiDB.PostUpdateAura(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
	local name, _, _, _, dtype, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, icon.filter)
	
	if(icon.debuff) then
		if(not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle") and (not DebuffWhiteList[name]) then
			icon:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
			icon.icon:SetDesaturated(true)
		else
			local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
			if (name == "Unstable Affliction" or name == "Vampiric Touch") and TukuiDB.myclass ~= "WARLOCK" then
				icon:SetBackdropBorderColor(0.05, 0.85, 0.94)
			else
				icon:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
			end
			icon.icon:SetDesaturated(false)
		end
	else
		if (isStealable or (TukuiDB.myclass == "PRIEST" and dtype == "Magic")) and not UnitIsFriend("player", unit) then
			icon:SetBackdropBorderColor(237/255, 234/255, 142/255)
		else
			icon:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
		end
	end
	

	
	if duration and duration > 0 then
		if TukuiCF["auras"].auratimer == true then
			icon.remaining:Show()
		else
			icon.remaining:Hide()
		end
	else
		icon.remaining:Hide()
	end
 
	icon.duration = duration
	icon.timeLeft = expirationTime
	icon.first = true
	icon:SetScript("OnUpdate", CreateAuraTimer)
end

TukuiDB.HidePortrait = function(self, event)
	if self.unit == "target" then
		if not UnitExists(self.unit) or not UnitIsConnected(self.unit) or not UnitIsVisible(self.unit) then
			self.PFrame:SetAlpha(0)
		else
			self.PFrame:SetAlpha(1)
		end
	end
end

TukuiDB.PostCastStart = function(self, unit, name, rank, castid)
	if unit == "vehicle" then unit = "player" end
	--Fix blank castbar with opening text
	if name == "Opening" then
		self.Text:SetText("Opening")
	end
	
	if self.interrupt and unit ~= "player" then
		if UnitCanAttack("player", unit) then
			self:SetStatusBarColor(unpack(TukuiCF["castbar"].nointerruptcolor))
		else
			self:SetStatusBarColor(unpack(TukuiCF["castbar"].castbarcolor))	
		end
	else
		if TukuiCF["castbar"].classcolor ~= true or unit ~= "player" then
			self:SetStatusBarColor(unpack(TukuiCF["castbar"].castbarcolor))
		else
			self:SetStatusBarColor(unpack(oUF.colors.class[select(2, UnitClass(unit))]))
		end	
	end
end

TukuiDB.UpdateShards = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end
	local num = UnitPower(unit, SPELL_POWER_SOUL_SHARDS)
	for i = 1, SHARD_BAR_NUM_SHARDS do
		if(i <= num) then
			self.SoulShards[i]:SetAlpha(1)
		else
			self.SoulShards[i]:SetAlpha(.2)
		end
	end
	
	if self.SoulShards:IsShown() then
		if self.Debuffs then self.Debuffs:ClearAllPoints() self.Debuffs:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(17)) end	
	else
		if self.Debuffs then self.Debuffs:ClearAllPoints() self.Debuffs:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(6)) end	
	end
end
	
TukuiDB.Phasing = function(self, event)
	local inPhase = UnitInPhase(self.unit)
	local picon = self.PhaseIcon

	if(inPhase) then
		picon:Hide()
		if self.Health.value then self.Health.value:SetAlpha(1) end
	else
		picon:Show()
		if self.Health.value then self.Health.value:SetAlpha(0) end
	end
end

TukuiDB.UpdateHoly = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end
	local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
	for i = 1, MAX_HOLY_POWER do
		if(i <= num) then
			self.HolyPower[i]:SetAlpha(1)
		else
			self.HolyPower[i]:SetAlpha(.2)
		end
	end
	
	if self.HolyPower:IsShown() then
		if self.Debuffs then self.Debuffs:ClearAllPoints() self.Debuffs:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(17)) end	
	else
		if self.Debuffs then self.Debuffs:ClearAllPoints() self.Debuffs:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(6)) end	
	end
end

TukuiDB.EclipseDisplay = function(self, login)
	local eb = self.EclipseBar

	if login then
		eb:SetScript("OnUpdate", nil)
	end
		
	if eb:IsShown() then
		self.FrameBorder.shadow:SetPoint("TOPLEFT", TukuiDB.Scale(-4), TukuiDB.Scale(17))
		if self.Debuffs then 
			self.Debuffs:ClearAllPoints()
			if self.Debuffs then self.Debuffs:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(17)) end	
		end		
	else
		self.FrameBorder.shadow:SetPoint("TOPLEFT", TukuiDB.Scale(-4), TukuiDB.Scale(4))
		if self.Debuffs then 
			self.Debuffs:ClearAllPoints()
			self.Debuffs:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(6))
		end	
	end
end

TukuiDB.ComboDisplay = function(self, event, unit)
	if(unit == 'pet') then return end
	
	local cpoints = self.CPoints
	local cp
	if(UnitExists'vehicle') then
		cp = GetComboPoints('vehicle', 'target')
	else
		cp = GetComboPoints('player', 'target')
	end

	for i=1, MAX_COMBO_POINTS do
		if(i <= cp) then
			cpoints[i]:SetAlpha(1)
		else
			cpoints[i]:SetAlpha(0.15)
		end
	end
	
	if cpoints[1]:GetAlpha() == 1 then
		for i=1, MAX_COMBO_POINTS do
			cpoints[i]:Show()
		end
		self.FrameBorder.shadow:SetPoint("TOPLEFT", TukuiDB.Scale(-4), TukuiDB.Scale(17))
		if self.Buffs then self.Buffs:ClearAllPoints() self.Buffs:SetPoint("BOTTOMLEFT", self.Health, "TOPLEFT", TukuiDB.Scale(-1), TukuiDB.Scale(17)) end	
	else
		for i=1, MAX_COMBO_POINTS do
			cpoints[i]:Hide()
		end

		self.FrameBorder.shadow:SetPoint("TOPLEFT", TukuiDB.Scale(-4), TukuiDB.Scale(4))	
		if self.Buffs then self.Buffs:ClearAllPoints() self.Buffs:SetPoint("BOTTOMLEFT", self.Health, "TOPLEFT", TukuiDB.Scale(-1), TukuiDB.Scale(4)) end	
	end
end

TukuiDB.MLAnchorUpdate = function (self)
	if self.Leader:IsShown() then
		self.MasterLooter:SetPoint("TOPLEFT", 14, 8)
	else
		self.MasterLooter:SetPoint("TOPLEFT", 2, 8)
	end
end

TukuiDB.RestingIconUpdate = function (self)
	if IsResting() then
		self.Resting:Show()
	else
		self.Resting:Hide()
	end
end


TukuiDB.UpdateReputationColor = function(self, event, unit, bar)
	local name, id = GetWatchedFactionInfo()
	bar:SetStatusBarColor(FACTION_BAR_COLORS[id].r, FACTION_BAR_COLORS[id].g, FACTION_BAR_COLORS[id].b)
end

local delay = 0
TukuiDB.UpdateManaLevel = function(self, elapsed)
	delay = delay + elapsed
	if self.parent.unit ~= "player" or delay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
	delay = 0

	local percMana = UnitMana("player") / UnitManaMax("player") * 100

	if percMana <= 20 then
		self.ManaLevel:SetText("|cffaf5050"..tukuilocal.unitframes_ouf_lowmana.."|r")
		Flash(self, 0.3)
	else
		self.ManaLevel:SetText()
		StopFlash(self)
	end
end

TukuiDB.UpdateDruidMana = function(self)
	if self.unit ~= "player" then return end

	local num, str = UnitPowerType("player")
	if num ~= 0 then
		local min = UnitPower("player", 0)
		local max = UnitPowerMax("player", 0)

		local percMana = min / max * 100
		if percMana <= TukuiCF["unitframes"].lowThreshold then
			self.FlashInfo.ManaLevel:SetText("|cffaf5050"..tukuilocal.unitframes_ouf_lowmana.."|r")
			Flash(self.FlashInfo, 0.3)
		else
			self.FlashInfo.ManaLevel:SetText()
			StopFlash(self.FlashInfo)
		end

		if min ~= max then
			if self.Power.value:GetText() then
				self.DruidMana:SetPoint("LEFT", self.Power.value, "RIGHT", -3, 0)
				self.DruidMana:SetFormattedText("|cffD7BEA5-|r %d%%|r", floor(min / max * 100))
			else
				self.DruidMana:SetPoint("LEFT", self.Health, "LEFT", 4, 1)
				self.DruidMana:SetFormattedText("%d%%", floor(min / max * 100))
			end
		else
			self.DruidMana:SetText()
		end

		self.DruidMana:SetAlpha(1)
	else
		self.DruidMana:SetAlpha(0)
	end
end

function TukuiDB.UpdateThreat(self, event, unit)
	if (self.unit ~= unit) or (unit == "target" or unit == "focus" or unit == "focustarget" or unit == "targettarget") then return end
	local threat = UnitThreatSituation(self.unit)
	if threat and threat > 1 then
		local r, g, b = GetThreatStatusColor(threat)
		if self.FrameBorder.shadow then
			self.FrameBorder.shadow:SetBackdropBorderColor(r,g,b,0.85)
			self.PowerFrame.shadow:SetBackdropBorderColor(r,g,b,0.85)
			if self.PFrame then
				self.PFrame.shadow:SetBackdropBorderColor(r,g,b,0.85)
			end
		else
			if self.HealthBorder then
				self.HealthBorder:SetBackdropBorderColor(r, g, b, 1)
			end
			if self.PFrame then
				self.PFrame:SetBackdropBorderColor(r, g, b, 1)
			end
			self.FrameBorder:SetBackdropBorderColor(r, g, b, 1)
		end
	else
		if self.FrameBorder.shadow then
			self.FrameBorder.shadow:SetBackdropBorderColor(0,0,0,0.75)
			self.PowerFrame.shadow:SetBackdropBorderColor(0,0,0,0.75)	
			if self.PFrame then
				self.PFrame.shadow:SetBackdropBorderColor(0,0,0,0.75)	
			end
		else
			self.FrameBorder:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
			if self.HealthBorder then
				self.HealthBorder:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
			end
			if self.PFrame then
				self.PFrame:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
			end
		end
	end 
end

TukuiDB.updateAllElements = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
end

TukuiDB.updateAllElementsRaid = function(frame)
	for _, v in ipairs(frame.__elements) do
		v(frame, "UpdateElement", frame.unit)
	end
	
	if TukuiCF["raidframes"].hidenonmana == true then
		local powertype, _ = UnitPowerType(frame.unit)
		if powertype ~= SPELL_POWER_MANA then
			frame.Health:SetHeight(frame.Health:GetParent():GetHeight())
			if frame.Power then
				frame.Power:Hide()
			end
		else
			if IsAddOnLoaded("Tukui_Heal_Layout") and frame:GetParent():GetName() == "oUF_TukuiHealR6R25" then
				frame.Health:SetHeight(frame.Health:GetParent():GetHeight() * 0.85)
			elseif frame:GetParent():GetName() == "oUF_TukuiDPSR6R25" then
				frame.Health:SetHeight(frame.Health:GetParent():GetHeight() * 0.75)
			else
				frame.Health:SetHeight(frame.Health:GetParent():GetHeight())	
			end
			if frame.Power then
				frame.Power:Show()
			end
		end	
	end
end

function TukuiDB.ExperienceText(self, unit, min, max)
	local rested = GetXPExhaustion()
	if rested then 
		self.Text:SetFormattedText('XP: '..ShortValue(min)..' / '..ShortValue(max)..' <%d%%>  R: +'..ShortValue(rested)..' <%d%%>', min / max * 100, rested / max * 100)
	else
		self.Text:SetFormattedText('XP: '..ShortValue(min)..' / '..ShortValue(max)..' <%d%%>', min / max * 100)
	end
end

--------------------------------------------------------------------------------------------
-- THE AURAWATCH FUNCTION ITSELF. HERE BE DRAGONS!
--------------------------------------------------------------------------------------------

TukuiDB.countOffsets = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0},
}

function TukuiDB.CreateAuraWatchIcon(self, icon)
	if (icon.cd) then
		icon.cd:SetReverse()
	end 	
end

local _, class = UnitClass("player")
function TukuiDB.createAuraWatch(self, unit)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetPoint("TOPLEFT", self.Health, 2, -2)
	auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
	auras.presentAlpha = 1
	auras.missingAlpha = 0
	auras.icons = {}
    auras.PostCreateIcon = TukuiDB.CreateAuraWatchIcon

	if (not TukuiCF["auras"].auratimer) then
		auras.hideCooldown = true
	end

	local buffs = {}
	if IsAddOnLoaded("Tukui_Dps_Layout") then
		if (TukuiDB.DPSBuffIDs["ALL"]) then
			for key, value in pairs(TukuiDB.DPSBuffIDs["ALL"]) do
				tinsert(buffs, value)
			end
		end

		if (TukuiDB.DPSBuffIDs[TukuiDB.myclass]) then
			for key, value in pairs(TukuiDB.DPSBuffIDs[TukuiDB.myclass]) do
				tinsert(buffs, value)
			end
		end	
	else
		if (TukuiDB.HealerBuffIDs["ALL"]) then
			for key, value in pairs(TukuiDB.HealerBuffIDs["ALL"]) do
				tinsert(buffs, value)
			end
		end

		if (TukuiDB.HealerBuffIDs[TukuiDB.myclass]) then
			for key, value in pairs(TukuiDB.HealerBuffIDs[TukuiDB.myclass]) do
				tinsert(buffs, value)
			end
		end
	end

	-- "Cornerbuffs"
	if (buffs) then
		for key, spell in pairs(buffs) do
			local icon = CreateFrame("Frame", nil, auras)
			icon.spellID = spell[1]
			icon.anyUnit = spell[4]
			icon:SetWidth(TukuiDB.Scale(6))
			icon:SetHeight(TukuiDB.Scale(6))
			icon:SetPoint(spell[2], 0, 0)

			local tex = icon:CreateTexture(nil, "OVERLAY")
			tex:SetAllPoints(icon)
			tex:SetTexture([=[Interface\AddOns\Tukui\media\textures\blank]=])
			if (spell[3]) then
				tex:SetVertexColor(unpack(spell[3]))
			else
				tex:SetVertexColor(0.8, 0.8, 0.8)
			end

			local count = icon:CreateFontString(nil, "OVERLAY")
			count:SetFont(TukuiCF["media"].uffont, 8, "THINOUTLINE")
			count:SetPoint("CENTER", unpack(TukuiDB.countOffsets[spell[2]]))
			icon.count = count

			auras.icons[spell[1]] = icon
		end
	end

	self.AuraWatch = auras
end