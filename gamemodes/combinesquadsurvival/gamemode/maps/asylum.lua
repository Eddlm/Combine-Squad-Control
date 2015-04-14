
ITEMPLACES = {Vector(217.649460, -1677.070923, 89.326477)}
combinespawnzones = {Vector(-973.818665, 276.088226, 65.398499), Vector(-969.011475, -1688.793701, 65.464142)}
zonescovered = {Vector(900.985474, -1703.404785, 64.382431), Vector(-709.762512, -1015.269775, 64.397614), Vector(166.937012, -2.339377, 64.401535), Vector(202.671326, -656.882019, 192.401535), Vector(722.267883, -1037.449341, 192.396179), Vector(-133.288071, -1030.145752, 192.401535), Vector(113.060074, -731.453979, -151.634094), Vector(51.586914, -186.878784, -151.598465)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end
---------------------- END OF CONFIGURATION FILE ----------------------

