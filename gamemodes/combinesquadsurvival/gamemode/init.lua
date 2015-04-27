AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "regroup" )
util.AddNetworkString( "selectedgohere" )
util.AddNetworkString( "selectedholdposition" )
util.AddNetworkString( "selectedfollowme" )
util.AddNetworkString( "unselectall" )
util.AddNetworkString( "formsquadfromselected" )
util.AddNetworkString( "squadgohere" )
util.AddNetworkString( "disbandsquad" )
util.AddNetworkString( "squadholdposition" )
util.AddNetworkString( "squadfollowme" )
util.AddNetworkString( "regroupsquad" )
util.AddNetworkString( "selectallnonselected" )
util.AddNetworkString( "formsquad2fromselected" )
util.AddNetworkString( "squad2gohere" )
util.AddNetworkString( "disbandsquad2" )
util.AddNetworkString( "squad2holdposition" )
util.AddNetworkString( "squad2followme" )
util.AddNetworkString( "regroupsquad2" )
util.AddNetworkString( "PlayerKillNotice" )
util.AddNetworkString( "SpawnRequest" )
util.AddNetworkString( "addzoneselected" )
util.AddNetworkString( "ClearZoneSelected" )

util.AddNetworkString( "light_below_limit" )
util.AddNetworkString( "light_above_limit" )
util.AddNetworkString( "Visible" )
util.AddNetworkString( "NotVisible" )
util.AddNetworkString( "Spotted" )
util.AddNetworkString( "Hidden" )
util.AddNetworkString( "RequestAmmo" )

util.PrecacheModel("models/Combine_Soldier.mdl")
util.PrecacheModel("models/Combine_Super_Soldier.mdl")
util.PrecacheModel("models/Police.mdl")
util.PrecacheModel("models/zombie/classic.mdl")
util.PrecacheModel("models/zombie/fast.mdl")
util.PrecacheModel("models/zombie/poison.mdl")


-- Variables before loading
UpdateRelationshipsCoolDown=5


net.Receive( "RequestAmmo", function( length, client )

		if client:Frags() >= 20 then 
		local targetTrace = util.QuickTrace( client:GetEyeTraceNoCursor().HitPos, Vector(0,0,900), client)
		SpawnProp(targetTrace.HitPos,client:GetAngles(),"models/props_junk/wood_crate001a.mdl") 
		client:AddFrags(-20) client:SendLua("DeductPoints()")
		else
		client:SendLua("notification.AddLegacy('You cannot afford an Ammo drop with less than 20 points.',   NOTIFY_HINT  , 6 )")
		end

end )


net.Receive( "light_above_limit", function( length, client )
if client.huntedready==0 then 
	net.Start( "Visible" )
	net.Send(client)
	client:SetNoTarget(false)
	client:SendLua(	"light_above_limit = 1" )	
	for k, v in pairs(client:GetWeapons() ) do
	v:SetRenderMode( RENDERMODE_TRANSALPHA )
	v:SetColor(Color(255,255,255,255))
	end
client:SetRenderMode( RENDERMODE_TRANSALPHA )
client:SetColor(  Color(255,255,255,255))
end
end )


net.Receive( "light_below_limit", function( length, client )
local hidden=1
	for k, v in pairs(ents.FindInSphere(client:GetPos(),5000)) do
			if table.HasValue(CantHideInPlainSight, v:GetClass())then
			if v:Health() > 0 then
				if v:Visible(client) and v:GetEnemy() then
					hidden=0
					client:PrintMessage(HUD_PRINTCENTER , ""..v:GetName().." saw you hide.")
					break
				end
			end
		end
	
	end
	if hidden==1 then client:SetNoTarget(true)
		client.spotted =  0
		net.Start( "Hidden" )
		net.Send(client)
		net.Start( "NotVisible" )
		net.Send(client)
		client:SendLua(	"light_above_limit = 0" )		
	for k, v in pairs(client:GetWeapons() ) do
	v:SetRenderMode( RENDERMODE_TRANSALPHA )
	v:SetColor(Color(255,255,255,20))
	end
client:SetRenderMode( RENDERMODE_TRANSALPHA )
client:SetColor(  Color(255,255,255,20))
	end
end)


net.Receive( "addzoneselected", function( length, client )

		for k, v in pairs(ents.GetAll()) do
			if v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			print(v:GetClass())
			if !v.patrolzones then v.patrolzones = {} end
			table.insert(v.patrolzones, client:GetEyeTraceNoCursor().HitPos)
			PrintTable(v.patrolzones)
			 v.patrol = 1
			end
		end
end)

net.Receive( "ClearZoneSelected", function( length, client )

		for k, v in pairs(ents.GetAll()) do
			if v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			print(v:GetClass())
			table.Empty(v.patrolzones)
			 v.patrol = 0
			end
		end
		
end)

net.Receive( "SpawnRequest", function( length, client )
local data = net.ReadString()
PrintMessage(HUD_PRINTTALK, net.ReadString())

/*
		local canspawn=1
		table.foreach(ents.GetAll(), function(key,player)
			if player:GetNWString("side") == "rebel" and player != ply then
			canspawn=1 -- lel
			end
		end)
*/

if CanSpawnCombine==1 then
	if CountPlayerCombine(client:EntIndex()) < GetConVarNumber("squad_survival_max_combine_per_player")
	then
		if data == "Soldier" then SpawnCombineS(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex())
		end
		if data == "Shotgunner" then SpawnCombineShotgunner(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
		end
		if data == "Elite" then SpawnCombineElite(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
		end
		if data == "Guard" then SpawnCombinePrisonGuard(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
		end
		if data == "Metrocop" then SpawnMetropolice(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
		end
		
		if data == "Sniper" then SpawnSniper(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:GetAngles(),client:EntIndex()) 
		end
		
		
		if data == "Turret" then SpawnTurret(client:GetEyeTraceNoCursor().HitPos,client:GetAngles(),client:EntIndex()) 
		end
		
		if data == "Hunter" then SpawnHunter(client:GetEyeTraceNoCursor().HitPos,client:EntIndex()) 
		end
		
		if data == "CeilingTurret" then
			traceRes = util.QuickTrace(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,0), Vector(0,0,50), player.GetAll())
			if traceRes.Hit then
				SpawnCeilingTurretStrong(client:GetEyeTraceNoCursor().HitPos,client:GetAngles(),client:EntIndex())
			else 
				client:SendLua("notification.AddLegacy('Combine Cameras can only spawn on a ceiling.',    NOTIFY_ERROR   , 5 )")
			end
		end
	if data == "Rollermine" then SpawnRollermine(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,20),client:EntIndex()) 
	end
	
	if data == "Mine" then SpawnCombineMine(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,20),client:EntIndex()) 
	end
	
	else
				client:PrintMessage(HUD_PRINTTALK, "You have passed the combine-per-player limit ("..GetConVarNumber("squad_survival_max_combine_per_player")..")") 	
	end
	

	
	
	
	if data == "Helicopter" and CountAirUnits() < 1 then SpawnHeli(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
	
	elseif  data == "Helicopter" and CountAirUnits() > 0 then 
	client:PrintMessage(HUD_PRINTTALK, "Dismiss the existing air unit before requesting another.") 	
	end
	if data == "Gunship" and CountAirUnits() < 1 then SpawnGunship(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
	elseif data == "Gunship" and CountAirUnits() > 0 then 
	client:PrintMessage(HUD_PRINTTALK, "Dismiss the existing air unit before requesting another.") 	
	end
	if data == "Dropship" and CountAirUnits() < 1 then SpawnDropship(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),client:EntIndex()) 
	elseif data == "Dropship" and CountAirUnits() > 0 then 
	client:PrintMessage(HUD_PRINTTALK, "Dismiss the existing air unit before requesting another.") 	
	end
	
	else 
		client:SendLua("notification.AddLegacy('You cannot request reinforcments right now!',    NOTIFY_ERROR   , 5 )")
end

if data == "Mortar" then
if client:Frags() >= 100 then
	timer.Create( "Mortar", 3, 20, LaunchMortarRound ) 	
	client:EmitSound("npc/combine_soldier/vo/overwatchrequestskyshield.wav")
	
	client:AddFrags(-100) client:SendLua("DeductPoints()")
	else client:SendLua("notification.AddLegacy('You cannot afford Mortar Rounds with less than 100 points.',    NOTIFY_ERROR   , 5 )")
	end
end

if data == "DismissAirUnits" then 



			for k, v in pairs(ents.FindByClass("npc_combinedropship")) do
			v:Remove()
			PrintMessage(HUD_PRINTTALK, "[Overwatch]: The Air Unit has been dismissed.")

			end
			for k, v in pairs(ents.FindByClass("npc_helicopter")) do
			v:Remove()
			PrintMessage(HUD_PRINTTALK, "[Overwatch]: The Air Unit has been dismissed.")

			end
			for k, v in pairs(ents.FindByClass("npc_combinegunship")) do
			v:Remove()
			PrintMessage(HUD_PRINTTALK, "[Overwatch]: The Air Unit has been dismissed.")

			end
			
end



end)


function MoreWaves()
		for k, v in pairs(player.GetAll()) do
			v:GiveAmmo( 15, "Buckshot", true )
			v:GiveAmmo( 150, "AR2", true )
			v:GiveAmmo( 1, "Grenade", true )	
		end
CanSpawnCombine=1

PrintMessage(HUD_PRINTTALK, "You have 30 seconds untill the next wave")
WaveNumber=WaveNumber+1

timer.Simple(30, function()
CanSpawnCombine=0
		local randomnumber = math.random(1,2)
		if randomnumber == 1 then
		timer.Create( "ZombieWave", 0.5, 20, ZombieWave )
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Necrotics are coming.")
		elseif randomnumber == 2 then
		timer.Create( "AntLionWave", 0.5, 20, AntLionWave )
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.")
		end
end)
end
	
function CountEntity(ent)
local entities=0
		for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == tostring(ent) then
			entities=entities+1
		end
		end
		return(entities)
end

function CountCombine()
local entities=0
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) then
			entities=entities+1
		end
		end
		return(entities)
end

function CountPlayerCombineSoldier(owner)
local entities=0
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(CombineSoldiers, v:GetClass()) then
		if v:Health() > 0 and v:GetNWString("owner") == ""..owner.."" then
			entities=entities+1
			print(v:GetClass())
		end
		end
		end
		return(entities)
end

function CountPlayerCombine(owner)
local entities=0
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) then
		if v:Health() > 0 and v:GetNWString("owner") == ""..owner.."" then
			entities=entities+1
			print(v:GetClass())
		end
		end
		end
		return(entities)
