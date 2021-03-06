--------------------------------------------------------------------
-- FPS
--------------------------------------------------------------------

if TukuiCF["datatext"].fps_ms and TukuiCF["datatext"].fps_ms > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.theme.DATA_Font, TukuiCF.theme.DATA_FSize, TukuiCF.theme.DATA_FFlag)
	TukuiDB.PP(TukuiCF["datatext"].fps_ms, Text)

	local int = 1
	local function Update(self, t)
		int = int - t
		if int < 0 then
			Text:SetText(floor(GetFramerate())..tukuilocal.datatext_fps..select(3, GetNetStats())..tukuilocal.datatext_ms)
			int = 1
		end	
	end

	Stat:SetScript("OnUpdate", Update) 
	Update(Stat, 10)
end