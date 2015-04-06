combinespawnzones = {Vector(-1427.824707, 5277.320801, -496.543945), Vector(-1127.181641, 5288.172852, -496.521484), Vector(1444.855835, 254.236572, 65.442245), Vector(-2016.101807, -2949.724854, 65.439636)}
zonescovered = {Vector(-3165.180664, 4649.455078, -360.020355), Vector(636.770447, 4911.435059, -386.598450), Vector(1208.260010, 1312.215210, 64.401543), Vector(1177.537598, -1313.747437, 64.401535), Vector(-1818.619385, 2306.981445, -311.059692), Vector(306.617767, -1105.526245, 72.401543), Vector(-346.442261, -313.651337, 552.401550), Vector(-2708.402100, 1128.011719, 296.396088), Vector(-803.308167, 496.434967, -183.626404), Vector(1048.672729, 597.146118, -183.639511), Vector(-2078.178955, -2444.266602, 64.401535), Vector(-2175.638428, 864.221191, 88.401535), Vector(-3874.090576, 2232.397705, -87.594521)}
/*
function GM:PlayerInitialSpawn(ply)
timer.Simple(2, function() ply:PrintMessage(HUD_PRINTTALK, '[Overwatch]: Protection team alert, evidence of anticivil activity in this community.') end )
timer.Simple(4, function() ply:PrintMessage(HUD_PRINTTALK, '[Overwatch]: Code: assemble, plan, contain.') end )
timer.Simple(10, function()ply:PrintMessage(HUD_PRINTTALK, 'Type !help to see the game mechanics.') end)
end

function MapSetup()
--for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
table.foreach(combinespawnzones, function(key,value) for k, v in pairs(ents.FindByClass(value)) do print(v:GetClass()) v:Remove() end end)

table.foreach(SPAWNPOINTS_TO_DELETE, function(key,value) for k, v in pairs(ents.FindByClass(value)) do print(v:GetClass()) v:Remove() end end)

SpawnItem('info_player_start', Vector(-3764.723877, 5326.575684, -351.583984),Angle(-0.000, -90.000, 0.000))
SpawnItem('info_player_start', Vector(-2519.651855, 1072.567261, 100.049065),Angle(-0.000, 180.000, 0.000))
SpawnItem('info_player_start', Vector(-1976.194336, 568.351074, -106.872360),Angle(0.000, 0.000, 0.000))

end
*/