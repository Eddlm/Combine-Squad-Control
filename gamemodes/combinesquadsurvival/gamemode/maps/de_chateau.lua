

-- Where the combine will spawn.
zonescovered ={

Vector(115.512436, 184.686234, -39.968750),

Vector(2234.495850, 1214.838745, 0.031250),

Vector(654.441345, 1383.377319, 214.031250),

Vector(639.176636, 1573.637451, 0.031250),

Vector(1258.565918, 2665.448730, -7.968750),

Vector(140.502747, 980.966736, 0.031250),

}


ITEMPLACES ={

Vector(1439.544312, -863.770325, -146.039536),


}


-- Positions between the combine will patrol.
combinespawnzones = {

Vector(1541.860718, -1056.785522, -88.000038),

Vector(1308.580322, -886.584717, -136.220139),

}



function MapSetup()
-- Open doors for the NPC
for k, v in pairs(ents.FindByClass("func_door_rotating")) do
print(v:GetClass())
v:SetKeyValue( "spawnflags", "32" )
v:Fire("Open","",0)
end


SpawnProp(Vector(-408.278076, 1040.047729, 0.328558),Angle(-0.029, -42.737, 0.000),'models/props_c17/oildrum001_explosive.mdl')

SpawnProp(Vector(109.065620, 968.773376, 0.391432),Angle(-0.014, 89.773, 0.000),'models/props_c17/oildrum001_explosive.mdl')

SpawnProp(Vector(164.507507, 968.552246, 0.363856),Angle(-0.018, 89.773, 0.000),'models/props_c17/oildrum001_explosive.mdl')



SpawnProp(Vector(1169.732788, 2814.605225, 17.655401),Angle(-0.034, -90.001, 0.023),'models/props_junk/trashdumpster01a.mdl')

SpawnProp(Vector(1250.768188, 2814.219727, 17.673462),Angle(-0.036, -90.430, 0.036),'models/props_junk/trashdumpster01a.mdl')

SpawnProp(Vector(1359.822021, 2791.571289, 17.549402),Angle(0.153, -63.283, 0.091),'models/props_junk/trashdumpster01a.mdl')
SpawnProp(Vector(931.094604, -121.549255, 223.734085),Angle(0.038, 179.999, 0.000),'models/props_wasteland/cafeteria_table001a.mdl')

SpawnProp(Vector(2767.055908, 91.362663, -140.077408),Angle(-0.026, 1.523, 0.124),'models/props_wasteland/laundry_cart001.mdl')




end
