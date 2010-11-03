if not TukuiCF["actionbar"].enable == true then return end

local _G = _G
local media = TukuiCF["media"]
local securehandler = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")

function style(self, vehicle)
	local name = self:GetName()
	
	if name:match("MultiCastActionButton") then return end 
	
	local action = self.action
	local Button = self
	local Icon = _G[name.."Icon"]
	local Count = _G[name.."Count"]
	local Flash	 = _G[name.."Flash"]
	local HotKey = _G[name.."HotKey"]
	local Border  = _G[name.."Border"]
	local Btname = _G[name.."Name"]
	local normal  = _G[name.."NormalTexture"]
 
	if Flash then
		Flash:SetTexture("")
	end
	Button:SetNormalTexture("")
 
	if Border then
		Border:Hide()
		Border = TukuiDB.dummy
	end
	if Count then
		Count:ClearAllPoints()
		Count:SetPoint("BOTTOMRIGHT", 0, TukuiDB.Scale(2))
		Count:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
	end
	if Btname then
		Btname:SetText("")
		Btname:Hide()
		Btname.Show = TukuiDB.dummy
	end
 
	if not _G[name.."Panel"] then
		self:SetWidth(TukuiDB.buttonsize)
		self:SetHeight(TukuiDB.buttonsize)
 
		local panel = CreateFrame("Frame", name.."Panel", self)
		if vehicle then
			TukuiDB.CreatePanel(panel, TukuiDB.buttonsize*1.2, TukuiDB.buttonsize*1.2, "CENTER", self, "CENTER", 0, 0)
		else
			TukuiDB.CreatePanel(panel, TukuiDB.buttonsize, TukuiDB.buttonsize, "CENTER", self, "CENTER", 0, 0)
		end
		panel:SetFrameStrata(self:GetFrameStrata())
		panel:SetFrameLevel(self:GetFrameLevel() - 1)
 
		if Icon then
			Icon:SetTexCoord(.08, .92, .08, .92)
			Icon:SetPoint("TOPLEFT", Button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			Icon:SetPoint("BOTTOMRIGHT", Button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		end
	end

	if HotKey then
		HotKey:ClearAllPoints()
		HotKey:SetPoint("TOPRIGHT", 0, TukuiDB.Scale(-3))
		HotKey:SetFont(TukuiCF["media"].font, 12, "OUTLINE")
		HotKey.ClearAllPoints = TukuiDB.dummy
		HotKey.SetPoint = TukuiDB.dummy
		if not TukuiCF["actionbar"].hotkey == true then
			HotKey:SetText("")
			HotKey:Hide()
			HotKey.Show = TukuiDB.dummy
		end
	end
 
--	if not TukuiCF["actionbar"].hotkey == true then
--		HotKey:SetText("")
--		HotKey:Hide()
--		HotKey.Show = TukuiDB.dummy
--	end
 
	if normal then
		normal:ClearAllPoints()
		normal:SetPoint("TOPLEFT")
		normal:SetPoint("BOTTOMRIGHT")
	end
end

local function stylesmallbutton(normal, button, icon, name, pet)
	local Flash	 = _G[name.."Flash"]
	button:SetNormalTexture("")
	
	-- another bug fix reported by Affli in t12 beta
	button.SetNormalTexture = TukuiDB.dummy
	
	Flash:SetTexture(media.buttonhover)
	
	if not _G[name.."Panel"] then
		button:SetWidth(TukuiDB.petbuttonsize)
		button:SetHeight(TukuiDB.petbuttonsize)
		
		local panel = CreateFrame("Frame", name.."Panel", button)
		TukuiDB.CreatePanel(panel, TukuiDB.petbuttonsize, TukuiDB.petbuttonsize, "CENTER", button, "CENTER", 0, 0)
		panel:SetBackdropColor(unpack(media.backdropcolor))
		panel:SetFrameStrata(button:GetFrameStrata())
		panel:SetFrameLevel(button:GetFrameLevel() - 1)

		icon:SetTexCoord(.08, .92, .08, .92)
		icon:ClearAllPoints()
		if pet then
			local autocast = _G[name.."AutoCastable"]
			autocast:SetWidth(TukuiDB.Scale(41))
			autocast:SetHeight(TukuiDB.Scale(40))
			autocast:ClearAllPoints()
			autocast:SetPoint("CENTER", button, 0, 0)
			icon:SetPoint("TOPLEFT", button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		else
			icon:SetPoint("TOPLEFT", button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			icon:SetPoint("BOTTOMRIGHT", button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		end
	end
	
	normal:ClearAllPoints()
	normal:SetPoint("TOPLEFT")
	normal:SetPoint("BOTTOMRIGHT")
end

function TukuiDB.StyleShift()
	for i=1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture"]
		stylesmallbutton(normal, button, icon, name)
	end
end

function TukuiDB.StylePet()
	for i=1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local button  = _G[name]
		local icon  = _G[name.."Icon"]
		local normal  = _G[name.."NormalTexture2"]
		stylesmallbutton(normal, button, icon, name, true)
	end
end

-- rescale cooldown spiral to fix texture.
local buttonNames = { "ActionButton",  "MultiBarBottomLeftButton", "MultiBarBottomRightButton", "MultiBarLeftButton", "MultiBarRightButton", "ShapeshiftButton", "PetActionButton"}
for _, name in ipairs( buttonNames ) do
	for index = 1, 12 do
		local buttonName = name .. tostring(index)
		local button = _G[buttonName]
		local cooldown = _G[buttonName .. "Cooldown"]
 
		if ( button == nil or cooldown == nil ) then
			break
		end
		
		cooldown:ClearAllPoints()
		cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
		cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)
	end
end

local buttons = 0
local function SetupFlyoutButton()
	for i=1, buttons do
		--prevent error if you don't have max ammount of buttons
		if _G["SpellFlyoutButton"..i] then
			style(_G["SpellFlyoutButton"..i], false)
			TukuiDB.StyleButton(_G["SpellFlyoutButton"..i], true)
		end
	end
end
SpellFlyout:HookScript("OnShow", SetupFlyoutButton)

-- Reposition flyout buttons depending on what tukui bar the button is parented to
local function FlyoutButtonPos(self, buttons, direction)
	for i=1, buttons do
		local parent = SpellFlyout:GetParent()
		if not _G["SpellFlyoutButton"..i] then return end
		
		if InCombatLockdown() then return end
 
		if direction == "LEFT" then
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", parent, "LEFT", -4, 0)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("RIGHT", _G["SpellFlyoutButton"..i-1], "LEFT", -4, 0)
			end
		else
			if i == 1 then
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", parent, "TOP", 0, 4)
			else
				_G["SpellFlyoutButton"..i]:ClearAllPoints()
				_G["SpellFlyoutButton"..i]:SetPoint("BOTTOM", _G["SpellFlyoutButton"..i-1], "TOP", 0, 4)
			end
		end
	end
end
 
--Hide the Mouseover texture and attempt to find the ammount of buttons to be skinned
local function styleflyout(self)
	self.FlyoutBorder:SetAlpha(0)
	self.FlyoutBorderShadow:SetAlpha(0)
	
	SpellFlyoutHorizontalBackground:SetAlpha(0)
	SpellFlyoutVerticalBackground:SetAlpha(0)
	SpellFlyoutBackgroundEnd:SetAlpha(0)
	
	for i=1, GetNumFlyouts() do
		local x = GetFlyoutID(i)
		local _, _, numSlots, isKnown = GetFlyoutInfo(x)
		if isKnown then
			buttons = numSlots
			break
		end
	end
	
	--Change arrow direction depending on what bar the button is on
	local arrowDistance
	if ((SpellFlyout and SpellFlyout:IsShown() and SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
			arrowDistance = 5
	else
			arrowDistance = 2
	end
	
	if (self:GetParent() == MultiBarBottomRight and TukuiCF.actionbar.rightbars > 1) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0)
		SetClampedTextureRotation(self.FlyoutArrow, 270)
		FlyoutButtonPos(self,buttons,"LEFT")
	elseif (self:GetParent() == MultiBarLeft and not TukuiDB.lowversion and TukuiCF.actionbar.bottomrows == 2) then
		self.FlyoutArrow:ClearAllPoints()
		self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance)
		SetClampedTextureRotation(self.FlyoutArrow, 0)
		FlyoutButtonPos(self,buttons,"UP")	
	elseif not self:GetParent():GetParent() == "SpellBookSpellIconsFrame" then
		FlyoutButtonPos(self,buttons,"UP")
	end
end

do	
	for i = 1, 12 do
		TukuiDB.StyleButton(_G["MultiBarLeftButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarRightButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarBottomRightButton"..i], true)
		TukuiDB.StyleButton(_G["MultiBarBottomLeftButton"..i], true)
		TukuiDB.StyleButton(_G["ActionButton"..i], true)
	end
	 
	for i=1, 10 do
		TukuiDB.StyleButton(_G["ShapeshiftButton"..i], true)
		TukuiDB.StyleButton(_G["PetActionButton"..i], true)	
	end
	
	for i=1, 6 do
		TukuiDB.StyleButton(_G["VehicleMenuBarActionButton"..i], true)
		style(_G["VehicleMenuBarActionButton"..i], true)
	end
end

hooksecurefunc("ActionButton_Update", style)
hooksecurefunc("ActionButton_UpdateHotkeys", TukuiDB.UpdateHotkey)
hooksecurefunc("ActionButton_UpdateFlyout", styleflyout)

--[[
    MultiCastActionBar Skin
	
	(C)2010 Darth Android / Telroth - The Venture Co.

]]

if TukuiDB.myclass ~= "SHAMAN" then return end

-- Courtesy Blizzard Inc.
-- I wouldn't have to copy these if they'd just make them not local >.>
SLOT_EMPTY_TCOORDS = {
	[EARTH_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 3 / 256,
		bottom	= 33 / 256,
	},
	[FIRE_TOTEM_SLOT] = {
		left	= 67 / 128,
		right	= 97 / 128,
		top		= 100 / 256,
		bottom	= 130 / 256,
	},
	[WATER_TOTEM_SLOT] = {
		left	= 39 / 128,
		right	= 69 / 128,
		top		= 209 / 256,
		bottom	= 239 / 256,
	},
	[AIR_TOTEM_SLOT] = {
		left	= 66 / 128,
		right	= 96 / 128,
		top		= 36 / 256,
		bottom	= 66 / 256,
	},
}

--function quickTest()
--	MultiCastActionBarFrame:ClearAllPoints()
--	MultiCastActionBarFrame:SetPoint("CENTER",UIParent,"CENTER")
--end
local AddOn_Loaded = CreateFrame("Frame")
AddOn_Loaded:RegisterEvent("ADDON_LOADED")
AddOn_Loaded:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Tukui" then return end

	Mod_AddonSkins:RegisterSkin("Blizzard_TotemBar",function(Skin,skin,Layout,layout,config)
		local bordercolors = {
			{.58,.23,.10},    -- Earth
			{.23,.45,.13},    -- Fire
			{.19,.48,.60},   -- Water
			{.42,.18,.74},   -- Air
			{.39,.39,.12}    -- Summon / Recall
		}
		local vert = nil
		local flip = nil
		if TukuiCF["actionbar"].totem_leftcorner then
			vert = true
			flip = false
		else
			vert = TukuiCF["actionbar"].verticalshapeshift
			flip = TukuiCF["actionbar"].flipshapeshift
		end
		-- Skin Flyout
		function Skin:SkinMCABFlyoutFrame(flyout)
			flyout.top:SetTexture(nil)
			flyout.middle:SetTexture(nil)
			self:SkinFrame(flyout)
			flyout:SetFrameLevel(20)
			flyout:SetBackdropBorderColor(0,0,0,0)
			flyout:SetBackdropColor(0,0,0,0)
			-- Skin buttons
			local last = nil
			for _,button in ipairs(flyout.buttons) do
				self:SkinButton(button)
				TukuiDB.StyleButton(button)
				button:SetBackdropBorderColor(select(2, flyout:GetPoint()):GetBackdropBorderColor())
				if not InCombatLockdown() then
					button:SetSize(config.buttonSize,config.buttonSize)
					button:ClearAllPoints()
					if vert then
						if flip then
							button:SetPoint("RIGHT", last, "LEFT", -config.borderWidth, 0)
						else
							button:SetPoint("LEFT", last, "RIGHT", config.borderWidth, 0)
						end
					else
						if flip then
							button:SetPoint("TOP", last, "BOTTOM", 0, -config.borderWidth)
						else
							button:SetPoint("BOTTOM", last, "TOP", 0, config.borderWidth)
						end
					end
				end
				if button:IsVisible() then last = button end
			end
			
			--flyout.buttons[1]:SetPoint("RIGHT",flyout,"RIGHT")
			flyout.buttons[1]:ClearAllPoints()
			if vert then
				if flip then
					flyout.buttons[1]:SetPoint("RIGHT",flyout.parent,"LEFT", TukuiDB.Scale(-1), 0)
				else
					flyout.buttons[1]:SetPoint("LEFT",flyout.parent,"RIGHT", TukuiDB.Scale(1), 0)
				end
			else
				if flip then
					flyout.buttons[1]:SetPoint("TOP",flyout.parent,"BOTTOM", 0, TukuiDB.Scale(-1))
				else
					flyout.buttons[1]:SetPoint("BOTTOM",flyout.parent,"TOP", 0, TukuiDB.Scale(1))
				end
			end
			if flyout.type == "slot" then
				local tcoords = SLOT_EMPTY_TCOORDS[flyout.parent:GetID()]
				flyout.buttons[1].icon:SetTexCoord(tcoords.left,tcoords.right,tcoords.top,tcoords.bottom)
			end
			-- Skin Close button
			local close = MultiCastFlyoutFrameCloseButton
			self:SkinButton(close)
			close:SetBackdropBorderColor(select(2, flyout:GetPoint()):GetBackdropBorderColor())
			close:GetHighlightTexture():SetTexture([[Interface\Buttons\ButtonHilight-Square]])
			close:GetHighlightTexture():SetPoint("TOPLEFT",close,"TOPLEFT",config.borderWidth,-config.borderWidth)
			close:GetHighlightTexture():SetPoint("BOTTOMRIGHT",close,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
			close:GetNormalTexture():SetTexture(nil)
			close:ClearAllPoints()
			if vert then
				if flip then
					close:SetPoint("RIGHT",last,"LEFT", TukuiDB.Scale(-1), 0)
				else
					close:SetPoint("LEFT",last,"RIGHT", TukuiDB.Scale(1), 0)
				end
				close:SetWidth(config.buttonSpacing*2)
				close:SetHeight(config.buttonSize)
			else
				if flip then
					close:SetPoint("TOP",last,"BOTTOM", 0, TukuiDB.Scale(-1))
				else
					close:SetPoint("BOTTOM",last,"TOP", 0, TukuiDB.Scale(1))
				end
				close:SetHeight(config.buttonSpacing*2)
				close:SetWidth(config.buttonSize)
			end
			--close:SetPoint("BOTTOMRIGHT",last,"TOPRIGHT",0,config.buttonSpacing)
			
			
			flyout:ClearAllPoints()
			if vert then
				if flip then
					flyout:SetPoint("RIGHT",flyout.parent,"LEFT",config.buttonSize,0)
				else
					flyout:SetPoint("LEFT",flyout.parent,"RIGHT",-config.buttonSize,0)
				end
			else
				if flip then
					flyout:SetPoint("TOP",flyout.parent,"BOTTOM", 0, config.buttonSize)
				else
					flyout:SetPoint("BOTTOM",flyout.parent,"TOP", 0, -config.buttonSize)
				end
			end
			-- if TukuiCF["others"].totembardirection == "RIGHT" and TukuiCF["actionbar"].verticalshapeshift then
				--print(flyout.parent:GetName())
				-- flyout:SetPoint("LEFT",flyout.parent,"RIGHT",-config.buttonSize,0)
				--flyout:SetPoint("BOTTOMLEFT",flyout,"BOTTOMRIGHT",0,config.buttonSpacing)
			-- elseif TukuiCF["others"].totembardirection == "RIGHT" and not TukuiCF["others"].verticalshapeshift then
			   -- flyout:SetPoint("BOTTOM",flyout.parent,"TOP",config.buttonSpacing,0)
			-- elseif TukuiCF["others"].totembardirection == "LEFT" and not TukuiCF["others"].verticalshapeshift then
             -- flyout:SetPoint("RIGHT",flyout.parent,"LEFT",-config.buttonSpacing,0)
			-- else
				-- flyout:SetPoint("TOP",flyout.parent,"BOTTOM",0,config.buttonSpacing)
			-- end
		end
		hooksecurefunc("MultiCastFlyoutFrame_ToggleFlyout",function(self) skin:SkinMCABFlyoutFrame(self) end)
		
		function Skin:SkinMCABFlyoutOpenButton(button, parent)
			button:GetHighlightTexture():SetTexture(nil)
			button:GetNormalTexture():SetTexture(nil)
			button:ClearAllPoints()
			if vert then
				-- Flyout Vertical
				if flip then
					button:SetPoint("RIGHT", parent, "LEFT", config.ButtonSpacing, 0)
				else
					button:SetPoint("LEFT", parent, "RIGHT", config.ButtonSpacing, 0)
				end
				button:SetWidth(config.buttonSpacing*3)
				button:SetHeight(config.buttonSize)
			else
				-- Flyout Horizontal
				if flip then
					button:SetPoint("TOP", parent, "BOTTOM", 0, config.ButtonSpacing)
				else
					button:SetPoint("BOTTOM", parent, "TOP", 0, config.ButtonSpacing)
				end
				button:SetHeight(config.buttonSpacing*3)
				button:SetWidth(config.buttonSize)
			end

			-- if TukuiCF["others"].totembardirection == "RIGHT"  and TukuiCF["others"].verticalshapeshift then
				-- button:SetPoint("LEFT", parent, "RIGHT", config.ButtonSpacing, 0)
				--button:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT")
			-- elseif TukuiCF["others"].totembardirection == "RIGHT" and not TukuiCF["others"].verticalshapeshift then
				-- button:SetPoint("TOPLEFT", parent, "TOPRIGHT")
				-- button:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT")
			-- elseif TukuiCF["others"].totembardirection == "LEFT" and not TukuiCF["others"].verticalshapeshift then
				-- button:SetPoint("TOPRIGHT", parent, "TOPLEFT")
				-- button:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT")
			-- else
				-- button:SetPoint("TOPLEFT", parent, "BOTTOMLEFT")
				-- button:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT")			
			-- end
			button:SetBackdropColor(0,0,0,0)
			button:SetBackdropBorderColor(0,0,0,0)
			--button:SetBackdropBorderColor(parent:GetBackdropBorderColor())
			if not button.visibleBut then
				button.visibleBut = CreateFrame("Frame",nil,button)
				if vert then
					if flip then
						button.visibleBut:SetPoint("RIGHT", TukuiDB.Scale(-1), 0)
					else
						button.visibleBut:SetPoint("LEFT", TukuiDB.Scale(1), 0)
					end
					button.visibleBut:SetHeight(config.buttonSize)
					button.visibleBut:SetWidth(config.buttonSpacing*2)
				else
					if flip then
						button.visibleBut:SetPoint("TOP", 0, TukuiDB.Scale(-1))
					else
						button.visibleBut:SetPoint("BOTTOM", 0, TukuiDB.Scale(1))
					end
					button.visibleBut:SetHeight(config.buttonSpacing*2)
					button.visibleBut:SetWidth(config.buttonSize)
				end
				button.visibleBut.highlight = button.visibleBut:CreateTexture(nil,"HIGHLIGHT")
				button.visibleBut.highlight:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
				-- if TukuiCF["others"].totembardirection == "RIGHT" then
				button.visibleBut.highlight:SetPoint("TOPLEFT",button.visibleBut,"TOPLEFT",config.borderWidth,-config.borderWidth)
				button.visibleBut.highlight:SetPoint("BOTTOMRIGHT",button.visibleBut,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
				-- else
					-- button.visibleBut.highlight:SetPoint("BOTTOMLEFT",button.visibleBut,"BOTTOMLEFT",config.borderWidth,-config.borderWidth)
					-- button.visibleBut.highlight:SetPoint("TOPRIGHT",button.visibleBut,"TOPRIGHT",-config.borderWidth,config.borderWidth)				
				-- end
				self:SkinFrame(button.visibleBut)
				--button.visibleBut:SetBackdropBorderColor(parent:GetBackdropBorderColor())
			end
			button.visibleBut:SetBackdropBorderColor(parent:GetBackdropBorderColor())
			button:SetFrameLevel(20)
		end
		hooksecurefunc("MultiCastFlyoutFrameOpenButton_Show",function(button,_, parent) skin:SkinMCABFlyoutOpenButton(button, parent) end)
		
		function Skin:SkinMCABSlotButton(button, index)
			--self:SkinFrame(button)
			--TukuiDB.StyleButton(button)
			self:SkinButton(button)
			if _G[button:GetName().."Panel"] then _G[button:GetName().."Panel"]:Hide() end
			button.overlayTex:SetTexture(nil)
			button.background:SetDrawLayer("ARTWORK")
			button.background:ClearAllPoints()
			button.background:SetPoint("TOPLEFT",button,"TOPLEFT",config.borderWidth,-config.borderWidth)
			button.background:SetPoint("BOTTOMRIGHT",button,"BOTTOMRIGHT",-config.borderWidth,config.borderWidth)
			button:SetSize(config.buttonSize, config.buttonSize)
			button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
			style(button)
			TukuiDB.StyleButton(button, false)
			--button:SetFrameLevel(20)
		end
		hooksecurefunc("MultiCastSlotButton_Update",function(self, slot) skin:SkinMCABSlotButton(self, slot) end)
		
		-- Skin the actual totem buttons
		function Skin:SkinMCABActionButton(button, index)
			self:SkinButton(button)
			self:SkinBackgroundFrame(button)
			TukuiDB.StyleButton(button)
			style(button, false)
			button.overlayTex:SetTexture(nil)
			button.overlayTex:Hide()
			button:GetNormalTexture():SetTexture(nil)
			button:GetNormalTexture():Hide()
			button:GetNormalTexture().Show = TukuiDB.dummy
			if _G[button:GetName().."Panel"] then _G[button:GetName().."Panel"]:Hide() end
			if not InCombatLockdown() then button:SetAllPoints(button.slotButton) end
			button:SetBackdropBorderColor(unpack(bordercolors[((index-1) % 4) + 1]))
			button:SetBackdropColor(0,0,0,0)
			style(button)
			TukuiDB.StyleButton(button, false)
			button:SetFrameLevel(20)
			--button:GetHighlightTexture():SetTexture(nil)
			--button:GetNormalTexture():SetTexture(nil)
--			button.
		end
		hooksecurefunc("MultiCastActionButton_Update",function(actionButton, actionId, actionIndex, slot) skin:SkinMCABActionButton(actionButton,actionIndex) end)
		
		-- Skin the summon and recall buttons
		function Skin:SkinMCABSpellButton(button, index)
			if not button then return end
			self:SkinButton(button)
			button:GetNormalTexture():SetTexture(nil)
			self:SkinBackgroundFrame(button)
			--TukuiDB.StyleButton(button)
			--style(button, false)
			button:SetBackdropBorderColor(unpack(bordercolors[((index-1)%5)+1]))
			if not InCombatLockdown() then button:SetSize(config.buttonSize, config.buttonSize) end
			_G[button:GetName().."Highlight"]:SetTexture(nil)
			_G[button:GetName().."NormalTexture"]:SetTexture(nil)
			style(button)
			TukuiDB.StyleButton(button, false)
		end
		hooksecurefunc("MultiCastSummonSpellButton_Update", function(self) skin:SkinMCABSpellButton(self,0) end)
		hooksecurefunc("MultiCastRecallSpellButton_Update", function(self) skin:SkinMCABSpellButton(self,5) end)
		
		local frame = MultiCastActionBarFrame
	end)
end)