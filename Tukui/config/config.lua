TukuiCF["general"] = {
	["autoscale"] = true,                  -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.78,                    -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["multisampleprotect"] = true,         -- i don't recommend this because of shitty border but, voila!
	["embedright"] = "Recount",				-- Addon to embed to the right frame ("Omen", "Recount", "Skada")
	["recount"] = true,
	["omen"] = true,
	["recountscript"] = 1, 					--0 = off, 1 = shows recount when in-combat(in party or raid instance), 2 = shows recount when out of combat, hides when in-combat(in party or raid instance)
	["classcolortheme"] = false,			--class colored theme for panels
}

TukuiCF["theme"] = { -- trust me, there's a reason I'm doing this now, instead of later
	["CHAT_Font"] = TukuiCF.media.font,		-- Controls: Chat Font ONLY!!
	
	["UF_Font"] = TukuiCF.media.pixelfont, 	-- Controls: Unitframe // Actionbar // Buff+Debuff Fonts
	["UF_FSize"] = 12, 							-- Controls: Font size if NOT using pixel font.
	["UF_FFlag"] = "OUTLINE",				-- "OUTLINE" // "THICKOUTLINE"
	
	["DATA_Font"] = TukuiCF.media.pixelfont, 		-- Controls: Datatext // Chat Tab Fonts
	["DATA_FSize"] = 12,										-- Controls: Font size if NOT using pixel font.
	["DATA_FFlag"] = "", 										-- This is only here for pixel font, never really use flags for other fonts.
	
	["UI_Texture"] = TukuiCF.media.empath,			-- Controls: All UI Textures.
	
	["custom_hover"] = true,									-- True: Uses the custom color below for coloring mouse-over on buttons.
		["hover_color"] = { .8, .2, .2, .5 },				-- False: Uses your class color for coloring mouse-over on buttons.
}

-- THESE ARE RESTRICTIONS FOR PIXEL FONTS -- need to move this dumbass
if TukuiCF.theme.UF_Font == TukuiCF.media.pixelfont then
	TukuiCF.theme.UF_FSize = 12
	TukuiCF.theme.UF_FFlag = "THIN"
end

if TukuiCF.theme.DATA_Font == TukuiCF.media.pixelfont then
	TukuiCF.theme.DATA_FSize = 12
	TukuiCF.theme.DATA_FFlag = "THIN"
end

TukuiCF["panels"] = {
	["tinfowidth"] = 345, -- don't use this here, go inside panels.lua -- i need to re-work it 					
	["shadows"] = true, 					
	
	["bottom_panels"] = true,
}

TukuiCF["skin"] = {	--Skin addons by Darth Android
	["recount"] = true,
	["skada"] = true,
	["dxe"] = true,
	["omen"] = true,
}

TukuiCF["unitframes"] = {
	-- general options
	["enable"] = true,                     -- do i really need to explain this?
	["fontsize"] = 12,						-- default font height for unitframes
	["lowThreshold"] = 20,                 -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = true,         -- enable power text on pvp target only
	["showfocustarget"] = false,           -- show focus's target
	["showtotalhpmp"] = false,             -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                 -- enable smooth bar
	["showthreat"] = true,                 -- enable the threat bar anchored to info left panel.
	["charportrait"] = true,              -- enable character portrait
	["classcolor"] = false,                  -- color unitframes by class
	["healthcolor"] = { .3, .3, .3, 1 }, --color of the unitframe when unicolor theme is enabled
	["combatfeedback"] = true,             -- enable combattext on player and target.
	["playeraggro"] = true,                -- color player border to red if you have aggro on current target.
	["positionbychar"] = true,             -- save X, Y position with /uf (movable frame) per character instead of per account.
	["swingbar"] = false,					--enables swingbar (dps layout only)
	["debuffhighlight"] = true,				--highlight frame with the debuff color if the frame is dispellable
	["showsymbols"] = true,	               -- show symbol.
	["aggro"] = true,                      -- show aggro
	
	-- hunter only plugin
	["mendpet"] = true,						--mend pet duration overlay on pet frame
	
	-- death knight only plugin
	["runebar"] = true,                    -- enable tukui runebar plugin
	
	-- shaman only plugin
	["totemtimer"] = true,                 -- enable tukui totem timer plugin
}

