
ITEMPLACES = {Vector(-636.370300, 962.398560, 52.249218), Vector(905.410034, 1587.446289, 11.881441), Vector(-398.945953, -103.052452, 12.288915), Vector(151.363693, 268.775787, 11.835216), Vector(-920.436890, -1604.423218, 11.840569), Vector(-870.680176, 385.454102, 3.826494)}
combinespawnzones = {Vector(21.350826, 1949.591675, 9.488368)}
zonescovered = {Vector(-28.804056, 108.766930, 8.401537), Vector(14.109657, -1256.756714, 8.401537), Vector(1352.293335, -1299.090454, 0.401541), Vector(1285.954346, 54.228867, 8.363724), Vector(-1467.043823, -1258.531128, 8.401537), Vector(-1455.321045, -46.311668, 8.401540), Vector(-1571.881836, 1451.054932, 0.401537)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
