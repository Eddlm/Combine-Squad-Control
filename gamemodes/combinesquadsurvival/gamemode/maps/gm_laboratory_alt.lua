

zonescovered ={
Vector(-143.548355,-2661.684814,-959.968750),
Vector(1123.766846,-304.927521,-63.968750),
Vector(234.770203,-361.127350,-959.968750),
Vector(-12.508271,-2316.974365,-959.968750),
}


ITEMPLACES ={
Vector( 1554.963257, 197.944290, -52.166748),
}


combinespawnzones = {
Vector(-1192.663330, -1933.438232, -895.977295),
Vector(-452.412903, 225.464554, -959.968750),
Vector(-543.746277, 163.22158, -63.968750),
Vector(-545.614990, -80.473564, -63.968750),

}


function MapSetup()

for k,v in pairs(ents.GetAll()) do if v:EntIndex() == 394 or v:EntIndex() == 417 or v:EntIndex() == 495 or v:EntIndex() == 394 or v:EntIndex() == 439 or v:EntIndex() == 417 or v:EntIndex() == 396 or v:EntIndex() == 854 or v:EntIndex() == 270 or v:EntIndex() == 496 or v:EntIndex() == 395 or v:EntIndex() == 398 or v:EntIndex() == 420 or v:EntIndex() == 418 or v:EntIndex() == 419 or v:EntIndex() == 397 then print (v:GetClass()) v:Remove() end end

end


