--[[
Gemstone Printer created by KoZ
https://github.com/dkoz/gsprinters
]]--
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/Items/battery.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
	
	self.IsCooler = true
	self.damage = 10
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if ( self.damage <= 0 ) then
		self:Remove()
	end
end

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "printer_cooler" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Use( activator )
	if IsValid( activator ) and activator:IsPlayer() then
		DarkRP.notify( activator, 1, 4, "Put this cooler into your printer." )
	end
end