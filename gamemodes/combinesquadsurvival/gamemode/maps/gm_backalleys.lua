
MAP_PROPS = {'models/props_c17/furnituretable001a.mdl', 'models/props_junk/trashdumpster01a.mdl'}
ITEMPLACES = {Vector(-415.926178, -584.382751, 169.093826)}
combinespawnzones = {Vector(-1329.990112, -761.193481, 1.485870), Vector(1601.009033, 1214.255371, 1.501403), Vector(-812.269714, -208.235184, 1.461334)}
zonescovered = {Vector(-410.895081, -805.954651, 0.401538), Vector(282.956238, -170.151550, 0.401537), Vector(1158.573364, 484.905182, 0.372325), Vector(-672.881653, -548.206482, 128.401535)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------

