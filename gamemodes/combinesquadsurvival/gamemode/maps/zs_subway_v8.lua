
ITEMPLACES = {Vector(2285.864746, -1538.832397, -200.102203), Vector(2079.264893, 216.284714, -170.615585)}
combinespawnzones = {Vector(-143.626480, -2563.404785, 40.656590), Vector(2.519132, 704.149170, 33.463428), Vector(2904.128906, -3161.853027, 33.486561), Vector(1451.016846, -348.393280, -219.161560)}
zonescovered = {Vector(5321.622070, -1262.884888, -351.598450), Vector(4149.471680, -1793.036133, -543.598450), Vector(3588.423340, -1024.866211, -543.603333), Vector(2303.824219, -1965.854004, -223.645615), Vector(2029.330811, -43.888306, -223.598465), Vector(2785.430176, 305.026581, -415.598450), Vector(3172.645264, -465.756836, -543.598450), Vector(3134.278320, -2629.601563, -223.644470), Vector(2410.843018, -2874.907471, -223.618835), Vector(2468.831543, -3069.803223, -487.598450), Vector(1310.427979, -3674.663086, -95.598465), Vector(-88.499313, -1243.386108, -95.598465), Vector(864.234192, 123.014824, 32.401539), Vector(-8.758978, 388.105927, 32.386520), Vector(1424.854858, -468.521027, -223.598465), Vector(2826.482178, -3182.052002, 32.401630)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end
end
---------------------- END OF CONFIGURATION FILE ----------------------