end

function CountPlayerCombineNumber(owner,squad)
local entities=0
		for k, v in pairs(ents.GetAll()) do
			if table.HasValue(AllCombineEntities, v:GetClass()) then
				if v:Health() > 0 and v:GetNWString("owner") == ""..owner.."" and v:GetNWString("squad") == ""..squad.."" then
					entities=entities+1
				end
			end
		end
		if squad == "squad1" then
		if entities==0 then   player.GetByID(tonumber(owner)):SendLua("squad1=false")  end
		player.GetByID(tonumber(owner)):SendLua("squad1numbers="..entities.."")
		else
		if entities==0 then  player.GetByID(tonumber(owner)):SendLua("squad2=false")  end

		player.GetByID(tonumber(owner)):SendLua("squad2numbers="..entities.."")
		end
end


function CountAirUnits()
local entities=0
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(CombineHelicopters, v:GetClass()) then
			entities=entities+1
		end
		end
		return(entities)
end
function AntLionWave()
--PrintMessage(HUD_PRINTTALK, "AntLionWave")

if CountEntity("npc_antlion") < 10+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_antlion")
end

if CountEntity("npc_antlionguard") < 1 and WaveNumber > 5 then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_antlionguard")
end
end

function RebelWave()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

if CountEntity("npc_citizen") < 20 then
SpawnRebel(table.Random(EnemiesAvailableSpawns))
end

if WaveNumber > 5 then
if CountEntity("npc_vortigaunt") < WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_vortigaunt")
end
end
end



function hlrenaissance1()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

	table.foreach(HLRenaissance1, function(key,value)
		if CountEntity(value) < 2+WaveNumber then
		SpawnBasicNPC(table.Random(EnemiesAvailableSpawns),value)
		end
	end)
	
end
function hlrenaissance2()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

	table.foreach(HLRenaissance2, function(key,value)
		if CountEntity(value) < 2+WaveNumber then
		SpawnBasicNPC(table.Random(EnemiesAvailableSpawns),value)
		end
	end)
	
end

function hlrenaissance3()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

	table.foreach(HLRenaissance3, function(key,value)
		if CountEntity(value) < 2+WaveNumber then
		SpawnBasicNPC(table.Random(EnemiesAvailableSpawns),value)
		end
	end)
	
end

function TF2BotBlueWave()
local bots= 0
	table.foreach(TF2BotBlue, function(key,value) bots=bots+CountEntity(value) end)
		if bots < WaveNumber then
		SpawnBasicNPC(table.Random(EnemiesAvailableSpawns),table.Random(TF2BotBlue))
		end
end

function AmnesiaWave()
PrintMessage(HUD_PRINTTALK, "AmnesiaSNPCs")
local bots= 0
		table.foreach(AmnesiaSNPCs, function(key,value) bots=bots+CountEntity(value) end)
		if bots < WaveNumber then
		SpawnBasicNPC(table.Random(EnemiesAvailableSpawns),table.Random(AmnesiaSNPCs))
		end
end
function hlrenaissanceboss()

SpawnBasicNPC(table.Random(combinespawnzones),table.Random(HLRenaissanceBosses))

	
end




function ZombieWave()
--PrintMessage(HUD_PRINTTALK, "ZombieWave")

if CountEntity("npc_fastzombie") < math.random(5,7)+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_fastzombie")
end

if CountEntity("npc_zombie") < math.random(10,20)+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_zombie")
end

if CountEntity("npc_poisonzombie") < math.random(2,5)+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_poisonzombie")
end


if IsMounted("ep1") or IsMounted("ep2") then

if CountEntity("npc_zombine") < math.random(2,5)+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_zombine")
end


end


end



function ZombieWaveFindTheDocument()

if CountEntity("npc_fastzombie") < 2+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_fastzombie")
end

if CountEntity("npc_zombie") <5+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_zombie")
end

if CountEntity("npc_poisonzombie") < 1+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_poisonzombie")
end


if IsMounted("ep1") or IsMounted("ep2") then

if CountEntity("npc_zombine") < 1+WaveNumber then
SpawnBasicNPC(table.Random(EnemiesAvailableSpawns), "npc_zombine")
end


end


end



function AddonCycleLong()
local randompl = d
--PrintMessage(HUD_PRINTTALK, "AddonCycleLong")
timer.Create( "AddonCycleLong", 40, 1, AddonCycleLong)
--timer.Simple(20, AddonCycleLong )
if CountEntity("npc_combine_s") > 1 then
randompl = table.Random(ents.FindByClass("npc_combine_s"))
-- table.Random(ents.FindByClass("npc_metropolice")) table.Random(ents.FindByClass("npc_hunter")) table.Random(ents.FindByClass("npc_turret_floor"))
else
randompl = table.Random(ents.FindByClass("player"))
end
--PrintMessage(HUD_PRINTTALK, ""..randompl:GetClass().."")
if CountEnemies() < 2 then MoreWaves() end
--PrintMessage(HUD_PRINTTALK, "EnemiesLeft: "..EnemiesLeft.."")

end

function CountEnemies()

local	EnemiesLeft=0
for k,zombi in pairs(ents.GetAll()) do 
if table.HasValue(Zombies, zombi:GetClass()) or table.HasValue(Monsters, zombi:GetClass()) or table.HasValue(AmnesiaSNPCs, zombi:GetClass()) or table.HasValue(TF2BotBlue, zombi:GetClass()) or zombi:GetClass() == "npc_citizen" then
	EnemiesLeft=EnemiesLeft+1
	end
end
return EnemiesLeft
end


function GM:Think()
 if CurTime() > fiveseccycletime+5 then
fiveseccycletime = CurTime()
	for k, v in pairs(player.GetAll()) do
		v:SendLua("playerfrags= "..v:Frags().."")
	end

EnemiesSelectSpawn()
end

 if CurTime() > shortcycletime+GetConVarNumber("squad_survival_think_cycle") then
shortcycletime = CurTime()

	for k, v in pairs(ents.FindByClass("path_track")) do
		v:Remove()
	end
	local owner
	for k, v in pairs(ents.GetAll()) do
	if v:Health() > 0 then
	--if !v:GetEnemy() and !v:IsMoving() and math.random(1,4) == 1 then  v:EmitSound(table.Random(CombineChat_Idle), 75, 100) end

		if table.HasValue(CombineHelicopters, v:GetClass()) then 
		 owner = ents.GetByIndex(v:GetNWString("owner"))
			if v:GetNWString("FollowMe") != "no" then
				targetTrace = util.QuickTrace( owner:GetPos(), Vector(0,0,3000),{v,owner})
				creating = ents.Create( "path_track" )
				creating:SetName("HeliTrack")
				if targetTrace.HitPos:Distance(owner:GetPos()) < 500 then	correction=Vector(0,0,-200) print("correction") else correction=Vector(0,0,0) end
				creating:SetPos(owner:GetPos()+Vector(0,0,500)+correction)
				creating:Spawn()			
				v:Fire("SetTrack", "HeliTrack")
			end
			if v:GetNWVector("HoldPosition") != "NO_VECTOR" and v:GetPos():Distance(v:GetNWVector("HoldPosition")) > 600  then
				targetTrace = util.QuickTrace( v:GetNWVector("HoldPosition"), Vector(0,0,3000), {v,owner})
				creating = ents.Create( "path_track" )
				creating:SetName("HeliTrack")
				if targetTrace.HitPos:Distance(v:GetNWVector("HoldPosition")) < 500 then	correction=Vector(0,0,-200) print("correction") else correction=Vector(0,0,0) end
				creating:SetPos(v:GetNWVector("HoldPosition")+Vector(0,0,500)+correction)
				creating:Spawn()			
				v:Fire("SetTrack", "HeliTrack")	
			end	
		end
		if table.HasValue(CombineSoldiers, v:GetClass())  and !v:CreatedByMap() then
		 owner = ents.GetByIndex(v:GetNWString("owner"))

				if v:GetNWVector("HoldPosition") != "NO_VECTOR"  then
					if v:GetNWString("Squad") == "no" then
						if v:GetPos():Distance(v:GetNWVector("HoldPosition")) > GetConVarNumber("squad_survival_hold_position_tolerance") and !v:IsCurrentSchedule(50) then
							v:SetLastPosition(v:GetNWVector("HoldPosition"))
							v:SetSchedule(SCHED_FORCED_GO_RUN)			
						end
					else			
						if v:GetPos():Distance(v:GetNWVector("HoldPosition")) > GetConVarNumber("squad_survival_hold_position_tolerance") and !v:IsCurrentSchedule(50) then
							v:SetLastPosition(v:GetNWVector("HoldPosition"))
							v:SetSchedule(SCHED_FORCED_GO_RUN)			
						end			
					end		
		
					if math.random(1,3) == 1 and !v:IsMoving() and !v:GetEnemy() then v:SetSchedule(SCHED_ALERT_SCAN) end
				end		
				if v:GetNWString("FollowMe") != "no" then
				owner = ents.GetByIndex(v:GetNWString("owner"))
						if v:GetPos():Distance(owner:GetPos()+ (owner:GetForward()*-100)) > 400  then
							v:SetLastPosition((owner:GetPos() + (owner:GetForward()*-100))+Vector(math.random(-50,50),math.random(-50,50),0))
							v:SetSchedule(SCHED_FORCED_GO_RUN)
						end
					end
				
				if !v:GetEnemy() and v:Health() < 100 then v:SetHealth(v:Health()+1) end
				if !v:GetEnemy() and !v:IsMoving() and v.patrol == 1 then
				v:SetLastPosition(table.Random(v.patrolzones))
				v:SetSchedule(SCHED_FORCED_GO)
				end
				
			if v:GetEnemy() and v:IsCurrentSchedule(SCHED_FORCED_GO) then v:ClearSchedule() end		

