
ITEMPLACES = {Vector(-297.507904, 226.654587, 48.342533)}
combinespawnzones = {Vector(526.625916, -501.856445, -134.648117), Vector(-946.109741, -476.694580, -137.158340), Vector(-954.501099, 662.396484, -141.817459), Vector(523.099060, 690.126343, -138.202057)}
zonescovered = {Vector(-132.821503, 267.375732, -115.998695), Vector(-398.641327, 295.368774, 8.401537), Vector(-106.320610, 313.649261, 8.361381)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end