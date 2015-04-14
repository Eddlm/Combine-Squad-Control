
ITEMPLACES = {Vector(-754.644409, 2992.507080, 38.340076)}
combinespawnzones = {Vector(-1706.499634, 3568.995117, 1.488960)}
zonescovered = {Vector(12.003983, 223.564133, 0.401537), Vector(-1387.635742, -9.821785, 0.349936), Vector(2478.219727, 991.750732, 0.374813), Vector(-289.176239, 2430.446777, 0.401537), Vector(56.992546, -1416.461182, 0.401537)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------
