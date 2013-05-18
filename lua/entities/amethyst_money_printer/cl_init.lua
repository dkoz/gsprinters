include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self.Entity:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
    local owner = self.dt.owning_ent
	owner = (IsValid(owner) and owner:Nick()) or "unknown"
	
	txt1 = "Amethyst Printer"
	txt2 = "$" ..self:GetNWInt("PrintA")
	
	surface.SetFont("HUDNumber5")
	local TextWidth = surface.GetTextSize(txt1)
	local TextWidth2 = surface.GetTextSize(txt2)
	local TextWidth3 = surface.GetTextSize(owner)
	
	Ang:RotateAroundAxis(Ang:Up(), 90)
	
	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
	    draw.WordBox(2, -TextWidth3*0.5, -78, owner, "HUDNumber5", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth*0.5, -30, txt1, "HUDNumber5", Color(0, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5, 18, txt2, "HUDNumber5", Color(0, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
end

function ENT:Think()
end