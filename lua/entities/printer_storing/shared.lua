--[[
Gemstone Printer created by KoZ
https://github.com/dkoz/gsprinters
]]--
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Storing Printer"
ENT.Author = "KoZ"
ENT.Category = "Oasis RP"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "price" )
	self:NetworkVar( "Entity", 1, "owning_ent" )
end