end
end


if !v:CreatedByMap() and !table.HasValue(AllCombineEntities, v:GetClass()) and v:IsNPC() and !v:GetEnemy() and !v:IsMoving() then
		if CountEntity("npc_combine_s") > 0 then
			if math.random(1,3) == 1 then randompl = table.Random(ents.FindByClass("player")) else randompl = table.Random(ents.FindByClass("npc_combine_s")) end
		else
			randompl = table.Random(ents.FindByClass("player"))
		end
		v:SetEnemy(randompl)
		v:SetTarget(randompl)
		v:SetSchedule( SCHED_TARGET_CHASE )
	end
	end 
end
end

function AddPatrolZone(ply)
print("added.")
		for k, v in pairs(ents.GetAll()) do
			if v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..ply:EntIndex().."" then
			print(v:GetClass())
			if !v.patrolzones then v.patrolzones = {} end
			table.insert(v.patrolzones, ply:GetEyeTraceNoCursor().HitPos)
			PrintTable(v.patrolzones)
			 v.patrol = 1
			end
		end

end


function ClearPatrolZones(ply)
print("added.")
		for k, v in pairs(ents.GetAll()) do
			if v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..ply:EntIndex().."" then
			print(v:GetClass())
			table.Empty(v.patrolzones)
			 v.patrol = 0
			end
		end

end


function Patrol(ply)
print("added.")
		for k, v in pairs(ents.GetAll()) do
			if v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..ply:EntIndex().."" then
			/*
			print(v:GetClass())
			v:SetLastPosition(table.Random(v.patrolzones))
			v:SetSchedule(SCHED_FORCED_GO)
			*/
			end
		end

end
--- Squad 2
net.Receive( "regroupsquad2", function( length, client )
client:EmitSound(table.Random(CombineChat_Regroup), 75, 100)

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "squad2" then
		
		
			v:SetLastPosition((client:GetPos() + (client:GetForward()*100))+Vector(math.random(-50,50),math.random(-50,50),0))
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetNWVector("HoldPosition", "NO_VECTOR" )
			client:SendLua("squad2holdingposition=0")
			v:SetNWString("FollowMe","no")
		client:SendLua("squad2followingyou=0")
		end
		end	

end)


net.Receive( "squad2holdposition", function( length, client )
client:EmitSound(table.Random(CombineChat_Hold), 75, 100)

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("Squad") == "squad2" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			v:SetNWVector("HoldPosition", client:GetEyeTraceNoCursor().HitPos+Vector(math.random(-50,50),math.random(-50,50),0) )
			v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetKeyValue( "ignoreunseenenemies", 1 )
			client:SendLua("squad2holdingposition=1")
			v:SetNWString("FollowMe","no")
			v:ClearEnemyMemory() 
		client:SendLua("squad2followingyou=0")
		if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
		end
		end	

end)


net.Receive( "formsquad2fromselected", function( length, client )
CanTalk=1
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
		
		if v:GetNWString("Squad") == "no" then
		v:SetNWString("selected","0")
		v:SetNWVector("HoldPosition","NO_VECTOR")
		v:SetKeyValue("squadname", "squad2")
		v:SetNWString("FollowMe","no")
		v:SetNWString("Squad", "squad2")
		client:SendLua("squad2=true")
			if CanTalk==1 then CanTalk=0  v:EmitSound(table.Random(CombineChat_Form), 75, 100)   timer.Simple(1,function() CanTalk=1 end) end
			end
		end	
		end
	CountPlayerCombineNumber(client:EntIndex(),"squad1")
	CountPlayerCombineNumber(client:EntIndex(),"squad2")

end)

net.Receive( "disbandsquad2", function( length, client )

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("Squad") == "squad2" and v:GetNWString("owner") == ""..client:EntIndex().."" then
		v:SetNWString("Squad", "no")
		v:SetKeyValue("squadname", "")
		v:SetNWString("FollowMe","no")		
		v:SetNWVector("HoldPosition","NO_VECTOR")		
		client:SendLua("squad2holdingposition=0")
		client:SendLua("squad2followingyou=0")
		client:SendLua("squad2=false")

		end	
		end
	CountPlayerCombineNumber(client:EntIndex(),"squad1")
	CountPlayerCombineNumber(client:EntIndex(),"squad2")

end)


net.Receive( "squad2gohere", function( length, client )
client:EmitSound(table.Random(CombineChat_Go), 75, 100)
CanTalk=1
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "squad2" then
			if table.HasValue(CombineHelicopters, v:GetClass()) then 
			targetTrace = util.QuickTrace( client:GetEyeTraceNoCursor().HitPos, Vector(0,0,3000), {v} )
			creating = ents.Create( "path_track" )
			creating:SetName("HeliTrack")
			if targetTrace.HitPos:Distance(client:GetEyeTraceNoCursor().HitPos) < 500 then	correction=Vector(0,0, (targetTrace.HitPos:Distance(client:GetEyeTraceNoCursor().HitPos)-100)) print("correction") else correction=Vector(0,0,500) end
			creating:SetPos(client:GetEyeTraceNoCursor().HitPos+correction)
			creating:Spawn()			
			v:SetNWVector("HoldPosition","NO_VECTOR")	
			v:SetNWString("FollowMe","no")
			v:Fire("SetTrack", "HeliTrack")
			--v:Remove()
			print(creating:GetName())
			--timer.Simple(0.5,function() creating:Remove() end)
			end
		if table.HasValue(CombineSoldiers, v:GetClass()) then
			v:SetKeyValue( "ignoreunseenenemies", 0 )
			v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetNWVector("HoldPosition","NO_VECTOR")	
			v:SetNWString("FollowMe","no")
		client:SendLua("squad2followingyou=0")
		client:SendLua("squad2holdingposition=0")
		end
		if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
		end
		end	

end)


net.Receive( "squad2followme", function( length, client )
client:EmitSound(table.Random(CombineChat_Regroup), 75, 100)

		for k, v in pairs(ents.GetAll()) do

		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "squad2"  then
		if  v:GetNWString("FollowMe") == "no" then
		v:SetLastPosition((client:GetPos() + (client:GetForward()*-100))+Vector(math.random(-50,50),math.random(-50,50),0))
		v:SetSchedule(SCHED_FORCED_GO_RUN)
		v:SetNWString("FollowMe","yes")
		client:SendLua("squad2followingyou=1")
		--client:PrintMessage(HUD_PRINTTALK, "Will Follow.")
		v:SetNWVector("HoldPosition","NO_VECTOR")		
		client:SendLua("squad2holdingposition=0")
		if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
		end

		end
		end	

end)
--- Squad 2



--- Squad 1
net.Receive( "regroupsquad", function( length, client )
client:EmitSound(table.Random(CombineChat_Regroup), 75, 100)

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "squad1" then
			v:SetLastPosition((client:GetPos() + (client:GetForward()*100))+Vector(math.random(-50,50),math.random(-50,50),0))
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetNWString("FollowMe","no")
			v:SetNWVector("HoldPosition","NO_VECTOR")
		client:SendLua("squad1followingyou=0")
		client:SendLua("squad1holdingposition=0")
		end
		end	

end)


net.Receive( "squadholdposition", function( length, client )
client:EmitSound(table.Random(CombineChat_Hold), 75, 100)

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("Squad") == "squad1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			v:SetNWVector("HoldPosition", client:GetEyeTraceNoCursor().HitPos+Vector(math.random(-50,50),math.random(-50,50),0) )
			v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetKeyValue( "ignoreunseenenemies", 1 )
			v:ClearEnemyMemory() 
			client:SendLua("squad1holdingposition=1")
			v:SetNWString("FollowMe","no")
		client:SendLua("squad1followingyou=0")

		end
		end	

end)


net.Receive( "formsquadfromselected", function( length, client )
CanTalk=1
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
		
		if v:GetNWString("Squad") == "no" then
		v:SetNWString("selected","0")
		v:SetNWVector("HoldPosition","NO_VECTOR")
		v:SetKeyValue("squadname", "squad1")
		v:SetNWString("FollowMe","no")
		v:SetNWString("Squad", "squad1")
		if CanTalk==1 then CanTalk=0  v:EmitSound(table.Random(CombineChat_Form), 75, 100)   timer.Simple(1,function() CanTalk=1 end) end

			client:SendLua("squad1=true")

		end
		end	
		end
	CountPlayerCombineNumber(client:EntIndex(),"squad1")
	CountPlayerCombineNumber(client:EntIndex(),"squad2")

end)


net.Receive( "disbandsquad", function( length, client )

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("Squad") == "squad1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
		v:SetNWString("Squad", "no")
		v:SetKeyValue("squadname", "")
		v:SetNWString("FollowMe","no")		
		v:SetNWVector("HoldPosition","NO_VECTOR")		
		client:SendLua("squad1holdingposition=0")
		client:SendLua("squad1followingyou=0")
		client:SendLua("squad1=false")

		end	
		end

	CountPlayerCombineNumber(client:EntIndex(),"squad1")
	CountPlayerCombineNumber(client:EntIndex(),"squad2")

		end)


net.Receive( "squadgohere", function( length, client )
client:EmitSound(table.Random(CombineChat_Go), 75, 100)
CanTalk=1

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "squad1" then
		
			if table.HasValue(CombineHelicopters, v:GetClass()) then 
			targetTrace = util.QuickTrace( client:GetEyeTraceNoCursor().HitPos, Vector(0,0,3000), {v} )
			creating = ents.Create( "path_track" )
			creating:SetName("HeliTrack")
			if targetTrace.HitPos:Distance(client:GetEyeTraceNoCursor().HitPos) < 500 then	correction=Vector(0,0, (targetTrace.HitPos:Distance(client:GetEyeTraceNoCursor().HitPos)-100)) print("correction") else correction=Vector(0,0,500) end
			creating:SetPos(client:GetEyeTraceNoCursor().HitPos+correction)
			creating:Spawn()
			v:SetNWVector("HoldPosition","NO_VECTOR")	
			v:SetNWString("FollowMe","no")
			v:Fire("SetTrack", "HeliTrack")
			--v:Remove()
			print(creating:GetName())
			--timer.Simple(0.5,function() creating:Remove() end)
			end
			if table.HasValue(CombineSoldiers, v:GetClass()) then
				v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
				v:SetKeyValue( "ignoreunseenenemies", 0 )
				v:SetSchedule(SCHED_FORCED_GO_RUN)
				client:SendLua("squad1holdingposition=0")
				client:SendLua("squad1followingyou=0")
				v:SetNWVector("HoldPosition", "NO_VECTOR" )
				v:SetNWString("FollowMe","no")
				if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
			end
		end
		end	

end)