TukuiCF["raidframes"] = {
	["enable"] = true,						-- enable raid frames
	["fontsize"] = 12,						-- default font height for raidframes
	["scale"] = 1,							-- for smaller use a number less than one (0.73), for higher use a number larger than one
	["showrange"] = true,                  -- show range opacity on raidframes
	["hidenonmana"] = false,					-- hide non mana on party/raid frames
	["healcomm"] = true,                  -- enable healcomm4 support on healer layout.
	["raidalphaoor"] = 0.3,                -- alpha of raidframes when unit is out of range
	["gridonly"] = false,                  -- enable grid only mode for all raid layout. TEMP
	["gridhealthvertical"] = true,         -- enable vertical grow on health bar for healer layout
	["showplayerinparty"] = true,          -- show my player frame in party
	["maintank"] = true,                  -- enable maintank
	["mainassist"] = true,                -- enable mainassist
	["showboss"] = true,                   -- enable boss unit frames for PVELOL encounters.
	["disableblizz"] = true,				-- fuck fuck fuckin fuck
}

TukuiCF["auras"] = {
	["auratimer"] = true,                  -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = true,               -- enable auras
	["playershowonlydebuffs"] = true, 		-- only show the players debuffs over the player frame, not buffs (playerauras must be true)
	["playerdebuffsonly"] = true,			-- show the players debuffs on target, and any debuff in the whitelist (see debuffFilter.lua)
	["targetauras"] = true,                -- enable auras on target unit frame
	["minimapauras"] = true,				-- enable minimap auras
	["arenadebuffs"] = true, 				-- enable debuff filter for arena frames
	["raidunitbuffwatch"] = true,       -- track important spell to watch in pve for grid mode.
	["totdebuffs"] = true,                -- enable tot debuffs (high reso only)
	["focusdebuffs"] = true,              -- enable focus debuffs 
}

TukuiCF["castbar"] = {
	["unitcastbar"] = true, -- enable tukui castbar
		["cblatency"] = false, -- enable castbar latency
		["cbicons"] = true, -- enable icons on castbar
		["castermode"] = false, -- makes castbar larger and puts it above the actionbar frame
		["classcolor"] = false, -- classcolor
		["castbarcolor"] = { 0.3, 0.3, 0.3, 1 }, -- Color of player castbar
		["nointerruptcolor"] = { 1, 0.1, 0.1, 0.5 }, -- Color of target castbar
}

TukuiCF["classtimer"] = {
	["enable"] = true,
		["bar_height"] = 17,
		["bar_spacing"] = 1,
		["icon_position"] = 2, -- 0 = left, 1 = right, 2 = Outside left, 3 = Outside Right
		["layout"] = 4, --1 - both player and target auras in one frame right above player frame, 2 - player and target auras separated into two frames above player frame, 3 - player, target and trinket auras separated into three frames above player frame, 4 - player and trinket auras are shown above player frame and target auras are shown above target frame
		["showspark"] = true,
		["cast_suparator"] = true,
		
		["classcolor"] = false,
		["buffcolor"] = {0.3, 0.3, 0.3, 1}, -- if classcolor isnt true
		["debuffcolor"] = {0.69, 0.31, 0.31, 1},
		["proccolor"] = {0.84, 0.75, 0.65, 1},
}

TukuiCF["combattext"] = {
	["showoverheal"] = false, --show over healing?
	["showhots"] = true, -- show hots?
}

TukuiCF["arena"] = {
	["unitframes"] = true,                 -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
	["spelltracker"] = false,               -- enable tukz enemy spell tracker (an afflicted3 or interruptbar alternative)
}

TukuiCF["actionbar"] = {
	["enable"] = true,                     -- enable tukz action bars
		["hotkey"] = true,                     -- enable hotkey display because it was a lot requested
		["rightbarmouseover"] = false,         -- enable right bars on mouse over
		["shapeshiftmouseover"] = false,       -- enable shapeshift or totembar on mouseover
		["hideshapeshift"] = false,            -- hide shapeshift or totembar because it was a lot requested.
		["bottomrows"] = 2,                    -- numbers of row you want to show at the bottom (select between 1, 1.5, 2 only)
		["rightbars"] = 1,                     -- numbers of right bar you want
		["splitbar"] = true,					-- split the third right actionbar into two rows of 3 on the left and right side of the main actionbar
		["showgrid"] = true,                   -- show grid on empty button
		["rightbars_vh"] = false,
		["totem_leftcorner"] = true,			-- Put the totembar in the left high corner, unmoveable! (If True, no matter of verticalshapeshift nor flishapeshift)
		["verticalshapeshift"] = false, -- Orient the shapeshift or totem bar vertically
		["flipshapeshift"] = true, -- Expand shapeshift or totem bar down/left instead of up/right
}

TukuiCF["nameplate"] = {
	["enable"] = true,                     -- enable nice skinned nameplates that fit into tukui
		["showhealth"] = true,					-- show health text on nameplate
		["enhancethreat"] = true,				-- threat features based on if your a tank or not
		["overlap"] = true,				--allow nameplates to overlap
}

