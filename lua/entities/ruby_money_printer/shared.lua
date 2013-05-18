ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Ruby Printer"
ENT.Author = "KoZ & !!!WARLOCK!!!"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",1,"owning_ent")
end