net.Receive( "squadfollowme", function( length, client )
client:EmitSound(table.Random(CombineChat_Regroup), 75, 100)

		for k, v in pairs(ents.GetAll()) do

		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "squad1"  then
		if  v:GetNWString("FollowMe") == "no" then
		v:SetLastPosition((client:GetPos() + (client:GetForward()*-100))+Vector(math.random(-50,50),math.random(-50,50),0))
		v:SetSchedule(SCHED_FORCED_GO_RUN)
		v:SetNWString("FollowMe","yes")
		--client:PrintMessage(HUD_PRINTTALK, "Will Follow.")
		client:SendLua("squad1followingyou=1")
		client:SendLua("squad1holdingposition=0")
		v:SetNWVector("HoldPosition", "NO_VECTOR" )
		if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
		end

		end
		end	

end)



net.Receive( "regroup", function( length, client )
client:EmitSound(table.Random(CombineChat_Regroup), 75, 100)

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "no" then
			v:SetLastPosition((client:GetPos() + (client:GetForward()*100))+Vector(math.random(-50,50),math.random(-50,50),0))
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetNWVector("HoldPosition", "NO_VECTOR" )
			v:SetNWString("FollowMe","no")
		client:SendLua("squad1followingyou=0")
		client:SendLua("squad1holdingposition=0")

		end
		end	

end)

net.Receive( "selectedholdposition", function( length, client )
client:EmitSound(table.Random(CombineChat_Hold), 75, 100)
CanTalk=1
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			v:SetNWVector("HoldPosition", client:GetEyeTraceNoCursor().HitPos )
			v:SetNWString("FollowMe","no")
			v:ClearEnemyMemory() 
			v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetKeyValue( "ignoreunseenenemies", 1 )
		if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
		end
		end	

end)


net.Receive( "unselectall", function( length, client )

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("selected") == "1" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			v:SetNWString("selected","0")
			end
		end

end)

function CreateHeliPath(pos)
	creating = ents.Create( "path_track" )
	creating:SetPos( pos )
	creating:Spawn()
end

net.Receive( "selectedgohere", function( length, client )
client:EmitSound(table.Random(CombineChat_Go), 75, 100)
CanTalk=1
local targetTrace
local correction = Vector(0,0,0)
local attack=0
	for k, v in pairs(ents.GetAll()) do
	if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("selected") == "1" then
	
			if table.HasValue(CombineHelicopters, v:GetClass()) then 
			targetTrace = util.QuickTrace( client:GetEyeTraceNoCursor().HitPos, Vector(0,0,3000), {v} )
			creating = ents.Create( "path_track" )
			creating:SetName("HeliTrack")
			if targetTrace.HitPos:Distance(client:GetEyeTraceNoCursor().HitPos) < 500 then	correction=Vector(0,0, (targetTrace.HitPos:Distance(client:GetEyeTraceNoCursor().HitPos)-100)) print("correction") else correction=Vector(0,0,500) end
			creating:SetPos(client:GetEyeTraceNoCursor().HitPos+correction)
			creating:Spawn()			
			v:Fire("SetTrack", "HeliTrack")
			v:SetNWVector("HoldPosition","NO_VECTOR")	
			v:SetNWString("FollowMe","no")
			print(creating:GetName())
			--timer.Simple(0.5,function() creating:Remove() end)
			end
	/*
			for _, enemy in pairs(ents.FindInSphere(client:GetEyeTraceNoCursor().HitPos,100)) do
			if !table.HasValue(AllCombineEntities, enemy:GetClass()) and enemy:IsNPC() then
			enemy:SetName("target")
			v:SetKeyValue( "ignoreunseenenemies", 0 )
		
			v:Fire("ThrowGrenadeAtTarget","target",0)
			v:AddEntityRelationship( enemy, D_HT, 99 )
			v:SetEnemy(enemy)
			attack=1
			end
			end
	*/
		if attack==0 then
		v:SetNWString("FollowMe","no")
		v:SetNWVector("HoldPosition", "NO_VECTOR" )
		v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
		v:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	if CanTalk==1 then CanTalk=0  timer.Simple(1,function() v:EmitSound(table.Random(CombineChat_Okay), 75, 100) CanTalk=1 end)  end
	end
	end	

end)


net.Receive( "selectedfollowme", function( length, client )

		for k, v in pairs(ents.GetAll()) do

		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("selected") == "1" then
		if  v:GetNWString("FollowMe") == "no" then
		v:SetLastPosition((client:GetPos() + (client:GetForward()*-100))+Vector(math.random(-50,50),math.random(-50,50),0))
		v:SetSchedule(SCHED_FORCED_GO_RUN)
		v:SetNWString("FollowMe","yes")
		--client:PrintMessage(HUD_PRINTTALK, "Will Follow.")
		v:SetNWVector("HoldPosition", "NO_VECTOR" )
		end

		end
		end	

end)





net.Receive( "selectallnonselected", function( length, client )

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "no"  then
		v:SetNWString("selected","1")
					client:PrintMessage(HUD_PRINTTALK, ""..v:GetNWString("name").." selected")

		end
		end	

end)
--- Squad 1



function DeathSound()
	return true
end
hook.Add("PlayerDeathSound", "DeathSound", DeathSound)


function GM:DoPlayerDeath(ply,attacker,dmg)
if ply:GetNWString("side") == "combine" then
ply:EmitSound(table.Random(CombineChat_Killed), 75, 100)
end
if attacker:IsPlayer() and attacker:GetNWString("side") == ply:GetNWString("side") and attacker != ply then
if attacker.teamkiller == 1 then
attacker:Kick("Do not kill your teammates next time")
	table.foreach(player.GetAll(), function(key,ply)
	ply:SendLua("notification.AddLegacy('"..attacker:GetName().." has been kicked (Teamkilling)',    NOTIFY_ERROR   , 10 )")
	end)
else
attacker.teamkiller = 1
attacker:SendLua("notification.AddLegacy('This is a cooperative game! Dont kill your teammates.',    NOTIFY_ERROR   , 10 )")
end
end

if attacker:IsPlayer() and attacker:GetNWString("side") != ply:GetNWString("side") then attacker:AddFrags(10) attacker:SendLua("AddPoints()")

end
ply:CreateRagdoll() 
end
function GM:PlayerDeathThink(ply)
local info=ply:GetEyeTraceNoCursor()

	if ply:KeyPressed(IN_ATTACK2) then
	if ply:OnGround() then
		ply:PrintMessage(HUD_PRINTTALK, "Commander mode.")
		ply:PrintMessage(HUD_PRINTTALK, "Select your troops using right click.")
		local canspawn=1
		table.foreach(ents.GetAll(), function(key,player)
			if player:GetNWString("side") == "rebel" then
			canspawn=0 
			end
		end)
		if canspawn==1 then
		ply:UnSpectate()
		ply:Spectate(6)
		ply:SetMoveType(10)
		else
		ply:SendLua("notification.AddLegacy('You cannot spectate while there is a player being Hunted.',   NOTIFY_HINT  , 6 )")
		end
		elseif table.HasValue(AllCombineEntities, info.Entity:GetClass()) and info.Entity:GetNWString("owner") == "none" or info.Entity:GetNWString("owner") == ""..ply:EntIndex()..""
			then
			if info.Entity:GetNWString("selected") == "0" then	
					if !info.Entity:GetEnemy() and CanTalk==1 then  info.Entity:EmitSound(table.Random(CombineChat_Idle), 75, 100) CanTalk=0 timer.Simple(1,function() CanTalk=1 end) end
				info.Entity:SetNWString("selected","1")
				info.Entity:SetNWString("owner",""..ply:EntIndex().."")
				elseif info.Entity:GetNWString("selected") == "1" then		
				info.Entity:SetNWString("selected","0")
			end
		end
	end

	if ply:KeyPressed(IN_ATTACK) then
	if ply:Frags() >= 10 then 
			ply:UnSpectate()
			ply:Spawn()
			ply:AddFrags(-10)
			ply:SendLua("DeductPoints()")
			elseif CountPlayerCombineSoldier(ply:EntIndex()) > 0 then  ply:SendLua("notification.AddLegacy('You need at least 10 points to respawn. Wait for your soldiers to gather these points.',    NOTIFY_ERROR   , 5 )")
			else
			ply:UnSpectate()
			ply:Spawn()
			end
	end
end


function GM:KeyPress(ply,key)
local info=ply:GetEyeTraceNoCursor()
	if key == IN_USE then

		if table.HasValue(AllCombineEntities, info.Entity:GetClass()) and info.Entity:GetNWString("owner") == "none" or info.Entity:GetNWString("owner") == ""..ply:EntIndex()..""
			then
			ply:SendLua("totalcombinenumber="..CountPlayerCombine(ply:EntIndex()).."")

			--print(info.Entity:GetClass())
			--print(GetNWString("selected"))
			if info.Entity:GetNWString("selected") == "0" then	
			--ply:EmitSound(table.Random(CombineChat_Select), 75, 100)
			if !info.Entity:GetEnemy() and CanTalk==1 then  info.Entity:EmitSound(table.Random(CombineChat_Idle), 75, 100) CanTalk=0 timer.Simple(1,function() CanTalk=1 end) end

			info.Entity:SetNWString("selected","1")
			info.Entity:SetNWString("owner",""..ply:EntIndex().."")
		--	info.Entity:SetKeyValue("squadname", ""..ply:EntIndex().."")
			print(""..ply:EntIndex().."")
			elseif info.Entity:GetNWString("selected") == "1" then		
			info.Entity:SetNWString("selected","0")
			end
		end
		end
end

function GM:PlayerSpawn(ply)

	ply:SetCustomCollisionCheck(true)
	ply:StripAmmo()
	ply:StripWeapons()
	ply:SetCollisionGroup(0)

