
ITEMPLACES = {Vector(-366.535370, 1001.757446, 103.735161), Vector(-973.675781, 957.878540, 97.822113)}
zonescovered ={
Vector(-246.252655, 779.252075, 128.031250),
Vector(402.092773, 1882.570923, 128.031250),
Vector(249.728470, -56.602673, 248.031250),
Vector(-942.569519, -365.803955, 128.031250),
Vector(-1011.498352, 753.641174, 128.031250),
Vector(-1516.851318, 153.432281, 128.031250),
}
combinespawnzones = {
Vector(-2285.673828, 1306.519897, 44.380402),
Vector(-2304.039063, 1012.998840, 45.629108),
Vector(-1575.854736, -688.813782, 46.031250),
Vector(701.816895, 1887.032471, 118.031250),
}

function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end
---------------------- END OF CONFIGURATION FILE ----------------------

