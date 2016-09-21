--[[
	DarkRP Gemstone Printers - https://github.com/dkoz/gsprinters
	Created by Koz - http://steamcommunity.com/profiles/76561197989811664
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Emerald Printer"
ENT.Author = "KoZ"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",1,"owning_ent")
end