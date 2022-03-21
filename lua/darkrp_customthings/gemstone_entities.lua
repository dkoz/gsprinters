--[[
	DarkRP Gemstone Printers - https://github.com/dkoz/gsprinters
	Created by Koz - http://steamcommunity.com/profiles/76561197989811664
--]]

AddCSLuaFile()

if (gemstone.config.entityenable) then
	DarkRP.createCategory{
		name = "Gemstone Printers",
		categorises = "entities",
		startExpanded = true,
		color = Color(0, 107, 0, 255),
		canSee = function(ply) return true end,
		sortOrder = 1
	}

	DarkRP.createEntity("Topaz Printer", {
			ent = "topaz_money_printer",
			model = "models/props_c17/consolebox01a.mdl",
			price = 1000,
			max = 2,
			cmd = "buytopazprinter",
			category = "Gemstone Printers"
	})
	 
	DarkRP.createEntity("Amethyst Printer", {
			ent = "amethyst_money_printer",
			model = "models/props_c17/consolebox01a.mdl",
			price = 1500,
			max = 2,
			cmd = "buyamethystprinter",
			category = "Gemstone Printers"
	})
	 
	DarkRP.createEntity("Emerald Printer", {
			ent = "emerald_money_printer",
			model = "models/props_c17/consolebox01a.mdl",
			price = 2500,
			max = 2,
			cmd = "buyemeraldprinter",
			category = "Gemstone Printers"
	})
	 
	DarkRP.createEntity("Ruby Printer", {
			ent = "ruby_money_printer",
			model = "models/props_c17/consolebox01a.mdl",
			price = 5000,
			max = 2,
			cmd = "buyrubyprinter",
			category = "Gemstone Printers"
	})
	 
	DarkRP.createEntity("Sapphire Printer", {
			ent = "sapphire_money_printer",
			model = "models/props_c17/consolebox01a.mdl",
			price = 7500,
			max = 2,
			cmd = "buysapphireprinter",
			category = "Gemstone Printers"
	})
end