if ply:GetNWString("side") == "rebel" then
	ply:SendLua('notification.AddProgress( "HuntedPreparation", "Say !ready to spawn where you are. say !stophunted to become combine again." )')
	ply.huntedready=1
	timer.Simple(1, function()ply:SendLua("light()") end)
			for k, v in pairs(ply:GetWeapons() ) do
			v:SetRenderMode( RENDERMODE_TRANSALPHA )
			v:SetColor(Color(255,255,255,0))
			end
	ply:SetRenderMode( RENDERMODE_TRANSALPHA )
	ply:SetColor(  Color(255,255,255,0))
	ply:SetModel(table.Random(playermodels))
	ply:SetupHands()
	ply:SetNoTarget(true)
	ply:SetMoveType(MOVETYPE_NOCLIP)


else


	if GetConVarString("squad_survival_player_loadout") == "" then else
			print("[Combine Squad Survival]: Loaded "..GetConVarString("squad_survival_player_loadout").." for the players at start.")
			local sentence = ""..GetConVarString("squad_survival_player_loadout")..""
			local words = string.Explode( ",", sentence )
		table.foreach(words, function(key,value)
			ply:Give(value)
		end)
	end

	ply:GiveAmmo( 15, "Buckshot", true )
	ply:GiveAmmo( 150, "AR2", true )
	ply:GiveAmmo( 1, "Grenade", true )		
	ply:SetModel(ply:GetNWString("model"))
	ply:SetupHands()
	ply:SetWalkSpeed(150)
	ply:SetRunSpeed(250)
	ply:SetCrouchedWalkSpeed(0.3)
	ply:AllowFlashlight(true)
	ply:SetNoCollideWithTeammates(1)

	
end
UpdateRelationships()
end
function UpdateRelationships()
--if CurTime() > UpdateRelationshipsCoolDown+0.5 then
print("UpdateRelationships")
table.foreach(ents.GetAll(), function(key,npc)
	if table.HasValue(AllCombineEntities, npc:GetClass()) and npc:GetClass() != "combine_hoppermine"then
		table.foreach(TF2BotBlueEnemies, function(key,value)
			if 1==1  then
				npc:AddRelationship( ""..value.." D_HT 99" )
				--value:AddRelationship( ""..npc:GetClass().." D_HT 99" )
			end	
		end)
		
		table.foreach(AmnesiaSNPCs, function(key,value)
			if 1==1  then
				npc:AddRelationship( ""..value.." D_HT 99" )
				--value:AddRelationship( ""..npc:GetClass().." D_HT 99" )
			end	
		end)
		table.foreach(player.GetAll(), function(key,value)
			if value:GetNWString("side") == "combine"  then
			--	print("likes")
				npc:AddEntityRelationship( value, D_LI, 99 )
				else
			--	print("hates")
				npc:AddEntityRelationship( value, D_HT, 99 )
			end	
		end)
		
		
	end
--
	if table.HasValue(TF2BotBlueEnemies, npc:GetClass()) or table.HasValue(AmnesiaSNPCs, npc:GetClass()) then
	/*	table.foreach(AllCombineEntities, function(key,value)
			if 1==1  then
				npc:AddRelationship( ""..value.." D_HT 99" )
				--value:AddRelationship( ""..npc:GetClass().." D_HT 99" )
			end	
		end) */
		end
--
	if npc:GetClass() == "npc_citizen" then
		table.foreach(player.GetAll(), function(key,value)
			if value:GetNWString("side") == "combine"  then
			--	print("likes")
				npc:AddEntityRelationship( value, D_HT, 99 )
				else
			--	print("hates")
				npc:AddEntityRelationship( value, D_LI, 99 )
			end	
		end)
	end
end)
--UpdateRelationshipsCoolDown=CurTime()
--end


end

function GM:OnEntityCreated(entity)
if entity:GetClass("crossbow_bolt") then entity:SetCollisionGroup(0) end
entity:SetName(entity:GetClass()) 
if entity:GetModel("models/combine_dropship_container.mdl")  then
	entity:SetCollisionGroup(1)
end

 if table.HasValue(AllCombineEntities, entity:GetClass()) and !entity:CreatedByMap() then
	if table.HasValue(CombineSoldiers, entity:GetClass()) then
		entity:SetNWString("selected","0")
		entity:SetNWVector("HoldPosition","NO_VECTOR")
		entity:SetNWString("FollowMe", "no")
		entity:SetNWString("Squad", "")
		if GetConVarNumber("squad_survival_combine_nocollide") == 1 then
		entity:SetCollisionGroup(11)
		end
	end
elseif entity:IsNPC() then
	

	if entity:GetClass() == "npc_headcrab_fast" then entity:SetName("Fast Headcrab") end
	if entity:GetClass() == "npc_headcrab" then entity:SetName("Headcrab") end
	if entity:GetClass() == "npc_zombine" then entity:SetName("Zombine") end
	if entity:GetClass() == "npc_zombie" then entity:SetName("Zombie") end
	if entity:GetClass() == "npc_fastzombie" then entity:SetName("Fast Zombie") end
	if entity:GetClass() == "npc_headcrab_black" then entity:SetName("Poison Headcrab") end
	if entity:GetClass() == "npc_headcrab_poison" then entity:SetName("Poison Headcrab") end

	if entity:GetClass() == "npc_poisonzombie" then entity:SetName("Poison Zombie") end
	if entity:GetClass() == "npc_antlion" then entity:SetName("Antlion") 
	if IsMounted("ep1") or IsMounted("ep2")then if math.random(1,2) == 1 then entity:SetKeyValue( "spawnflags", 262144 )  end end end
	if entity:GetClass() == "npc_antlionguard" then entity:SetName("Antlion Guard") end
	if entity:GetClass() == "npc_headcrab" then entity:SetName("Headcrab") end
	entity:AddRelationship( "player D_HT 20" )
	entity:SetCollisionGroup(3)

	end
	EnemyCountHUD()
	UpdateRelationships()	
	--if entity:GetClass() == "instanced_scripted_scene" or entity:GetClass() == "info_target_command_point" or entity:GetClass() == "ally_speech_manager" then entity:Remove() end
	--print(table.Count(ents.FindByClass("instanced_scripted_scene")))
end

function SpawnRollermine( pos,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 10 then
	NPC = ents.Create( "npc_rollermine" )
	NPC:SetPos(pos)
	NPC:Spawn()
	NPC:SetName("Rollermine")
	--NPC:SetKeyValue( "spawnflags", "1024" )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Rollermine")
	ply:AddFrags(-10) ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Rollermine with less than 10 points.',    NOTIFY_ERROR   , 5 )")
	end
end

function SpawnSniper( pos, ang,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 30 then
	NPC = ents.Create( "npc_sniper" )
	NPC:SetPos( pos+Vector(0,0,-30) )
	NPC:SetAngles( ang ) 
	NPC:Spawn()
	NPC:SetHealth(40)
	NPC:SetKeyValue("PaintInterval", 3)
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetName("Sniper")
	NPC:SetNWString("name","Sniper")
	--NPC:SetKeyValue( "PaintInterval", 1 )
	table.foreach(AllCombineEntities, function(key,value)
		NPC:Fire ( "SetRelationship", ""..value.." D_LI 99" )
		NPC:Fire ( "SetRelationship", "player D_LI 99" )
	end)	
	ply:AddFrags(-30)
ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Sniper with less than 30 points.',    NOTIFY_ERROR   , 5 )")
	end
end

function SpawnCeilingTurretStrong( pos, ang,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 30 then
	NPC = ents.Create( "npc_turret_ceiling" )
	NPC:SetPos( pos )
	NPC:SetAngles( ang ) 
	NPC:SetKeyValue( "spawnflags", "32" )
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:Spawn()
	NPC:SetHealth(50)
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetName("Camera")
	NPC:SetNWString("name","Camera")
	ply:AddFrags(-30)
ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Combine Camera with less than 30 points.',    NOTIFY_ERROR   , 5 )")
	end
end


function SpawnTurret( pos, ang, owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 10 then
	NPC = ents.Create( "npc_turret_floor" )
	NPC:SetPos( pos )
	NPC:SetAngles( ang ) 
	NPC:Spawn()
	NPC:SetName("Turret")
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("name","Turret")
	ply:AddFrags(-10) ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Turret with less than 10 points.',    NOTIFY_ERROR   , 5 )")
	end
end

function SpawnMetropolice( pos, owner )
print("ddd")
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 10 then
	NPC = ents.Create( "npc_metropolice" )
	targetTrace = util.QuickTrace( pos, Vector(0,0,900), NPC)
	NPC:SetKeyValue("Manhacks", 1) 
	NPC:SetKeyValue( "model", ""..GetConVarString("squad_survival_metrocop_model").."" )
if GetConVarNumber("squad_survival_combine_rappel") == 1 then
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetPos( targetTrace.HitPos-Vector(0,0,130) )
else
	NPC:SetPos( pos )
end	
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:SetKeyValue("squadname", "Combine")
	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_RAPID_FIRE).."")
	else
	NPC:Give("ai_weapon_smg1")
	end
	NPC:SetName("Metrocop")
	NPC:Spawn()
if GetConVarNumber("squad_survival_combine_rappel") == 1 then  NPC:Fire("BeginRappel","",0)  end

	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Metrocop")
	NPC:SetHealth("60")
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:EmitSound("items/ammo_pickup.wav",75,100)
	ply:AddFrags(-10) ply:SendLua("DeductPoints()")

	else ply:SendLua("notification.AddLegacy('You cannot afford a Metrocop with less than 10 points.',    NOTIFY_ERROR   , 5 )")
	end
end

function SpawnCombineSRappel( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "2") 
	NPC:SetPos( pos)
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetKeyValue( "spawnflags", 512 )
	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_RAPID_FIRE).."")
	else
	NPC:Give("ai_weapon_ar2")
	end
	NPC:SetName("Combine Soldier")
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Soldier")
	NPC:SetHealth("100")

	NPC:Spawn()
	if GetConVarNumber("squad_survival_combine_rappel") == 1 then NPC:Fire("BeginRappel","",0) end
	NPC:EmitSound("items/ammo_pickup.wav",75,100)

