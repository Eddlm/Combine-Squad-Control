
ITEMPLACES = {Vector(1080.741455, -58.925888, 58.137016), Vector(1328.265381, -446.222046, 58.121132), Vector(620.005615, -463.779175, 58.133911), Vector(402.310730, -445.175842, 56.834805), Vector(194.930634, -478.360504, 58.121693), Vector(-15.951973, -459.568634, 58.130882), Vector(-236.018753, 160.843109, 67.851234), Vector(-223.178909, 75.941292, 69.121689), Vector(765.904175, 1741.692383, 68.118889), Vector(1190.713257, 917.931274, 69.844261), Vector(973.313904, 495.519287, 55.827621)}
combinespawnzones = {Vector(1769.684204, -1344.464233, 16.472435), Vector(-781.026733, -1335.960327, 16.500092), Vector(-1011.061279, 2010.959595, 16.500391), Vector(1982.147583, 2054.352295, 16.449110)}
zonescovered = {Vector(1944.368286, 649.687012, 17.356804), Vector(874.184265, -1063.538940, 15.359902), Vector(867.490845, -305.003052, 17.401537), Vector(-184.922348, -134.963898, 17.401539), Vector(-531.590515, 1061.553955, 17.401537), Vector(80.929085, 616.410950, 17.368477), Vector(1287.235840, 621.183777, 17.372091)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
table.foreach(SPAWNPOINTS_TO_DELETE, function(key,value) for k, v in pairs(ents.FindByClass(value)) do print(v:GetClass()) v:Remove() end end)
SpawnItem('info_player_start', Vector(-672.468506, -746.431580, 46.638386),Angle(-0.000, 0.000, 0.000))
SpawnItem('info_player_start', Vector(-384.966888, 1143.987305, 50.515690),Angle(-0.000, 180.000, 0.000))
SpawnItem('info_player_start', Vector(565.600952, 1416.316895, 62.518112),Angle(-0.000, -180.000, 0.000))
end