
ITEMPLACES = {Vector(-2277.173828, 210.960556, 48.147545)}
combinespawnzones = {Vector(-2378.083008, 2733.885498, 2.332038), Vector(-3233.574219, 2869.694824, 5.008401)}
zonescovered = {Vector(-2669.121094, 1180.627319, 0.399357), Vector(-2956.615234, 128.647827, 0.401537), Vector(-2536.572510, -1002.268005, 0.401537), Vector(-3247.463623, -1301.961304, 0.401537), Vector(-3348.329346, -584.585999, 0.391243), Vector(-4263.151367, -1363.888672, 0.400434), Vector(-2535.335205, -1342.752686, 0.401537), Vector(-3234.218750, -3.229147, 0.401537), Vector(-3500.603760, 131.675995, 0.401549)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end
---------------------- END OF CONFIGURATION FILE ----------------------

