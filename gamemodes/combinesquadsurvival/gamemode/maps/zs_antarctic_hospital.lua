
ITEMPLACES = {Vector(-310.411743, 548.826050, 70.688103)}
combinespawnzones = {Vector(317.388824, 575.915283, 33.499802)}
zonescovered = {Vector(828.899414, -789.851868, 32.401539), Vector(-515.163635, -313.838593, 32.401539), Vector(7.335999, -572.919800, 176.401535), Vector(12.289578, -1214.128540, 176.401535)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------
