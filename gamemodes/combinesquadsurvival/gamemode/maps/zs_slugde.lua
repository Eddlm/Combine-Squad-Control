
ITEMPLACES = {Vector(-1700.066040, 1066.987061, 325.412781)}
combinespawnzones = {Vector(375.522705, 298.510437, 321.501343), Vector(380.202637, 537.427856, 321.464600), Vector(364.755127, 792.677551, 321.450745)}
zonescovered = {Vector(215.121292, 1249.623901, 320.401550), Vector(-714.542114, -1108.784424, 256.401550), Vector(-1776.526489, -232.513412, 256.401550), Vector(-1061.606445, 1448.170288, 320.401550), Vector(411.976074, -1189.082275, 320.364410)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end end