end

function SpawnCombineS( pos,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 10 then

	NPC = ents.Create( "npc_combine_s" )
	targetTrace = util.QuickTrace( pos, Vector(0,0,900), NPC)
	NPC:SetKeyValue("NumGrenades", "2") 
if GetConVarNumber("squad_survival_combine_rappel") == 1 then
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetPos( targetTrace.HitPos-Vector(0,0,130) )
else
	NPC:SetPos( pos )
end	
	NPC:SetKeyValue( "model",""..GetConVarString("squad_survival_soldier_model").."")
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:Spawn()
	if GetConVarNumber("squad_survival_combine_rappel") == 1 then NPC:Fire("BeginRappel","",0) end

	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_RAPID_FIRE).."")
	else
	NPC:Give("ai_weapon_ar2")
	end
	NPC:SetName("Combine Soldier")
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Soldier")
	NPC:SetHealth("100")
	NPC:EmitSound("items/ammo_pickup.wav",75,100)
	ply:AddFrags(-10) ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Soldier with less than 10 points.',    NOTIFY_ERROR   , 5 )")
	end
	--NPC:Fire("StartPatrolling","",0)
end

function SpawnCombineShotgunner ( pos,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 10 then
	targetTrace = util.QuickTrace( pos, Vector(0,0,900), NPC)
	NPC = ents.Create( "npc_combine_s" )


	NPC:SetKeyValue("NumGrenades", "5") 
if GetConVarNumber("squad_survival_combine_rappel") == 1 then
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetPos( targetTrace.HitPos-Vector(0,0,130) )
else
	NPC:SetPos( pos )
end	
	if GetConVarString("squad_survival_shotgunner_model") == "models/Combine_Soldier.mdl" then
	NPC:SetSkin(1)
	else
	NPC:SetKeyValue( "model",""..GetConVarString("squad_survival_shotgunner_model").."")
	end

	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:Spawn()
	if GetConVarNumber("squad_survival_combine_rappel") == 1 then NPC:Fire("BeginRappel","",0) end

	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_SHOTGUNS).."")
	else
	NPC:Give("ai_weapon_shotgun")	
	end
	NPC:SetName("Shotgunner")
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Shotgunner")
	NPC:SetHealth("100")
	NPC:EmitSound("items/ammo_pickup.wav",75,100)
	--NPC:SetCustomCollisionCheck(true)
	--NPC:Fire("StartPatrolling","",0)
		ply:AddFrags(-10) ply:SendLua("DeductPoints()")

	else ply:SendLua("notification.AddLegacy('You cannot afford a Shotgunner with less than 15 points.',    NOTIFY_ERROR   , 5 )")
	end
end

concommand.Add("rpg_fire",function() 
   local r = ents.Create("rpg_missile")
   r:SetPos(player.GetByID(1):GetShootPos() + player.GetByID(1):GetForward() * 72 )
   r:SetAngles( player.GetByID(1):GetAngles() )
	r:SetOwner(player.GetByID(1) )
   r:Spawn()
   r:SetVelocity( r:GetForward() * 9001 )
end)

function SpawnCombineElite( pos,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 20 then

	NPC = ents.Create( "npc_combine_s" )
	targetTrace = util.QuickTrace( pos, Vector(0,0,900), NPC)
	NPC:SetKeyValue("NumGrenades", "1") 
	NPC:SetKeyValue( "model",""..GetConVarString("squad_survival_elite_model").."")
if GetConVarNumber("squad_survival_combine_rappel") == 1 then
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetPos( targetTrace.HitPos-Vector(0,0,130) )
else
	NPC:SetPos( pos )
end		NPC:SetKeyValue( "spawnflags", 768 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("squad_survival_combine_rappel") == 1 then NPC:Fire("BeginRappel","",0) end

	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_RAPID_FIRE).."")
	else
	NPC:Give( "ai_weapon_ar2" )
	end
	NPC:SetName("Elite Soldier")
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Elite Soldier")
	NPC:SetHealth("140")
	NPC:EmitSound("items/ammo_pickup.wav",75,100)
	ply:AddFrags(-20) ply:SendLua("DeductPoints()")

	else ply:SendLua("notification.AddLegacy('You cannot afford a Elite Soldier with less than 20 points.',    NOTIFY_ERROR   , 5 )")
	end
end
function SpawnBasicNPC( pos,npc )
	NPC = ents.Create( ""..npc.."" )
	NPC:SetPos( pos )
	NPC:Spawn()
	print("Spawned"..npc.."")

	--NPC:SetHealth("9000")
end


function SpawnHunter( pos,owner )
local ply = ents.GetByIndex(tonumber(owner))
if IsMounted("ep2") then
if ply:Frags() >= 50 then

	NPC = ents.Create( "npc_hunter" )
	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 512+256 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Hunter")
	NPC:SetName("Hunter")
	NPC:SetHealth("300")
	NPC:AddRelationship( "npc_antlion D_HT 20" )
	ply:AddFrags(-50) ply:SendLua("DeductPoints()")

	else ply:SendLua("notification.AddLegacy('You cannot afford a Hunter with less than 50 points.',    NOTIFY_ERROR   , 5 )")
	end
	else ply:SendLua("notification.AddLegacy('Looks like this game doesn't have HL2:EP2 installed.',    NOTIFY_ERROR   , 5 )") end
end

function SpawnCombinePrisonGuard( pos,owner )
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 15 then
	NPC = ents.Create( "npc_combine_s" )
	targetTrace = util.QuickTrace( pos, Vector(0,0,900), NPC)

	NPC:SetKeyValue("NumGrenades", "1") 
	NPC:SetKeyValue( "model",""..GetConVarString("squad_survival_guard_model").."")
if GetConVarNumber("squad_survival_combine_rappel") == 1 then
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetPos( targetTrace.HitPos-Vector(0,0,130) )
else
	NPC:SetPos( pos )
end	
	NPC:SetKeyValue( "spawnflags", 512+256 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("squad_survival_combine_rappel") == 1 then NPC:Fire("BeginRappel","",0) end

	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_RPGS).."")
	else
	NPC:Give( "ai_weapon_crossbow" )
	end
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Guard")
	NPC:SetName("Guard")
	NPC:SetHealth("100")
	NPC:EmitSound("items/ammo_pickup.wav",75,100)
	ply:AddFrags(-15) ply:SendLua("DeductPoints()")

	else ply:SendLua("notification.AddLegacy('You cannot afford a Guard with less than 15 points.',    NOTIFY_ERROR   , 5 )")
	end
end


function SpawnCombineMine(pos,owner)
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 2 then
	NPC = ents.Create( "combine_hoppermine" )
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetPos( pos )
	NPC:Spawn()
	ply:AddFrags(-2)
	ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Mine with less than 2 points.',    NOTIFY_ERROR   , 5 )")
	end
end
function SpawnRebel(pos)
	NPC = ents.Create( "npc_citizen" )
	NPC:SetPos( pos )
	NPC:SetKeyValue("squadname", "Rebels")
	NPC:SetKeyValue("citizentype", "3")
	NPC:SetName("Rebel")
	NPC:SetKeyValue("spawnflags", 8+256+512+1048576+2097152)
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("squad_survival_use_NPC_PACK_weapons") == 1 then
	NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_ALL).."")
	else
	NPC:Give(table.Random(REBEL_WEAPONS))
	end
	NPC:SetHealth("100")
	NPC:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_PERFECT )	
end


-- BETA NPCs

function SpawnCombineAssasin( pos,owner )
	NPC = ents.Create( "npc_Fassassin" )
	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 512+256 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Assasin")
	NPC:SetName("Assasin")
	NPC:SetHealth("70")
	NPC:AddRelationship( "player D_LI 99" )
	table.foreach(player.GetAll(), function(key,value)
	NPC:AddEntityRelationship( value, D_LI, 99 )
	end)
	table.foreach(ents.GetAll(), function(key,value)
	if value:GetClass() == "npc_sniper" then
	NPC:AddEntityRelationship( value, D_LI, 99 )
	end
	end)

end

function SpawnCombineCremator( pos,owner )
	NPC = ents.Create( "npc_cremator" )

	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 512+256 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "Combine")
	NPC:SetNWString("name","Cremator")
	NPC:SetName("Cremator")
	NPC:SetHealth("900")
	
	--NPC:AddEntityRelationship( "npc_sniper", D_LI, 99 )
	table.foreach(player.GetAll(), function(key,value)
	NPC:AddEntityRelationship( value, D_LI, 99 )
	end)
	table.foreach(ents.GetAll(), function(key,value)
	if value:GetClass() == "npc_sniper" then
	NPC:AddEntityRelationship( value, D_LI, 99 )
	end
	end)

end

-- BETA NPCs

if file.Exists( "gamemodes/combinesquadsurvival/gamemode/maps/"..game.GetMap()..".lua", "GAME" ) then
include("/maps/"..game.GetMap()..".lua")
print("[Combine Squad Survival]: map configuration file found, "..game.GetMap()..".lua")
configfound=1

else
configfound=0
--include("/maps/nomap.lua")
end

function GM:EntityTakeDamage(damaged,damage)
if damaged:IsNPC() and !damaged:GetEnemy() then damage:AddDamage(50) end
if damaged:Health() < 0 and damage:IsDamageType(64) then damaged:Remove() end
if damage:GetAttacker():GetClass() == "npc_headcrab_black" or damage:GetAttacker():GetClass() == "npc_headcrab_poison" then damage:ScaleDamage(1) else damage:ScaleDamage(GetConVarNumber("squad_survival_damage_multiplier")) end



if table.HasValue(AllCombineEntities, damaged:GetClass()) then 
if damaged:GetClass() == "npc_sniper" then
damaged:SetHealth(damaged:Health()-damage:GetDamage())
end
if damage:IsDamageType(   DMG_SLASH   ) and damaged:Health() < 50 then
damaged:SetSchedule(SCHED_MOVE_AWAY)
end
if table.HasValue(AllCombineEntities, damage:GetAttacker():GetClass()) then
damage:ScaleDamage(0)
end

if canplay==1 then
			damaged:EmitSound(table.Random(CombineChat_Damaged), 75, 100)
			canplay=0
			timer.Simple(4, function()  canplay=1 end)
		end
