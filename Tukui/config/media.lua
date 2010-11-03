TukuiCF["media"] = {
	-- fonts
	["font"] = [=[Interface\Addons\Tukui\media\fonts\arial.ttf]=], -- general font of tukui
	["uffont"] = [[Interface\AddOns\Tukui\media\fonts\uf_font.ttf]], -- general font of unitframes
	["dmgfont"] = [[Interface\AddOns\Tukui\media\fonts\combat_font.ttf]], -- general font of dmg / sct
	["pixelfont"] = [[Interface\AddOns\Tukui\media\fonts\pixelfont.ttf]],
	
	-- textures
	["normTex"] = [[Interface\AddOns\Tukui\media\textures\normTex]], -- texture used for tukui healthbar/powerbar/etc
	["glowTex"] = [[Interface\AddOns\Tukui\media\textures\glowTex]], -- the glow text around some frame.
	["blank"] = [[Interface\AddOns\Tukui\media\textures\blank]], -- the main texture for all borders/panels
	["empath"] = [[Interface\AddOns\Tukui\media\textures\empath]],

	["buttonhover"] = [[Interface\AddOns\Tukui\media\textures\button_hover]],

	-- Color
	["bordercolor"] = { .3,.3,.3,1 }, -- border color of tukui panels
	["backdropcolor"] = { .1,.1,.1,1 }, -- background color of tukui panels
	["fadedbackdropcolor"] = { .03, .03, .03, .7 }, 
	["altbordercolor"] = { .3,.3,.3,1 }, -- alternative border color, mainly for unitframes text panels.
	["backdropfadecolor"] = { .1,.1,.1,0.8 }, --this is always the same as the backdrop color with an alpha of 0.8, see colors.lua
	["valuecolor"] = {23/255,132/255,209/255}, -- color for values of datatexts


	["raidicons"] = [[Interface\AddOns\Tukui\media\textures\raidicons.blp]], -- new raid icon textures by hankthetank
	
	-- sound
	["whisper"] = [[Interface\AddOns\Tukui\media\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\Tukui\media\sounds\warning.mp3]],
}