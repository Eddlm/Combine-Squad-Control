
combinespawnzones = {Vector(-352.544830, -793.676331, 54.480869)}
zonescovered = {Vector(-1404.793945, -729.850586, 120.367867), Vector(-1557.996704, -760.031982, 272.401550), Vector(-1189.744751, -322.699249, 120.401535)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------
