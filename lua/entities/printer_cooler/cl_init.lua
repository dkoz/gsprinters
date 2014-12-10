--[[
Gemstone Printer created by KoZ
https://github.com/dkoz/gsprinters
]]--
include("shared.lua")

function ENT:Initialize()
	surface.CreateFont( "EntityNameTitle", {
		font = "Tahoma",
		size = 18,
		weight = 1000,
		antialias = true
	} )	
	surface.CreateFont( "EntityNameDesc", {
		font = "Tahoma",
		size = 12,
		weight = 500,
		antialias = true
	} )
end

function ENT:Draw()
	self:DrawModel()
end

function DrawCoolerInfo()
	local tr = LocalPlayer():GetEyeTrace()
	if IsValid(tr.Entity) and tr.Entity:GetPos():Distance(LocalPlayer():GetPos()) < 200 then
		if tr.Entity:GetClass() == "printer_cooler" then
			local ent = tr.Entity
			local pos = ent:GetPos()

			pos.z = pos.z
			pos = pos:ToScreen()

			local Name = "Printer Cooler"
			local Description =  "Put this in your printer"

		    cam.Start2D()
				draw.DrawText(Name, "EntityNameTitle", pos.x, pos.y -20, Color(255, 255, 255, 200), 1)
				draw.DrawText(Description, "EntityNameDesc", pos.x, pos.y, Color(255, 255, 255, 200), 1)
			cam.End2D()
		end
	end
end
hook.Add( "HUDPaint", "DrawCoolerInfo", DrawCoolerInfo ) 

function ENT:Think()
end