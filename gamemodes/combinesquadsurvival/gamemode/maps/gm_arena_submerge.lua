
ITEMPLACES = {Vector(-407.542908, 1587.112427, -211.638382), Vector(-286.862000, 1086.835938, -210.147034), Vector(-176.380356, 999.603699, -217.445023)}
combinespawnzones = {Vector(1502.095703, 2619.886230, -158.541855), Vector(489.589508, 3581.114990, -158.499374), Vector(-968.072144, 1619.995850, -254.535294), Vector(259.098145, -380.495148, -254.530579)}
zonescovered = {Vector(313.033783, 1620.281494, -287.598450), Vector(1073.771606, 2630.633545, -159.598465), Vector(-249.619797, 2907.924072, -159.598495), Vector(1180.842407, 1530.552124, -159.598465), Vector(247.032150, 280.100464, -287.627716)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------
