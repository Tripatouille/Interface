-- we just use default totem bar for shaman
-- we parent it to our shapeshift bar.
-- This is approx the same script as it was in WOTLK Tukui version.
if TukuiCF["actionbar"].enable ~= true then return end

if TukuiDB.myclass == "SHAMAN" then
   if MultiCastActionBarFrame then
		MultiCastActionBarFrame:SetScript("OnUpdate", nil)
		MultiCastActionBarFrame:SetScript("OnShow", nil)
		MultiCastActionBarFrame:SetScript("OnHide", nil)
		MultiCastActionBarFrame:SetParent(UIParent)
		MultiCastActionBarFrame:ClearAllPoints()
		MultiCastSummonSpellButton:ClearAllPoints()
		if not TukuiCF["actionbar"].totem_leftcorner then
			MultiCastSummonSpellButton:SetPoint("BOTTOMLEFT", TukuiShiftBar, 0, TukuiDB.Scale(23))
		else
			MultiCastSummonSpellButton:SetPoint("TOPLEFT", TukuiMemoryStats, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
		end
		MultiCastRecallSpellButton:ClearAllPoints()
		MultiCastActionBarFrame.SetPoint = function() end
		
		hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
 
		-- MultiCastActionBarFrame.SetParent = TukuiDB.dummy
		-- MultiCastActionBarFrame.SetPoint = TukuiDB.dummy
		-- MultiCastRecallSpellButton.SetPoint = TukuiDB.dummy -- bug fix, see http://www.tukui.org/v2/forums/topic.php?id=2405
	end
	local vert = nil
	if TukuiCF["actionbar"].totem_leftcorner then
		vert = true
	else
		vert = TukuiCF["actionbar"].verticalshapeshift
	end

	--[[  Place the Totembar has we which ]]
	if vert then
		local b = nil
		for i = 1,4 do
			b = _G["MultiCastSlotButton"..i]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("TOP",MultiCastSummonSpellButton,"BOTTOM", 0,TukuiDB.Scale(-2))
			else
				local b2 = _G["MultiCastSlotButton"..(i-1)]
				b:SetPoint("TOP", b2, "BOTTOM", 0, TukuiDB.Scale(-2))
			end
		end
		MultiCastRecallSpellButton:SetPoint("TOPLEFT",b,"BOTTOMLEFT", 0, TukuiDB.Scale(-2))
		MultiCastRecallSpellButton:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT", 0, TukuiDB.Scale(-2))
	else
		for i = 1,4 do
			b = _G["MultiCastSlotButton"..i]
			b:ClearAllPoints()
			if i == 1 then
				b:SetPoint("LEFT",MultiCastSummonSpellButton,"RIGHT",TukuiDB.Scale(2),0)
			else
				local b2 = _G["MultiCastSlotButton"..(i-1)]
				b:SetPoint("LEFT",b2,"RIGHT",TukuiDB.Scale(2),0)
			end
		end
		MultiCastRecallSpellButton:SetPoint("TOPLEFT",b,"TOPRIGHT", TukuiDB.Scale(2), 0)
		MultiCastRecallSpellButton:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT", TukuiDB.Scale(2), 0)
	end

end


