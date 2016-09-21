--[[
	DarkRP Gemstone Printers - https://github.com/dkoz/gsprinters
	Created by Koz - http://steamcommunity.com/profiles/76561197989811664
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SeizeReward = 950

local PrintMore
function ENT:Initialize()
	local tcolor = gemstone.config.topazcolor

	self:SetModel("models/props_c17/consolebox01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor( tcolor )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
	self.damage = 100
	self.IsMoneyPrinter = true
	timer.Simple(1.0, function() PrintMore(self) end)
	self:SetNWInt("PrintA",0)
	
	self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
	self.sound:SetSoundLevel(52)
	self.sound:PlayEx(1, 100)
end

function ENT:OnTakeDamage(dmg)
	if self.burningup then return end

	self.damage = (self.damage or 100) - dmg:GetDamage()
	if self.damage <= 0 then
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
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
	DarkRP.notify(self:Getowning_ent(), 1, 4, "Your money printer has exploded!")
end

function ENT:BurstIntoFlames()
	DarkRP.notify(self:Getowning_ent(), 1, 4, "Your money printer is overheating!")
	self.burningup = true
	local burntime = math.random(8, 18)
	self:Ignite(burntime, 0)
	timer.Simple(burntime, function() self:Fireball() end)
end

function ENT:Fireball()
	if not self:IsOnFire() then self.burningup = false return end
	local dist = math.random(5, 50) -- Explosion radius
	self:Destruct()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
		if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
			v:Ignite(math.random(5, 22), 0)
		elseif v:IsPlayer() then
			local distance = v:GetPos():Distance(self:GetPos())
			v:TakeDamage(distance / dist * 100, self, self)
		end
	end
	self:Remove()
end

PrintMore = function(ent)
	if IsValid(ent) then
		ent.sparking = true
		timer.Simple(1.0, function() ent:CreateMoneybag() end)
	end
end

function ENT:CreateMoneybag()
	if not IsValid(self) then return end
	if self:IsOnFire() then return end
	local MoneyPos = self:GetPos()
	local printamount = gemstone.config.topazprintamount
	local printtime = gemstone.config.topazprinttime
	if math.random(1, 1000) == 3 then self:BurstIntoFlames() end
	local amount = self:GetNWInt("PrintA") + printamount
	self:SetNWInt("PrintA",amount)
	self.sparking = false
	timer.Simple(printtime, function() PrintMore(self) end)
end

function ENT:Use(activator)
	if(activator:IsPlayer()) and self:GetNWInt("PrintA") >= 1 then
	activator:addMoney(self:GetNWInt("PrintA"));
	DarkRP.notify(activator, 1, 4, "You have collected $"..self:GetNWInt("PrintA").." from a Topaz Printer.")
	self:SetNWInt("PrintA",0)
	end
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end