end

end

function GM:Initialize()
	RunConsoleCommand( "g_ragdoll_maxcount", "15")
	RunConsoleCommand( "ai_norebuildgraph", "1")  
end

function MapSetup()

print("Map Setup loaded.")
end

function GM:ShouldCollide(ent1,ent2)
--print("lel")
local owner
if ent1:GetClass() == "npc_combine_s" or ent1:GetNWString("name") == "TheDocument" then 	
		if ent2:GetClass() == "npc_combine_s" or ent2:GetNWString("name") == "TheDocument" then
			if ent1:Distance(ent2) < 100 then
			if ent1:GetClass() == "npc_combine_s" then
			 owner = ents.GetByIndex(tonumber(ent1:GetNWString("owner")))
			 ent2:Remove()
			else
			 owner = ents.GetByIndex(tonumber(ent2:GetNWString("owner")))
			 ent1:Remove()
			end
			print(owner:GetName())
			FindTheDocumentsWin(owner)
		end
	end
end

/*
if ent1:GetClass() == "npc_combine_s" and ent2:GetClass() == "item_healthkit" and ent1:GetPos():Distance(ent2:GetPos()) < 100 then
if ent1:Health() < 50 then
ent1:SetHealth(100) 
ent2:Remove()
end
end

if ent1:GetClass() == "item_healthkit" and ent2:GetClass() == "npc_combine_s" and ent1:GetPos():Distance(ent2:GetPos()) < 100 then
if ent2:Health() < 50 then
ent2:SetHealth(100) 
ent1:Remove()
end
end
*/	

	return true
end
	
function GM:InitPostEntity()
if !combinespawnzones then
print("No combine spawnzones found!")
combinespawnzones = {}
			table.foreach(SPAWNPOINTS, function(key,spawnpoint)
				for k, v in pairs(ents.GetAll()) do
					if v:GetClass() == spawnpoint then
						table.insert(combinespawnzones, v:GetPos())
					end
				end
			end)
end
if !zonescovered then 
print("No zonescovered found!")
zonescovered={}
end
CanSpawnCombine=1
canplay=1
NPCstospawn=0
WaveNumber=0
WaveSpawnReference=0
started=0
fiveseccycletime = CurTime()+10
shortcycletime = CurTime()+10
CanTalk=1
canistersavailable=1
 
 RunConsoleCommand( "g_helicopter_chargetime", "2") 
RunConsoleCommand( "sk_helicopter_burstcount", "20") 
RunConsoleCommand( "sk_helicopter_firingcone", "3") 
RunConsoleCommand( "sk_helicopter_roundsperburst", "5") 
 MapSetup()

end

function GM:OnNPCKilled(victim, killer, weapon)
if victim:GetClass() == "npc_turret_floor" then return true end
if victim:GetClass() == "npc_manhack" or killer:GetClass() == "npc_manhack" then return true end
		if killer:IsPlayer() or killer:IsNPC() then
			net.Start( "PlayerKillNotice" )
			net.WriteString( ""..killer:GetName().."" )
			if weapon:GetClass() == "npc_grenade_frag" or weapon:GetClass() == "crossbow_bolt" then net.WriteString( ""..weapon:GetClass().."" )
			elseif weapon:IsPlayer() or table.HasValue(KillsWithWeapon, killer:GetClass()) then
				net.WriteString( ""..killer:GetActiveWeapon():GetClass().."" )
			else
				net.WriteString( ""..killer:GetClass().."" )
			end
			net.WriteString( ""..victim:GetName().."" )
			net.Broadcast()
		end
 

  if table.HasValue(AllCombineEntities, victim:GetClass())
 then 	
  if victim:GetNWString("owner") then
  local owner = ents.GetByIndex(tonumber(victim:GetNWString("owner")))
  if owner:GetNWString("side") == "combine" then
	owner:SendLua("notification.AddLegacy('"..victim:GetNWString("name").." has died!',   NOTIFY_HINT  , 6 )")
	owner:EmitSound(table.Random(CombineChat_Dead), 75, 100)
	CountPlayerCombineNumber(owner:EntIndex(),"squad1")
	CountPlayerCombineNumber(owner:EntIndex(),"squad2")
	owner:SendLua("totalcombinenumber="..CountPlayerCombine(owner:EntIndex()).."")
end
	if killer:IsPlayer() and killer:GetNWString("side") == "combine" and killer:EntIndex() != owner:EntIndex() then
	if killer.teamkiller != 1 then 
	killer.teamkiller=1
	killer:SendLua("notification.AddLegacy('This is a cooperative game! Dont kill your teammates.',    NOTIFY_ERROR   , 10 )")
	else
	killer:Kick("Do not kill your teammates next time")
	end
	end
	
 end

 end
 

if !victim:OnGround() then
	for k, v in pairs(ents.FindInSphere(victim:GetPos(),1024)) do
		if v:IsPlayer() then
			RunConsoleCommand( "host_timescale", "0.3")   
			timer.Simple(1, function() RunConsoleCommand( "host_timescale", "1") end)
			break
		end
	end
end

if table.HasValue(AllCombineEntities, killer:GetClass()) or killer:GetClass() == "combine_hoppermine"
 then
 
 if canplay==1 then
	killer:EmitSound(table.Random(CombineChat_Kill), 75, 100)
	canplay=0
	timer.Simple(4, function()  canplay=1 end)
	end
 
 if killer:GetNWString("owner") then
	local owner = ents.GetByIndex(tonumber(killer:GetNWString("owner")))
	owner:AddFrags(1)  owner:SendLua("AddPoints()")

 end
 end
 
 
 if table.HasValue(Zombies, victim:GetClass()) and math.random(1,4) == 1 then
 --SpawnItem(table.Random(ZombiesDrop), victim:GetPos(), Angle(0,0,0))
 end
 
if killer:IsPlayer() and !table.HasValue(AllCombineEntities, victim:GetClass()) then


killer:AddFrags(1) killer:SendLua("AddPoints()")
end

if killer:GetNWString("side") == "rebel" then
killer:AddFrags(1) killer:SendLua("AddPoints()")

end

EnemyCountHUD()
end

function EnemyCountHUD()
for k, v in pairs(player.GetAll()) do
v:SendLua("EnemyCountHUD="..CountEnemies().."")
end
end


function EnemiesSelectSpawn()
EnemiesAvailableSpawns = {}

	table.foreach(zonescovered, function(key,value)
		local can = 1
		for k, v in pairs(ents.FindInSphere(value,1000)) do
			if v:IsPlayer() or table.HasValue(AllCombineEntities, v:GetClass()) then
				if v:VisibleVec(value) then
					can = 0
				end
			end
		end
		if can == 1 then

		table.insert(EnemiesAvailableSpawns, value)
		else
		end
	end)

	
if table.Count(EnemiesAvailableSpawns) < 1 then
table.foreach(combinespawnzones, function(key,value)
table.insert(EnemiesAvailableSpawns, value)
end)
else --print(table.Count(EnemiesAvailableSpawns))
end

end

function testcolor ()
	for k, v in pairs(player.GetByID(1):GetWeapons() ) do
	v:SetRenderMode( RENDERMODE_TRANSALPHA )
	v:SetColor(Color(255,255,255,50))
	end
player.GetByID(1):SetRenderMode( RENDERMODE_TRANSALPHA )
player.GetByID(1):SetColor(  Color(255,255,255,50))
end


function SpawnItem (weapon, pos, ang)
	ITEM = ents.Create(weapon)
	ITEM:SetPos( pos )
	ITEM:SetAngles( ang )
	ITEM:Spawn()
end

function FirstSpawn(ply)
ply:SetNWString("model",table.Random(CombinePlayerModels))
timer.Simple(10, function() ply:SendLua("notification.AddLegacy('Spawn your soldiers using the Q menu. Select them with E while alive, Left Click while dead.',   NOTIFY_HINT  , 10 )")
 end)
timer.Simple(20, function() ply:SendLua("notification.AddLegacy('Every enemy your Squad kills, its a point for you. These points are used to buy units.',   NOTIFY_HINT  , 10 )")
 end)
timer.Simple(30, function() ply:SendLua("notification.AddLegacy('Say !hordes, !antlions, !zombies, !document or !hunted to start a minimode.',   NOTIFY_HINT  , 10 )")
 end)
 
timer.Simple(40, function() ply:SendLua("notification.AddLegacy('say !help and these messages will appear again.',   NOTIFY_HINT  , 10 )")
end)
ply:SetNWFloat("EnemyCountHUD", 0)
ply.huntedready=0
ply:SetNWString("side", "combine")
ply:SetFrags(GetConVarNumber("squad_survival_starting_score"))
timer.Simple(3, function() ply:SendLua("CombineBootsRun()")  end)
ply:SendLua("localownerid="..ply:EntIndex().."")
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )

function SpawnHeli( pos,owner)
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 200 then
	NPC = ents.Create( "npc_helicopter" )
	NPC:SetKeyValue( "ignoreunseenenemies", 1 )
	NPC:SetKeyValue( "spawnflags", 262144 )
	NPC:SetPos( pos+Vector(0,0,130) )
	NPC:Spawn()
	NPC:Activate()
	NPC:Fire("activate","",0)
	NPC:SetCollisionGroup(3)

	NPC:SetName("Helicopter")
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "")
	NPC:SetNWString("name","Helicopter")
	NPC:SetHealth("300")
	ply:AddFrags(-200) ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford an Helicopter with less than 200 points.',    NOTIFY_ERROR   , 5 )")
	end
end
function SpawnGunship( pos,owner)
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 250 then
	NPC = ents.Create( "npc_combinegunship" )
	NPC:SetKeyValue( "ignoreunseenenemies", 1 )
	NPC:SetKeyValue( "spawnflags", 262144 )
	NPC:SetPos( pos+Vector(0,0,130) )
	NPC:Spawn()
	NPC:Activate()
	NPC:Fire("activate","",0)
	NPC:SetCollisionGroup(3)

	NPC:SetName("Gunship")
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "")
	NPC:SetNWString("name","Gunship")
	NPC:SetHealth("300")
	ply:AddFrags(-250) ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Gunship with less than 250 points.',    NOTIFY_ERROR   , 5 )")
	end
