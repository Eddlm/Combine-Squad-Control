
ITEMPLACES ={
Vector(260.395447, -449.167542, -114.654221),
Vector(-1491.483643, 2460.523682, -100.896202),
Vector(1283.552124, 1580.317627, -115.029411),
Vector(1653.499634, 673.173157, -127.531509),
Vector(813.082397, -415.036285, -127.500725),
Vector(-763.697083, 199.571045, -63.548870),
}

zonescovered ={
Vector(692.041809, 331.152344, 0.031250),
Vector(897.284973, 969.294495, 0.031250),
Vector(580.910034, 1447.050537, 0.031250),
Vector(614.122009, 1161.949341, 0.031250),
Vector(72.399956, 923.382141, -63.968750),
Vector(162.567734, 1319.612915, -63.968750),
Vector(-345.599365, 1321.278687, -63.968750),
Vector(-644.072876, 944.418457, -63.968750),
Vector(159.490997, 1306.871704, 64.031250),
Vector(139.814880, 890.817200, 64.031250),
Vector(-545.291443, 896.863159, 64.031250),
Vector(-842.104370, 1038.510132, 64.031250),
Vector(-855.219910, 1032.797729, 208.031250),
Vector(-671.058289, 878.467590, 208.031250),
Vector(-552.741821, 1353.039429, 208.031250),
Vector(-269.780151, 951.031250, 208.031250),
Vector(146.364822, 905.388977, 208.031250),
Vector(-378.594513, 1363.067627, 208.031250),
Vector(-130.098099, 1362.281128, 208.031250),
Vector(40.240696, 1322.626099, 208.031250),
Vector(-253.772034, 1538.442017, 208.031250),
Vector(961.306335, 1029.690063, 144.031250),
Vector(-255.548874, 1527.807739, 352.031250),
Vector(-253.872986, 951.242859, 352.031250),
Vector(165.039307, 1254.968384, 352.031250),
Vector(-675.424377, 950.593750, 352.031250),
Vector(-607.079407, 907.842407, 496.031250),
Vector(207.535797, 1216.182251, 496.031250),
Vector(2.681413, 1519.860840, 64.031250),
Vector(-118.233101, 859.008057, 64.031250),
Vector(-280.053070, -373.174500, -59.546013),
Vector(-1665.723755, 1076.442261, -59.963097),
Vector(-1709.579346, 2689.160889, -37.187546),
Vector(-116.966499, 2546.804688, -65.286118),
Vector(1290.145752, 2659.480469, -63.968758),
Vector(1740.869019, 407.841705, -42.937050),
Vector(1686.400391, -709.175598, -35.073494),
Vector(-986.820190, 1288.811157, 0.031250),
}

combinespawnzones = {
Vector(-1458.343384, -200.453842, -55.968750),
Vector(-1532.885742, -190.577728, -55.968750),
Vector(-1461.385376, -398.373108, -55.968750),
Vector(-1567.804321, -398.151093, -55.968750),
}


function MapSetup()


for k, v in pairs(ents.FindByModel("models/props_wasteland/kitchen_shelf001a.mdl")) do
print(v:GetModel())
v:Remove()
end

for k, v in pairs(ents.FindByModel("models/props_c17/door02_double.mdl")) do
print(v:GetModel())
v:Remove()
end

for k, v in pairs(ents.FindByModel("models/props_debris/wood_board05a.mdl")) do
print(v:GetModel())
v:Remove()
end

for k, v in pairs(ents.FindByModel("models/props_debris/wood_board06a.mdl")) do
print(v:GetModel())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*51")) do
print(v:GetModel())
v:Remove()
end

for k, v in pairs(ents.FindByModel("*50")) do
print(v:GetModel())
v:Remove()
end

if math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(845.247864, 895.478088, -12.058261), Angle(0.033, -90.015, 0.100) )
	elseif math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(-447.480011, 1035.645264, -78.312576), Angle(0.109, 0.171, 0.354) )
	else
		SpawnItem("item_healthcharger", Vector(-464.475433, 956.532166, 49.881882), Angle(-0.127, 179.836, 0.412) )
end
if math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(1007.502808, 1164.372681, 128.785446), Angle(0.140, -179.906, 0.294) )
	elseif math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(-460.903503, 1408.430908, 196.072861), Angle(0.224, 89.674, 0.040) )
	else
		SpawnItem("item_healthcharger", Vector(-568.525696, 1110.423828, 339.464020), Angle(0.144, 179.839, -0.295) )
end
if math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(-431.640381, 1166.069336, 480.837982), Angle(0.043, 0.052, -0.102) )
	elseif math.random (1,2) == 1 then 
		SpawnItem("item_healthcharger", Vector(-1644.510498, -556.591064, -82.366676), Angle(0.020, 179.974, 0.083) )
	else
		SpawnItem("item_healthcharger", Vector(351.849243, 1344.465088, -14.653479), Angle(0.198, 90.039, -0.243) )
end

end
