
zonescovered ={
Vector(57.791965, 452.627563, -292.868225),
Vector(-476.973480, 366.857666, -319.968750),
Vector(245.742905, 286.338104, 64.031250),
Vector(846.063599, -109.995544, 64.031250),
Vector(581.763611, 731.464722, 70.784836),
Vector(204.127457, 1014.830994, 64.031250),
Vector(-205.777939, 987.058533, 64.031250),
Vector(-1125.929199, 787.080933, 64.031250),
Vector(-837.405396, 456.573456, 75.769165),
Vector(-496.465790, 0.806757, 64.031250),
Vector(-16.154320, 464.753571, 64.031250),
Vector(-657.451355, 879.217896, 68.937576),
Vector(273.822998, -198.415970, 64.031250),
Vector(192.427109, 631.149353, 64.031250),
Vector(-209.801208, 604.506836, 64.031250),
Vector(-0.762461, 211.799591, -291.968750),
}

ITEMPLACES ={
Vector(773.413757, -199.495712, 2.628300),
Vector(554.757324, 347.635803, 41.027058),
Vector(-163.225311, 440.898315, -3.501307),
Vector(180.391022, 217.402237, 60.095245),
Vector(-174.373856, 274.715851, 23.514084),
Vector(-1012.973206, 923.218262, 2.425853),
Vector(312.262726, 384.127197, -339.184387),
Vector(-636.495361, 763.914246, 64.738464),
}

combinespawnzones = {
Vector(261.247437, 281.490997, -319.968750),
Vector(215.115677, 420.200775, -319.968750),
Vector(-45.083946, 518.354919, -291.968750),
Vector(-13.638227, 234.005829, -291.968750),
}

function MapSetup()


for k, v in pairs(ents.FindByClass("func_door_rotating")) do
print(v:GetClass())
v:Remove()
end

if math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(-1263.469360, 980.469299, 52.896736), Angle(-0.000, 0.000, 0.262) )
	elseif math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(-308.005432, -111.539223, 50.918354), Angle(-0.011, 89.982, -0.240) )
	else
		SpawnItem("item_healthcharger", Vector(436.787933, -223.473618, 53.046143), Angle(0.040, 89.945, 0.069) )
end
if math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(169.260956, 160.497589, -300.695007), Angle(-0.012, 90.214, 0.079) )
	elseif math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(144.524307, 686.092163, 53.791191), Angle(0.059, -0.083, -0.513) )
	else
		SpawnItem("item_healthcharger", Vector(-144.485352, 945.574463, 51.353291), Angle(0.020, 179.760, 0.061) )
end

SpawnStaticProp(Vector(-1313.221558, -1243.587769, -310.317780),Angle(0,0,0),"models/props_junk/trashdumpster01a.mdl")
SpawnStaticProp(Vector(-1313.120972, -1328.330322, -310.333618),Angle(0,0,0),"models/props_junk/trashdumpster01a.mdl")

end