


ITEMPLACES = {Vector(-1256.353027, 3805.950195, 548.426941), Vector(-1686.498169, 1299.676147, 532.390503), Vector(-1713.644775, 1705.739502, 532.911682)}
combinespawnzones = {Vector(-385.081451, 3953.319092, 385.500458), Vector(-516.845398, 3939.837891, 385.465729), Vector(-370.494293, 4187.746094, 385.473175), Vector(-499.395691, 4181.951660, 385.454346),Vector(8831.085938, 1143.959351, 370.566742), Vector(8830.524414, 1023.898499, 370.584961)}
zonescovered = {Vector(-1313.679077, 2659.703857, 384.401550), Vector(-1938.384644, 2205.682861, 256.369171), Vector(-1306.215454, 3516.928467, 512.401550), Vector(-2457.272461, 3455.805176, 384.401550), Vector(-639.378601, 1447.982666, 512.392883), Vector(2495.626709, 984.974548, 507.357086), Vector(5997.735840, -1969.888184, 363.353180), Vector(8725.908203, 1082.007446, 373.907806)}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end


print("Removing troubling entities")
for k, v in pairs(ents.GetAll()) do
--if tostring(v:EntIndex()) == "459" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "444" then  print(v:EntIndex()) v:Remove() end

if tostring(v:EntIndex()) == "306" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "443" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "290" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "291" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "483" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "475" then  print(v:EntIndex()) v:Remove() end
if tostring(v:EntIndex()) == "476" then  print(v:EntIndex()) v:Remove() end
end
print("Done")
end