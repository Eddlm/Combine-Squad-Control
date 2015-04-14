
ITEMPLACES = {Vector(-371.462646, -129.331665, 58.880798)}
combinespawnzones = {Vector(-2494.333008, 1111.719238, 17.448656), Vector(-2507.098145, 1455.238770, 17.459398), Vector(-445.334412, 3541.483398, 17.500414), Vector(-36.244473, 3536.202637, 17.465651)}
zonescovered = {Vector(-421.797119, 1516.283081, 16.401537), Vector(-1121.884888, 2301.411133, 8.401537), Vector(-1409.211914, 1266.742310, 8.401537), Vector(-270.863617, 299.511841, 8.401537), Vector(376.692780, 997.493530, 16.379738), Vector(761.283813, 513.385010, 8.401537), Vector(751.214783, 1487.081299, 8.362456), Vector(703.994629, 2333.431641, 8.368332), Vector(-208.293961, 2274.082520, 8.357063)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------

