
ITEMPLACES = {Vector(-109.078072, 2504.401123, 179.841248), Vector(154.565262, 1630.511475, 180.028503), Vector(-403.521210, 1506.922119, 179.860535), Vector(-438.187958, 613.232971, 307.838562), Vector(-607.325562, 242.663681, 245.103134), Vector(-437.991943, -712.409790, 52.944553)}
combinespawnzones = {Vector(1980.711670, 1954.018555, 129.444717), Vector(1987.310913, 1733.789673, 129.476379)}
zonescovered = {Vector(1304.797974, 1820.015869, 128.401535), Vector(-180.678116, -590.699158, 0.401537), Vector(-396.199371, 1239.543457, 384.401550), Vector(127.648079, 2411.204102, 128.357101), Vector(56.664288, -20.847315, -9.572457), Vector(-893.095947, 1625.777344, 128.401535), Vector(-749.717468, 2567.017334, 320.401550), Vector(-363.382690, 133.517197, 192.401535)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
SpawnItem('weapon_shotgun',Vector(-342.928955, 1048.127197, 406.894226),Angle(1.626, 3.097, -93.028))
SpawnItem('item_healthcharger', Vector(188.629547, 643.968750, 306.275513),Angle(0.000, -90.000, 0.000))
end
---------------------- END OF CONFIGURATION FILE ----------------------

