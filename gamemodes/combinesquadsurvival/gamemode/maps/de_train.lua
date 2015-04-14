
ITEMPLACES = {Vector(-1623.945435, 1620.066284, -189.233459),Vector(-888.505859, 756.167236, 78.152405), Vector(-890.759949, 884.608337, 78.153259), Vector(-745.396057, 407.983063, 50.804699)}
combinespawnzones = {Vector(1445.516602, 1582.675293, -222.590576)}
zonescovered = {Vector(-1732.100952, 1402.302124, -227.953171), Vector(170.486710, 61.308701, -215.622513), Vector(-154.821671, -1404.090820, -351.598450), Vector(1918.471191, 217.934555, -215.598465)}
zonescovered = {Vector(-1732.100952, 1402.302124, -227.953171), Vector(170.486710, 61.308701, -215.622513), Vector(-154.821671, -1404.090820, -351.598450), Vector(1918.471191, 217.934555, -215.598465)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end
---------------------- END OF CONFIGURATION FILE ----------------------
