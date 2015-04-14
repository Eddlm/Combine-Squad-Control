
combinespawnzones = {Vector(1827.714844, 1187.326294, -1022.498657)}
zonescovered = {Vector(1176.123291, 2807.665771, -255.598465), Vector(533.990051, 4061.864258, -255.598465), Vector(725.686279, 4060.658447, 0.353055), Vector(-283.214355, 3620.048096, 0.401537)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------
