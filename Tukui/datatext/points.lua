----- [[    Honor / Conquest / Justice Points by Eclípsé    ]] -----

if TukuiCF["datatext"].points and TukuiCF["datatext"].points > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.theme.DATA_Font, TukuiCF.theme.DATA_FSize, TukuiCF.theme.DATA_FFlag)
	TukuiDB.PP(TukuiCF["datatext"].points, Text)
	
	local function OnEvent(self, event)	
		h_name, h_amount, h_icon = GetCurrencyInfo(392) -- Honor Points
		c_name, c_amount, c_icon = GetCurrencyInfo(390) -- Conquest Points
		j_name, j_amount, j_icon = GetCurrencyInfo(395) -- Justice Points
	
		local honor = ""
		local conquest = ""
		local justice = ""
		if h_amount > 0 then
			honor = (cStart .. "H: " .. cEnd .. h_amount .. " ")
		end
		if c_amount > 0 then
			conquest = (cStart .. "C: " .. cEnd .. c_amount .. " ")
		end
		if j_amount > 0 then
			justice = (cStart .. "J: " .. cEnd .. j_amount)
		end
	
		if h_amount == 0 and c_amount == 0 and j_amount == 0 then
			Text:SetText(cStart .. "No Points") 
		else
			Text:SetText(honor .. conquest .. justice) 
		end
		
		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("HONOR_CURRENCY_UPDATE")
	Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(cStart .. "Currency: ")
			GameTooltip:AddLine" "
			
			if h_amount > 0 then
				GameTooltip:AddDoubleLine(cStart .. h_name .. ":", h_amount, _, _, _, 1, 1, 1)
			end
			if c_amount > 0 then
				GameTooltip:AddDoubleLine(cStart .. c_name .. ":", c_amount, _, _, _, 1, 1, 1)
			end
			if j_amount > 0 then
				GameTooltip:AddDoubleLine(cStart .. j_name .. ":", j_amount, _, _, _, 1, 1, 1)
			end
			
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end