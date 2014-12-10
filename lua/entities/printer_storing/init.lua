--[[
Gemstone Printer created by KoZ
https://github.com/dkoz/gsprinters
]]--
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SeizeReward = 950

local PrintMore
function ENT:Initialize()
	self:SetModel( "models/props_c17/consolebox01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
	self.damage = 100
	self.IsMoneyPrinter = true
	timer.Simple( 10.0, function() PrintMore( self ) end )
	
	-- Printer Functions
	self:SetNWInt( "PrintA", 0 )
	self:SetNWInt( "Health", 100 )
	self:SetNWInt( "Cooler", 50 )
end

function ENT:StartTouch(hitEnt)
	if hitEnt.IsCooler then
		self.Cooler = hitEnt
		local CoolantLevels = self:GetNWInt( "Cooler" )
		local amount = CoolantLevels + 50
		self:SetNWInt( "Cooler", amount ) 
		self.Cooler:Remove()
	end
end

function ENT:OnTakeDamage(dmg)
	if self.burningup then return end

	self.damage = (self.damage or 100) - math.ceil(dmg:GetDamage())
	self:SetNWInt( "Health", self.damage )
	if self.damage <= 0 then
		self:SetNWInt("Health", 0)
		local rnd = math.random(1, 10)
		if rnd < 6 then
			self:BurstIntoFlames()
		else
			self:Destruct()
			self:Remove()
		end
	end
end

function ENT:Destruct()
	local destruct = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(destruct)
	effectdata:SetOrigin(destruct)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
	DarkRP.notify(self:Getowning_ent(), 1, 4, "Your money printer has exploded!")
end

function ENT:BurstIntoFlames()
	DarkRP.notify(self:Getowning_ent(), 1, 4, "Your money printer is overheating!")
	self.burningup = true
	local burntime = math.random( 8, 18 )
	self:Ignite( burntime, 0 )
	timer.Simple( burntime, function() self:Remove() end )
end

PrintMore = function(ent)
	if IsValid(ent) then
		timer.Simple( 1.0, function() ent:CreateMoneybag() end )
	end
end

function ENT:CreateMoneybag()
	if not IsValid(self) then return end
	if self:IsOnFire() then return end
	if math.random( 1, 300 ) == 3 then self:BurstIntoFlames() end
	
	if self.IsValid then
		local amount = self:GetNWInt("PrintA") + math.random( 15, 25 )
		self:SetNWInt( "PrintA", amount )
		
		local coolerempty = self:GetNWInt( "Cooler" ) - 2
		self:SetNWInt( "Cooler", coolerempty )
		
		timer.Simple( math.random( 10, 15 ), function() PrintMore(self) end )
		
		timer.Simple( 2, function()
			if self.damage <= 99 then
				self.damage = self.damage + 1
				self:SetNWInt( "Health", self.damage )
			end
		end )
		
		timer.Simple( 2, function()
			if coolerempty <= 0 then
				self.damage = self.damage - math.random( 10, 50 )
				self:SetNWInt( "Health", self.damage )
			end
		end )
	end
end

function ENT:Think()
	local cooler = self:GetNWInt( "Cooler" )
	if cooler > 100 then
		self:SetNWInt( "Cooler", 100 )
	end
	
	if cooler < 0 then
		self:SetNWInt( "Cooler", 0 )
	end
	
	if self.damage < 0 then
		self:Destruct()
		self:Remove()
		return
	end
end

function ENT:Use( activator )
	if ( activator:IsPlayer() ) and self:GetNWInt( "PrintA" ) >= 1 then
		activator:addMoney( self:GetNWInt( "PrintA" ) )
		activator:EmitSound( "ambient/machines/keyboard7_clicks_enter.wav", 50, 100 )
		DarkRP.notify( activator, 1, 4, "You have collected " .. GAMEMODE.Config.currency .. self:GetNWInt( "PrintA" ) .. " from your printer." )
		self:SetNWInt( "PrintA", 0 )
	end
end