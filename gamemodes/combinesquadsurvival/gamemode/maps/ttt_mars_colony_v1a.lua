

ITEMPLACES ={
Vector(-2968.660889, -1021.968994, -25.418840),
Vector(-1317.194824, -1096.616821, -85.239471),
Vector(-1203.288452, 1582.665649, 34.602936),
Vector(-604.178345, 1098.507568, 38.623512),
Vector(-826.972168, -1022.266113, -75.583145),
Vector(-1389.274780, -93.002090, -29.496500),
Vector(-2194.375000, -154.355927, 2.361422),
Vector(-2817.805176, -212.348709, 100.911423),
Vector(-3603.481934, -476.376495, 103.065292),
Vector(-3926.722900, 703.649719, 98.401726),
Vector(-422.466431, 1256.267700, 32.216370),
}
 
 
zonescovered ={
Vector(-1345.426514, -1315.144653, -63.968750),
Vector(-905.129822, -980.850342, -63.968750),
Vector(-2134.881592, -476.972198, 0.031250),
Vector(-2281.596191, -122.323334, 0.031250),
Vector(-2764.894531, -276.566956, 128.031250),
Vector(-3510.256836, -134.464584, 112.031250),
Vector(-3830.934326, -584.493652, 128.031250),
Vector(-3591.295654, 832.363403, 128.040588),
Vector(-2761.721680, -601.502502, 12.031250),
Vector(-3028.178955, -1167.298462, 0.031250),
Vector(-1538.169434, -60.250244, 0.031250),
Vector(-1991.583130, 427.616638, 0.031250),
Vector(-852.699707, 440.033325, 64.031250),
Vector(-476.991486, -198.250275, 128.031250),
Vector(-502.537109, 194.920837, 64.031250),
Vector(-569.223633, 1296.462524, 64.031250),
Vector(-848.882080, 1188.708252, 64.031250),
Vector(139.568130, 461.569244, 192.031250),
Vector(-1208.019043, 1520.844727, 64.031250),
Vector(-1790.804199, 1377.626465, 64.031250),
Vector(-617.517334, 1047.024780, 64.031250),
}

combinespawnzones = {
Vector(-1350.888916, -1457.321777, -63.968750),
Vector(-1456.172485, -1457.663208, -63.968750),
Vector(-1555.500610, -1456.381348, -63.968750),
}


function MapSetup()


for k, v in pairs(ents.FindByClass("trigger_hurt")) do
print(v:GetClass())
v:SetKeyValue( "spawnflags", "1" )
end

for k, v in pairs(ents.FindByModel("*128")) do
print(v:GetClass())
v:SetKeyValue( "spawnflags", "1024" )
end

for k, v in pairs(ents.FindByModel("*127")) do
print(v:GetClass())
v:SetKeyValue( "spawnflags", "1024" )
end

for k, v in pairs(ents.FindByModel("*185")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*184")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*248")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*247")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*193")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*194")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*192")) do
print(v:GetClass())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*191")) do
print(v:GetClass())
v:Remove()
end

end

