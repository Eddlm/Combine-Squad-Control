
zonescovered ={
Vector(550.441528, -368.682709, 528.031250),
Vector(844.767395, -687.454529, 336.031250),
Vector(7.008403, -810.382751, 336.031250),
Vector(198.147202, -101.514679, 336.031250),
Vector(98.759155, -250.281982, 128.031250),
Vector(882.647705, -644.181396, 128.031250),
Vector(442.664307, 71.864281, 128.031250),

}


ITEMPLACES ={
Vector(458.391083, -311.116547, 526.864624),
Vector(223.788071, -223.005692, 324.847839),
Vector(112.935486, -676.375610, 307.477173),
}

combinespawnzones = {
Vector(853.685974, 197.012299, 128.031250),
Vector(-250.236496, -898.850647, 544.031250),
Vector(-244.987717, 374.593567, 544.031250),
}



function MapSetup()
SpawnItem("item_healthcharger", Vector(521.684570, 61.264465, 517.327454), Angle(0.000, 180.000, 0.000) )
SpawnItem("item_healthcharger", Vector(576.968750, -143.969116, 325.275513), Angle(0.000, 180.000, 0.000) )
SpawnItem("item_healthcharger", Vector(14.532608, -289.850403, 117.275497), Angle(0.000, 0.000, 0.000) )

SpawnStaticProp(Vector(-1313.221558, -1243.587769, -310.317780),Angle(0,0,0),"models/props_junk/trashdumpster01a.mdl")
SpawnStaticProp(Vector(-1313.120972, -1328.330322, -310.333618),Angle(0,0,0),"models/props_junk/trashdumpster01a.mdl")




end

