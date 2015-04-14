
ITEMPLACES = {Vector(238.741776, 158.092926, 3.819426)}
combinespawnzones = {Vector(-330.990387, -1561.076172, -254.534683), Vector(-320.212677, -1301.121948, -254.503006)}
zonescovered = {Vector(-55.808697, -1407.568970, -255.598465), Vector(-587.411377, -183.519852, -255.598465), Vector(-684.005310, -528.662537, -127.598465), Vector(-379.564026, -0.334248, 0.361374), Vector(61.866467, -231.287628, -255.598450), Vector(-106.636436, -586.360657, -255.625565), Vector(422.774231, -588.590881, -255.598465), Vector(894.683105, -716.378662, -255.636719)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end
---------------------- END OF CONFIGURATION FILE ----------------------

