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
		MultiCastSummonSpellButton:SetPoint("TOPLEFT", TukuiMemoryStats, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
		MultiCastRecallSpellButton:ClearAllPoints()
		MultiCastActionBarFrame.SetPoint = function() end
      --MultiCastActionBarFrame:ClearAllPoints()
      --MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", TukuiShiftBar, 0, TukuiDB.Scale(23))
 
      hooksecurefunc("MultiCastActionButton_Update",function(actionbutton) if not InCombatLockdown() then actionbutton:SetAllPoints(actionbutton.slotButton) end end)
 
      --MultiCastActionBarFrame.SetParent = TukuiDB.dummy
      --MultiCastActionBarFrame.SetPoint = TukuiDB.dummy
      --MultiCastRecallSpellButton.SetPoint = TukuiDB.dummy -- bug fix, see http://www.tukui.org/v2/forums/topic.php?id=2405
	end
	
	-- local buttonsize = TukuiDB.Scale(27)
	-- local flyoutsize = TukuiDB.Scale(24)
	-- local buttonspacing = TukuiDB.Scale(4)
	-- local borderspacing = TukuiDB.Scale(2)
	-- local vert = TukuiCF["actionbar"].verticalshapeshift
	-- local flip = TukuiCF["actionbar"].flipshapeshift

	--[[  Place the Totembar has we which ]]
	-- if vert then
		--print("Vertical")
		local b = nil
		for i = 1,4 do
			b = _G["MultiCastSlotButton"..i]
			b:ClearAllPoints()
			if i == 1 then
				--print(b:GetName(), " | ", b:GetParent():GetName())
				--MultiCastActionBarFrame:ClearAllPoints()
				--b:SetParent(MultiCastActionBarFrame)
				b:SetPoint("TOP",MultiCastSummonSpellButton,"BOTTOM", 0,TukuiDB.Scale(-2))
				--b:SetPoint("TOP",MultiCastSummonSpellButton,"BOTTOM", 0,TukuiDB.Scale(-2))
			else
				--print(b:GetName(), " | ", b:GetParent():GetName())
				local b2 = _G["MultiCastSlotButton"..(i-1)]
				b:SetPoint("TOPLEFT",b2,"BOTTOMLEFT", 0,TukuiDB.Scale(-2))
				b:SetPoint("TOPRIGHT",b2,"BOTTOMRIGHT", 0,TukuiDB.Scale(-2))
			end
		end
		--print(b:GetName(), " | ", b:GetParent():GetName())
		--MultiCastRecallSpellButton:SetParent(self)
		MultiCastRecallSpellButton:SetPoint("TOPLEFT",b,"BOTTOMLEFT", 0, TukuiDB.Scale(-2))
		MultiCastRecallSpellButton:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT", 0, TukuiDB.Scale(-2))
	-- else
		--print("Horizontal")
		-- for i = 1,4 do
			-- b = _G["MultiCastSlotButton"..i]
			-- b:ClearAllPoints()
--			b:SetParent(self)
			-- if i == 1 then
				--print(b)
				-- b:SetPoint("LEFT",MultiCastSummonSpellButton,"RIGHT",TukuiDB.Scale(2),0)
			-- else
				--print(b)
				-- local b2 = _G["MultiCastSlotButton"..(i-1)]
				-- b:SetPoint("LEFT",b2,"RIGHT",TukuiDB.Scale(2),0)
			-- end
		-- end
		--MultiCastRecallSpellButton:ClearAllPoints()
		--MultiCastRecallSpellButton:SetParent(self)
		-- MultiCastRecallSpellButton:SetPoint("TOP",b,"BOTTOM", TukuiDB.Scale(2), 0)
	-- end

end