TukuiCF["loot"] = {
	["lootframe"] = true,                  -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,              -- reskin the roll frame to fit tukui
	["autogreed"] = true,                  -- auto-dez or auto-greed item at max level.
}

TukuiCF["cooldown"] = {
	["enable"] = true,                     -- do i really need to explain this?
		["treshold"] = 3,                      -- show decimal under X seconds and text turn red
		["expiringcolor"] = { 1, 0, 0 },		--color of expiring seconds turns to 
		["secondscolor"] = { 1, 1, 0 },			--seconds color
		["minutescolor"] = { 1, 1, 1 },			-- minutes color
		["hourscolor"] = { 0.4, 1, 1 },			-- hours color
		["dayscolor"] = { 0.4, 0.4, 1 },		-- days color
}

TukuiCF["datatext"] = {
	["fps_ms"] = 0,                        -- show fps and ms on panels
	["mem"] = 0,                           -- show total memory on panels
	["bags"] = 5,                          -- show space used in bags on panels
	["gold"] = 6,                          -- show your current gold on panels
	["wowtime"] = 0,                       -- show time on panels
	["guild"] = 12,                         -- show number on guildmate connected on panels
	["dur"] = 4,                           -- show your equipment durability on panels.
	["friends"] = 13,                       -- show number of friends connected.
	["dps_text"] = 10,                      -- show a dps meter on panels
	["hps_text"] = 0,                      -- show a heal meter on panels
	["power"] = 8,                         -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 9,                         -- show your haste rating on panels.
	["crit"] = 7,                          -- show your crit rating on panels.
	["avd"] = 3,                           -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                         -- show your armor value against the level mob you are currently targeting
	
	["location"] = true,
		["coords"] = true,
	
	["stat_block"] = true, 			-- new 4 block system in top-right screen for important datatexts only (time/mem/latency/fps)
	["rep_exp"] = false,
	
	["hitrating"] = 11,					-- show your characters hit rating
	["wintergrasp"] = 2,			-- wintergrasp timer text
	["mastery"] = 0,					-- show your characters mastery rating
	["points"] = 1,						-- show your characters honor/conquest/justice points
	
	["classcolor"] = true,
		["color"] = { .2, .4, .7 },
	
	["battleground"] = true,               -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["fontsize"] = 12,                     -- font size for panels.
}

TukuiCF["chat"] = {
	["enable"] = true,                     -- blah
		["whispersound"] = true,               -- play a sound when receiving whisper
		["showbackdrop"] = true,				-- show a backdrop on the chat panels
		["chatwidth"] = 325,					-- width of chat frame
		["chatheight"] = 111,					-- height of chat frame
		["fadeoutofuse"] = true,				-- fade chat text when out of use
		["sticky"] = true,						-- when opening the chat edit box resort to previous channel
	["bubbles"] = true,							--skin blizzard chat bubbles
}

TukuiCF["tooltip"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
		["hidecombat"] = true,                -- hide bottom-right tooltip when in combat
		["hidecombatraid"] = true,				-- only hide in combat in a raid instance
		["hidebuttons"] = false,               -- always hide action bar buttons tooltip.
		["hideuf"] = false,                    -- hide tooltip on unitframes
		["cursor"] = false,                    -- show anchored to cursor
		["colorreaction"] = false,				-- always color border of tooltip by unit reaction
		["xOfs"] = 0,							--X offset
		["yOfs"] = 0,							--Y offset
}

TukuiCF["buffreminder"] = {
	["enable"] = true,                     -- this is now the new innerfire warning script for all armor/aspect class.
		["sound"] = true,                      -- enable warning sound notification for reminder.
		["raidbuffreminder"] = true,			-- buffbar below the minimap, important missing buffs
}

TukuiCF["others"] = {
	["pvpautorelease"] = false,            -- enable auto-release in bg or wintergrasp.
	["sellgrays"] = true,                  -- automaticly sell grays?
	["autorepair"] = true,                 -- automaticly repair?
	["errorenable"] = true,                     -- true to enable this mod, false to disable
	["autoacceptinv"] = true,                 -- auto-accept invite from guildmate and friends.
	["enablemap"] = true,                     -- reskin the map to fit tukui
	["enablebag"] = true,                     -- enable an all in one bag mod that fit tukui perfectly
--	["totembardirection"] = "RIGHT",			-- set to LEFT or RIGHT
	["spincam"] = true,						-- spin camera while afk
	["totembar_vh"] = true,               -- TotemBar vertical
}