
zonescovered ={
Vector(1744.653564, -1323.147827, -415.968750),
Vector(385.222107, -466.837311, -143.968750),
Vector(562.768127, -689.248169, -143.968750),
Vector(764.469727, 565.512695, -191.968750),
Vector(125.047203, 733.100891, -231.968750),
Vector(2115.724365, 511.861481, -329.968750),
Vector(3076.959473, -10.519232, -415.968750),
Vector(1758.782349, -1060.165771, -223.968750),
Vector(1967.932251, 144.939438, -223.968750),
Vector(2211.334473, -254.156982, -223.968750),
Vector(2143.618164, -207.926666, -351.968750),
Vector(1566.118652, -647.241699, -223.968750),
Vector(2106.572266, -821.033020, -415.968750),
Vector(2085.751953, -1566.063843, -415.968750),
Vector(3324.902344, -573.454956, -415.968750),
Vector(2401.308838, 970.505188, -319.968750),
Vector(597.373108, 664.593628, -231.968750),
Vector(-54.674984, -333.557983, -142.989548),
Vector(619.507568, -176.015442, -221.206787),
Vector(880.959717, -1572.867798, -335.968750),
}

ITEMPLACES ={
Vector(-41.521809, 752.603333, -295.533325),
Vector(807.907104, 648.964233, -220.978485),
Vector(2497.378906, 927.986938, -365.975616),
Vector(3276.861816, -281.494781, -419.867035),
Vector(2136.873535, -694.075073, -426.954712),
Vector(1878.545044, -1256.778442, -438.866943),
Vector(1842.226929, -1057.890991, -252.542831),
Vector(1991.743286, -382.464508, -376.698853),
}

combinespawnzones = {
Vector(-10.309028, 291.098389, -231.968750),
Vector(-7.900296, 455.145752, -231.968750),
Vector(186.566238, 454.592224, -231.968750),
Vector(147.195541, 353.380493, -221.231689),
}


function MapSetup()
table.foreach(SPAWNPOINTS_TO_DELETE, function(key,value)
for k, v in pairs(ents.FindByClass(value)) do
print(v:GetClass())
v:Remove()
end
end)

for k, v in pairs(ents.FindByClass("func_door")) do
print(v:GetClass())
v:Remove()
end

end