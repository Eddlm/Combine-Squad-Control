
MAP_PROPS = {'models/props_c17/furnituretable001a.mdl', 'models/props_wasteland/kitchen_shelf001a.mdl', 'models/props_wasteland/laundry_cart002.mdl', 'models/props_wasteland/laundry_cart001.mdl', 'models/props_c17/bench01a.mdl', 'models/props_c17/furnituretable003a.mdl'}
ITEMPLACES = {Vector(3667.939697, 1844.952026, 94.260963), Vector(1105.624756, 709.823975, 114.728401), Vector(973.799866, -159.400497, 94.752182)}
combinespawnzones = {Vector(2264.479004, -828.789612, 75.501945), Vector(-420.678741, -946.431213, 79.679901), Vector(1203.898804, -917.916321, 75.467926), Vector(-588.227661, 108.272865, 65.462296), Vector(403.431732, 2879.629883, 75.488113)}
zonescovered = {Vector(1465.033325, 2304.620117, 64.401535), Vector(1395.039917, 186.992249, 64.401535), Vector(497.671509, -356.432037, 64.401535), Vector(118.587875, 1690.424561, 74.401535), Vector(813.775269, 2540.553467, 78.401535)}
HELIPATHS = {Vector(-259.379639, 107.598114, 584.031250),Vector(-312.775604, 1429.741211, 594.031250),Vector(454.245789, 1512.102905, 594.031250),Vector(491.803040, 2601.893555, 448.224091),Vector(1580.817871, 2515.937744, 594.031250),Vector(3585.714844, 2218.928955, 584.031250),Vector(4112.301758, 1757.940186, 594.031250),Vector(1679.272827, 944.484802, 594.031250),Vector(2674.949951, 507.120270, 448.783630),Vector(1660.866943, -841.700500, 594.031250),Vector(514.107727, 1.006531, 584.031250),Vector(469.824951, -840.508179, 610.785400),Vector(2136.049316, 2195.451904, 584.031250),Vector(2498.698486, 2391.972412, 584.031250),}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------

