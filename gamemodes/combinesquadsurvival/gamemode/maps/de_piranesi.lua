

-- Where the combine will spawn.
zonescovered ={

Vector(2039.058838, 1422.693726, 128.031250),

Vector(-2605.775635, -298.130493, 152.031250),

Vector(-545.174683, 564.466797, 193.031250),

Vector(-218.404053, -713.975586, 96.031250),

Vector(143.576263, 1388.521240, 63.177567),

Vector(-1700.481934, 2417.018066, 224.031250),

Vector(-1338.425659, 959.869751, 288.031250),

Vector(70.690933, 329.411011, 512.031250),

}


ITEMPLACES ={

Vector(33.450947, 368.418365, 304.031250),

Vector(-455.399841, -742.010010, 144.031250),

Vector(-1263.123535, -12.129912, 152.031250),

}


-- Positions between the combine will patrol.
combinespawnzones = {

Vector(2039.058838, 1422.693726, 128.031250),

Vector(-2605.775635, -298.130493, 152.031250),

}



function MapSetup()

SpawnProp(Vector(795.289307, 112.086082, 368.501831),Angle(-0.007, 89.973, -0.063),'models/props_wasteland/kitchen_shelf002a.mdl')



SpawnTurret(Vector(1070.020020, 284.688080, 368.767700),Angle(0.308, -18.617, 0.598))
SpawnTurret(Vector(465.211731, 686.005859, 192.754379),Angle(0.323, 40.885, 0.452))
SpawnTurret(Vector(-590.909973, 1583.052246, 352.747620),Angle(0.257, 44.902, 0.420))

SpawnProp(Vector(-970.119202, 2391.764160, 169.606689),Angle(0.139, -179.975, 0.125),'models/props_junk/trashdumpster01a.mdl')

SpawnProp(Vector(-2163.504150, 377.703766, 185.583160),Angle(0.050, -179.967, 0.119),'models/props_junk/trashdumpster01a.mdl')

SpawnProp(Vector(-2156.313965, 280.291626, 185.580994),Angle(-0.048, -179.989, -0.003),'models/props_junk/trashdumpster01a.mdl')

SpawnProp(Vector(1294.897217, 309.506683, 180.860886),Angle(5.030, -89.854, -0.042),'models/props_c17/bench01a.mdl')

SpawnProp(Vector(1775.192749, 1363.225464, 275.866119),Angle(-0.086, -90.042, 0.017),'models/props_c17/bench01a.mdl')

SpawnProp(Vector(1141.844482, 679.987366, 176.885742),Angle(-0.260, 0.064, -0.054),'models/props_wasteland/controlroom_desk001b.mdl')

SpawnProp(Vector(1192.328857, 683.067932, 179.741730),Angle(0.080, -158.791, -0.000),'models/props_interiors/furniture_chair03a.mdl')

SpawnProp(Vector(1489.452759, 118.321098, 368.350006),Angle(0.013, -1.293, -0.019),'models/props_wasteland/kitchen_shelf002a.mdl')

SpawnProp(Vector(1487.966919, 171.276993, 368.520813),Angle(0.206, -0.037, -0.166),'models/props_wasteland/kitchen_shelf002a.mdl')

SpawnProp(Vector(349.670258, 248.376068, 522.118591),Angle(0.342, 135.000, 0.000),'models/props_wasteland/cafeteria_bench001a.mdl')

SpawnProp(Vector(-182.879074, 208.841507, 522.441162),Angle(-1.962, 44.966, 0.029),'models/props_wasteland/cafeteria_bench001a.mdl')

SpawnProp(Vector(-1181.660889, 1411.558960, 171.858704),Angle(-0.004, -179.913, 1.742),'models/props_junk/trashdumpster02.mdl')

end
