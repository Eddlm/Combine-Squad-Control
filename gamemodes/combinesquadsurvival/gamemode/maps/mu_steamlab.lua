
ITEMPLACES = {Vector(-2205.325439, 2469.574951, 1086.038330), Vector(-2433.593262, 1426.716309, 1069.078735), Vector(-1669.202148, 1454.069580, 1147.344727), Vector(-2095.444092, 2089.666260, 1073.128052), Vector(-2913.476563, 1778.500000, 942.127563), Vector(-2983.637939, 3148.878662, 935.127869), Vector(-2770.017090, 3146.913574, 933.844360), Vector(-1694.138306, 3243.882568, 1061.130493)}
combinespawnzones = {Vector(-1404.434814, 1491.615845, 906.649841)}
zonescovered = {Vector(-1044.134644, 2270.783447, 888.373657), Vector(-2105.689697, 2704.589111, 824.401550), Vector(-2125.030029, 1912.919922, 1032.401489), Vector(-1455.664063, 2366.762451, 1016.318542), Vector(-2672.483887, 2198.074707, 1016.401550), Vector(-3032.587646, 2335.666504, 888.344238)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------

