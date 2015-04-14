

ITEMPLACES = {Vector(1303.414795, 514.728027, 41.256264), Vector(323.836639, 1622.189941, 41.290142), Vector(-106.584045, 2167.767822, 36.881702), Vector(-1089.017578, 361.080170, 46.449505), Vector(-229.632599, 2170.161621, 245.325653), Vector(-366.730652, 2171.765625, 244.232178)}
combinespawnzones = {Vector(634.551331, -877.087402, 1.484519), Vector(15.313951, -870.941650, 1.455629), Vector(-1218.387817, 889.694092, 1.499800)}
zonescovered = {Vector(85.077866, 553.910889, 16.401537), Vector(-65.455811, 1769.323242, 23.620949), Vector(-1278.188843, 422.906158, 0.401537)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

timer.Simple(2, function()
table.foreach(ents.GetAll(), function(key,value)
if value:EntIndex() == 518 then 
value:Remove() 
end
end)
end)

SpawnItem('item_healthcharger', Vector(-161.968765, 2117.303955, 66.275490),Angle(0.000, 0.000, 0.000))

end
---------------------- END OF CONFIGURATION FILE ----------------------