end

function SpawnDropship( pos,owner)
local ply = ents.GetByIndex(tonumber(owner))
if ply:Frags() >= 100 then
	NPC = ents.Create( "npc_combinedropship" )
	NPC:SetKeyValue( "CrateType", 1 )
	NPC:SetCollisionGroup(3)
	NPC:SetKeyValue( "GunRange", 2048 )
    NPC:SetCustomCollisionCheck(true)
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	--NPC:SetKeyValue( "spawnflags", 262144 )
	NPC:SetPos( pos+Vector(0,0,130) )
	NPC:Spawn()
	NPC:Activate()
	NPC:Fire("activate","",0)
	NPC:SetName("Dropship")
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "")
	NPC:SetNWString("name","Dropship")
	NPC:SetHealth("200")
	ply:AddFrags(-100) ply:SendLua("DeductPoints()")
	else ply:SendLua("notification.AddLegacy('You cannot afford a Dropship with less than 100 points.',    NOTIFY_ERROR   , 5 )")
	end
end



function SpawnAPC( pos, ang )
	spawnairboat = ents.Create("prop_vehicle_apc")
	spawnairboat:SetModel("models/combine_apc.mdl")
	spawnairboat:SetKeyValue("vehiclescript", "scripts/vehicles/apc_npc.txt")
	spawnairboat:SetPos( pos )
	spawnairboat:SetAngles( ang ) 
	spawnairboat:Spawn()
	spawnairboat:Activate()
	
end

function CreatePathCorner()
	creating = ents.Create( "path_corner" )
	creating:SetPos(player.GetByID(1):GetEyeTraceNoCursor().HitPos)
	creating:SetName("pepe2")
	creating:Spawn()
end
			
function MoveAPC()
spawnairboat = ents.Create("npc_apcdriver")
spawnairboat:SetKeyValue("vehicle", "Combine_APC")
spawnairboat:SetPos( player.GetByID(1):GetPos())
spawnairboat:Spawn()
spawnairboat:Activate()
timer.Simple(5, function()
print("done!")
spawnairboat:Fire("GotoPathCorner",""..tostring(player.GetByID(1):GetName()).."",0)  
end)
end
--
function SpawnCanister( pos )

	traceRes = util.QuickTrace(pos, Vector(0,0,2000), player.GetAll())
	--print(traceRes.Entity)
	if traceRes.Entity == NULL or traceRes.HitSky then 
		print("[The Hunt]: Place is suitable for canister deployment ")	
		local canister = ents.Create( "env_headcrabcanister" )
			canister:SetAngles(Angle(-70,0,0))
			canister:SetPos(pos)
			canister:SetKeyValue( "HeadcrabType", math.random(0,2) )
			canister:SetKeyValue( "HeadcrabCount",0 )
			canister:SetKeyValue( "FlightSpeed", "8000" )
			canister:SetKeyValue( "FlightTime", "3" )
			canister:SetKeyValue( "StartingHeight", "0" )
			canister:SetKeyValue( "Damage", "200" )
			canister:SetKeyValue( "DamageRadius", "5" )
			canister:SetKeyValue( "SmokeLifetime", "5" )
			canister:SetKeyValue( "MaxSkyboxRefireTime", "5" )
			canister:SetKeyValue( "MinSkyboxRefireTime", "1" )
			canister:SetKeyValue( "SkyboxCannisterCount", "30" )
			canister:Fire("FireCanister","",0.7)
		canister:Spawn()	
		timer.Simple(100, function() canistersavailable=1 canister:Remove() end)
	else
	PrintMessage(HUD_PRINTTALK, "[Overwatch]: Denied. Place is not reachable.") 

	end
end


function MortarCheck()
local targets = {}
	table.foreach(ents.GetAll(), function(key,ent)
		if (!table.HasValue(AllCombineEntities, ent:GetClass()) and ent:IsNPC()) or (ent:IsPlayer() and ent:GetNWString("side") == "rebel") or (table.HasValue(TF2BotBlueEnemies, ent:GetClass())) then if (ent:OnGround() and ent:Health() > 50) then
			table.insert(targets,ent)
		end end
	end)
	if table.Count(targets) > 0 then
		return table.Random(targets)	
		else return false
	end

end


function LaunchMortarRound()

		local ply = MortarCheck()
	if ply != false then
		
		local targetTrace = util.QuickTrace( ply:GetPos(), ply:GetUp(), ply )		
		if ( targetTrace.HitSky ) then print("unavailable") return end

		local traceRes = util.QuickTrace(ply:GetPos()+ply:GetVelocity(), Vector(0,0,2000), ply)
		if traceRes.Entity == NULL or traceRes.HitSky then 

		local mortar = ents.Create( "func_tankmortar" )	
			mortar:SetPos( traceRes.HitPos)
			mortar:SetAngles( Angle( 90, 0, 0 ) )
			mortar:SetKeyValue( "iMagnitude", 90000) // Damage.
			mortar:SetKeyValue( "firedelay", "2" ) // Time before hitting.
			mortar:SetKeyValue( "warningtime", "1" ) // Time to play incoming sound before hitting.
			mortar:SetKeyValue( "incomingsound", "Weapon_Mortar.Incomming" ) // Incoming sound.
			mortar:Spawn()
		
		local target = ents.Create( "info_target" )
			target:SetPos( targetTrace.HitPos )
			target:SetName( tostring( target ) )
		target:Spawn()
		mortar:DeleteOnRemove( target )
	
		mortar:Fire( "SetTargetEntity", target:GetName(), 0 )
		mortar:Fire( "Activate", "", 0 )
		mortar:Fire( "FireAtWill", "", 0 )
		mortar:Fire( "Deactivate", "", 2 )
		mortar:Fire( "kill", "", 1 )
		else  print("unavailable")

end
		else  print("Not enough people")

end
end






function SpawnItem (weapon, pos, ang)
	ITEM = ents.Create(weapon)
	ITEM:SetPos( pos )
	ITEM:SetAngles( ang )
	ITEM:Spawn()
end
function SpawnProp( pos, ang, model )
	ITEM = ents.Create("prop_physics" )
	ITEM:SetPos( pos )
	ITEM:SetAngles(ang)
	ITEM:SetModel(model)
	ITEM:Spawn()
end
function SpawnDocument( pos, ang, model )
	ITEM = ents.Create("prop_physics" )
	ITEM:SetPos( pos )
	ITEM:SetAngles(ang)
	ITEM:SetModel(model)
	ITEM:SetCollisionGroup( COLLISION_GROUP_NONE )
	ITEM:SetNWString("name","TheDocument")
	ITEM:Spawn()
   -- ITEM:SetCustomCollisionCheck(true)

end
function SpawnStaticProp( pos, ang, model )
	ITEM = ents.Create("prop_physics" )
	ITEM:SetPos( pos )
	ITEM:SetAngles(ang)
	ITEM:SetModel(model)
	ITEM:Spawn()
	ITEM:Fire("DisableMotion","",0)
end


function PropBreak(breaker,prop)
	if prop:IsValid() and breaker:IsPlayer() then
		if prop:GetModel() == "models/props_junk/wood_crate002a.mdl"
		or prop:GetModel() == "models/props_junk/wood_crate001a_damaged.mdl" 
		or prop:GetModel() == "models/props_junk/wood_crate001a_damagedmax.mdl" 
		or prop:GetModel() == "models/props_junk/wood_crate001a_damagedmax.mdl" 
		or prop:GetModel() == "models/props_junk/wood_crate001a.mdl" 
		or prop:GetModel() == "models/props_junk/cardboard_box003a.mdl"
		or prop:GetModel() == "models/props_junk/cardboard_box002a.mdl"
		or prop:GetModel() == "models/props_junk/cardboard_box004a.mdl"
		or prop:GetModel() == "models/props_c17/woodbarrel001.mdl"
		then
				for k, v in pairs(breaker:GetWeapons()) do
					SpawnItem(v:GetClass(),prop:GetPos(),Angle(0,0,0))
				end
				if breaker:Health() < 75 then SpawnItem("item_healthkit",prop:GetPos(),Angle(0,0,0)) end
		end
end

end
hook.Add("PropBreak","OnPropBreak",PropBreak)


function GM:PlayerCanPickupWeapon(ply, wep)
if ply.huntedready == 1 then return false 
end

return true
end

function GM:AllowPlayerPickup(ply,ent) 
if ent:GetNWString("name") == "TheDocument" then
ent:Remove()
local player = ply
FindTheDocumentsWin(player)
end
return true
end
function FindTheDocumentsWin(ply)
for k, v in pairs(player.GetAll()) do
		v:SendLua("notification.AddLegacy('"..ply:GetName().." has found the document.',    NOTIFY_ERROR   , 5 )")
end
ply:AddFrags(50)
ply:SendLua("AddPoints()")

if timer.Exists("ZombieWaveFindTheDocument") then timer.Destroy("ZombieWaveFindTheDocument")  end
CanSpawnCombine=1
end
function Minimode_FindTheDocuments()



CanSpawnCombine=0
print("executed")
FindTheDocuments_Table = {}
if ITEMPLACES then 
for k, v in pairs(ITEMPLACES) do
	table.insert(FindTheDocuments_Table, v)
end
end

	for k, v in pairs(ents.GetAll()) do
		if table.HasValue(FindTheDocuments_Models, v:GetModel()) then
			table.insert(FindTheDocuments_Table, v:GetPos()+Vector(0,0,20))
			print(v:GetModel())
		end
	end
	if table.Count(FindTheDocuments_Table) > 0 then
	SpawnDocument(table.Random(FindTheDocuments_Table),Angle(0,0,0),"models/props_lab/clipboard.mdl")
	PrintMessage(HUD_PRINTTALK, "[Overwatch]: A Document has been placed.") 
	PrintMessage(HUD_PRINTTALK, "[Overwatch]: Find it and get it. Your soldiers can get it too.") 

	timer.Create( "ZombieWaveFindTheDocument", 5, 0, ZombieWaveFindTheDocument )

	else
	PrintMessage(HUD_PRINTTALK, "No suitable places found. Looks like you cannot play FindTheDocuments in this map.") 
	end
end


---- Rebel Substitutes
