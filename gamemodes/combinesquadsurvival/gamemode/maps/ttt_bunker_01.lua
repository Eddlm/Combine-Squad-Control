
ITEMPLACES = {Vector(519.106995, -76.723297, -1464.873169), Vector(-234.937424, 953.224060, -1476.260620), Vector(-238.311935, 1397.090698, -1474.879395), Vector(-96.756195, 1290.811523, -1476.170410), Vector(-85.962906, 1154.029175, -1474.874512), Vector(-90.598808, 1009.142334, -1474.866577), Vector(-92.610199, 864.149414, -1474.917603), Vector(-241.479492, 1096.697876, -1474.867065), Vector(-242.172058, 1242.249268, -1474.870483), Vector(-645.993652, 949.676392, -1474.874756), Vector(-474.541748, 861.450439, -1474.868774), Vector(-637.344727, 1089.827026, -1474.870483), Vector(-475.810486, 1011.549133, -1474.872070), Vector(-642.982666, 1245.597778, -1474.875610), Vector(-480.651459, 1162.585815, -1476.189697), Vector(-475.004883, 1308.909546, -1476.186401), Vector(-645.468262, 1410.695313, -1475.046875), Vector(135.731628, 1394.145020, -1476.175781), Vector(313.556122, 1304.890503, -1475.696777), Vector(315.227325, 1161.197388, -1474.912720), Vector(136.552826, 1242.073975, -1474.873169), Vector(138.881302, 1092.355469, -1474.878418), Vector(319.031281, 862.974182, -1475.699463), Vector(138.461761, 951.658997, -1474.873901), Vector(723.624023, 851.589478, -1475.078613), Vector(547.722900, 948.612488, -1476.144531), Vector(535.729431, 1098.069702, -1474.867676), Vector(709.920227, 1008.764771, -1476.165161), Vector(720.997192, 1162.706421, -1476.139771), Vector(720.025818, 1301.897339, -1474.923096), Vector(540.640259, 1388.862061, -1474.866211), Vector(-1489.820923, 145.221573, -1483.682129), Vector(-1317.019897, 164.375916, -1482.368042), Vector(-1144.052368, 158.226364, -1482.269653), Vector(-1230.379761, -155.907272, -1482.287231), Vector(-1398.554199, -148.383942, -1482.312744), Vector(-1567.453003, -155.230179, -1482.306641), Vector(-987.399231, 153.976730, -1482.291504), Vector(-819.956238, 151.651825, -1482.304688), Vector(-762.291321, 805.569031, -275.144348), Vector(-773.601318, 39.233120, -660.137512)}
combinespawnzones = {Vector(1.822100, -1276.160522, 1.454559), Vector(-69.655685, -1259.030518, 1.473816), Vector(-126.773926, -1307.787598, 64.031250), Vector(124.300911, -994.787659, 64.031250)}
zonescovered = {Vector(12.158383, -436.600830, -15.598460), Vector(-1302.585938, -29.482618, 0.401537), Vector(-17.266071, 723.883057, 0.401537), Vector(-694.832153, -4.234618, -727.598450), Vector(-422.499481, -10.812902, -743.598450), Vector(-33.430588, -430.658875, -743.598450), Vector(422.560822, -19.110079, -743.598450), Vector(25.059830, 429.400482, -743.598450), Vector(6.606225, 2473.878906, -727.639893), Vector(1442.484619, 9.540286, -727.598450)}
function MapSetup()
for k, v in pairs(ents.FindByClass('func_door_rotating')) do print(v:GetClass()) v:SetKeyValue( 'spawnflags', '32' ) v:Fire('Open','',0) end

end
---------------------- END OF CONFIGURATION FILE ----------------------

