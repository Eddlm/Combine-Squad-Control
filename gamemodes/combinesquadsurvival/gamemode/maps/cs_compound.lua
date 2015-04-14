
ITEMPLACES = {Vector(1503.660767, -1236.954468, 53.056572), Vector(2307.987793, -399.771088, 45.563347)}
combinespawnzones = {Vector(4111.273926, 1476.617065, 9.482422)}
zonescovered = {Vector(1655.351074, 1792.505493, 18.823072), Vector(729.625977, 163.750000, 0.401537), Vector(2127.364502, 120.411148, 6.362620), Vector(2545.067627, -1246.411987, 1.981143), Vector(1708.075562, 1097.625732, 2.791028)}
HELIPATHS = {Vector(3163.478760, 519.137695, 474.474365),Vector(1719.003296, 1931.211548, 594.918213),Vector(863.858948, 435.957336, 466.349365),Vector(774.040039, -1191.538696, 538.693665),Vector(1801.056152, -1553.289307, 485.869415),Vector(2920.485840, -1029.159546, 488.500427),}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end











---------------------- END OF CONFIGURATION FILE ----------------------
