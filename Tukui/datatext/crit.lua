--------------------------------------------------------------------
-- Crit (Spell or Melee.. or ranged)
--------------------------------------------------------------------

if TukuiCF["datatext"].crit and TukuiCF["datatext"].crit > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.theme.DATA_Font, TukuiCF.theme.DATA_FSize, TukuiCF.theme.DATA_FFlag)
	TukuiDB.PP(TukuiCF["datatext"].crit, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		meleecrit = GetCritChance()
		spellcrit = GetSpellCritChance(1)
		rangedcrit = GetRangedCritChance()
		if spellcrit > meleecrit then
			CritChance = spellcrit
		elseif select(2, UnitClass("Player")) == "HUNTER" then    
			CritChance = rangedcrit
		else
			CritChance = meleecrit
		end
		if int < 0 then
			Text:SetText(format("%.2f", CritChance) .. "%" .. cStart .. tukuilocal.datatext_playercrit)
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end