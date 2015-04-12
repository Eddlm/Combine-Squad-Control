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


util.PrecacheModel("models/Combine_Soldier.mdl")
util.PrecacheModel("models/Combine_Super_Soldier.mdl")
util.PrecacheModel("models/Police.mdl")
util.PrecacheModel("models/zombie/classic.mdl")
util.PrecacheModel("models/zombie/fast.mdl")
util.PrecacheModel("models/zombie/poison.mdl")



net.Receive( "SpawnRequest", function( length, client )
local data = net.ReadString()
PrintMessage(HUD_PRINTTALK, net.ReadString())

if CountPlayerCombine(client:EntIndex()) < GetConVarNumber("css_max_combine_per_player") 
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
		traceRes = util.QuickTrace(client:GetEyeTraceNoCursor().HitPos, Vector(0,0,200), player.GetAll())
		if traceRes.Hit then
			SpawnCeilingTurretStrong(client:GetEyeTraceNoCursor().HitPos,client:GetAngles(),client:EntIndex())
		else 
			client:PrintMessage(HUD_PRINTTALK, "Combine Cameras can only spawn on a ceiling.") 	
		end
	end
else
			client:PrintMessage(HUD_PRINTTALK, "You have passed the combine-per-player limit ("..GetConVarNumber("css_max_combine_per_player")..")") 	
end

if data == "Rollermine" then SpawnRollermine(client:GetEyeTraceNoCursor().HitPos+Vector(0,0,20),client:EntIndex()) 
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

if data == "Mortar" then
	local vector = client:GetEyeTraceNoCursor().HitPos

	timer.Simple(2,function() SpawnCanister(vector) end)
	timer.Simple(3,function() SpawnCanister(vector+Vector(100,100,0)) end)
	timer.Simple(4,function() SpawnCanister(vector+Vector(-100,-100,0)) end)
	timer.Simple(5,function() SpawnCanister(vector+Vector(100,-100,0)) end)
	timer.Simple(6,function() SpawnCanister(vector+Vector(-100,100,0)) end)

	client:EmitSound("npc/combine_soldier/vo/overwatchrequestskyshield.wav")
	PrintMessage(HUD_PRINTTALK, "[Overwatch]: Requested mortar round at "..tostring(client:GetEyeTraceNoCursor().HitPos).."") 
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

PrintMessage(HUD_PRINTTALK, "MoreWaves")
WaveNumber=WaveNumber+1
local randomnumber = math.random(1,3)
if randomnumber == 1 then
timer.Create( "ZombieWave", 2, 20, ZombieWave )
PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Necrotics are coming.")
elseif randomnumber == 2 then
timer.Create( "AntLionWave", 2, 20, AntLionWave )
PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.")
else
timer.Create( "RebelWave", 2, 20, RebelWave )
PrintMessage(HUD_PRINTTALK, "[Overwatch]: The Rebels have sent a squad to your position.")
end
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


function CountPlayerCombine(owner)
local entities=0
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) then
		if v:GetNWString("owner") == ""..owner.."" then
			entities=entities+1
			print(v:GetClass())
		end
		end
		end
		return(entities)
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
SpawnBasicNPC(table.Random(combinespawnzones), "npc_antlion")
end

if CountEntity("npc_antlionguard") < 1 and WaveNumber > 5 then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_antlionguard")
end
end

function RebelWave()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

if CountEntity("npc_citizen") < 5+WaveNumber then
SpawnRebel(table.Random(combinespawnzones))
end

if WaveNumber > 5 then
if CountEntity("npc_vortigaunt") < WaveNumber then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_vortigaunt")
end
end
end



function hlrenaissance1()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

	table.foreach(HLRenaissance1, function(key,value)
		if CountEntity(value) < 2+WaveNumber then
		SpawnBasicNPC(table.Random(combinespawnzones),value)
		end
	end)
	
end
function hlrenaissance2()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

	table.foreach(HLRenaissance2, function(key,value)
		if CountEntity(value) < 2+WaveNumber then
		SpawnBasicNPC(table.Random(combinespawnzones),value)
		end
	end)
	
end

function hlrenaissance3()
--PrintMessage(HUD_PRINTTALK, "RebelWave")

	table.foreach(HLRenaissance3, function(key,value)
		if CountEntity(value) < 2+WaveNumber then
		SpawnBasicNPC(table.Random(combinespawnzones),value)
		end
	end)
	
end

function hlrenaissanceboss()

SpawnBasicNPC(table.Random(combinespawnzones),table.Random(HLRenaissanceBosses))

	
end

function ZombieWave()
--PrintMessage(HUD_PRINTTALK, "ZombieWave")

if CountEntity("npc_fastzombie") < math.random(5,7)+WaveNumber then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_fastzombie")
end

if CountEntity("npc_zombie") < math.random(10,20)+WaveNumber then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_zombie")
end

if CountEntity("npc_poisonzombie") < math.random(2,5)+WaveNumber then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_poisonzombie")
end


if IsMounted("ep1") or IsMounted("ep2") then

if CountEntity("npc_zombine") < math.random(2,5)+WaveNumber then
SpawnBasicNPC(table.Random(combinespawnzones), "npc_zombine")
end


end


end

function AddonCycleLong()
local randompl = d
--PrintMessage(HUD_PRINTTALK, "AddonCycleLong")
timer.Create( "AddonCycleLong", 20, 1, AddonCycleLong)
--timer.Simple(20, AddonCycleLong )
if CountEntity("npc_combine_s") > 1 then
randompl = table.Random(ents.FindByClass("npc_combine_s")) table.Random(ents.FindByClass("npc_metropolice")) table.Random(ents.FindByClass("npc_hunter")) table.Random(ents.FindByClass("npc_turret_floor"))
else
randompl = table.Random(ents.FindByClass("player"))
end
--PrintMessage(HUD_PRINTTALK, ""..randompl:GetClass().."")

local	EnemiesLeft=0
for k,zombi in pairs(ents.GetAll()) do 
if table.HasValue(Zombies, zombi:GetClass()) then
	EnemiesLeft=EnemiesLeft+1
	--zombi:SetEnemy(randompl)
	zombi:SetSchedule(  SCHED_ESTABLISH_LINE_OF_FIRE  )
elseif	table.HasValue(Monsters, zombi:GetClass()) then
	EnemiesLeft=EnemiesLeft+1
	--zombi:SetEnemy(randompl)
	zombi:SetSchedule(  SCHED_ESTABLISH_LINE_OF_FIRE  )
elseif zombi:GetClass() == "npc_citizen" then
	EnemiesLeft=EnemiesLeft+1
	--zombi:SetEnemy(randompl)
	zombi:SetSchedule( SCHED_ESTABLISH_LINE_OF_FIRE )
	end
end
PrintMessage(HUD_PRINTTALK, "EnemiesLeft: "..EnemiesLeft.."")

if EnemiesLeft < 1 then MoreWaves() end
end

function GM:Think()

 if CurTime() > gamemodetime+GetConVarNumber("css_think_cycle") then
gamemodetime = CurTime()

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
		if table.HasValue(CombineSoldiers, v:GetClass()) then
		 owner = ents.GetByIndex(v:GetNWString("owner"))

				if v:GetNWVector("HoldPosition") != "NO_VECTOR"  then
					if v:GetNWString("Squad") == "no" then
						if v:GetPos():Distance(v:GetNWVector("HoldPosition")) > GetConVarNumber("css_hold_position_tolerance") and !v:IsCurrentSchedule(50) then
							v:SetLastPosition(v:GetNWVector("HoldPosition"))
							v:SetSchedule(SCHED_FORCED_GO_RUN)			
						end
					else			
						if v:GetPos():Distance(v:GetNWVector("HoldPosition")) > GetConVarNumber("css_hold_position_tolerance") and !v:IsCurrentSchedule(50) then
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

		end
end



	if !v:CreatedByMap() and !table.HasValue(AllCombineEntities, v:GetClass()) and v:IsNPC() and !v:IsMoving() and !v:GetEnemy() then
		if CountEntity("npc_combine_s") > 0 then
		randompl = table.Random(ents.FindByClass("npc_combine_s"))
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
					PrintMessage(HUD_PRINTTALK, ""..v:GetNWString("name").." selected")

		end
		end	

end)
--- Squad 1


function GM:PlayerDeathThink(ply)
local info=ply:GetEyeTraceNoCursor()

	if ply:KeyPressed(IN_ATTACK) then
	if ply:OnGround() then
		PrintMessage(HUD_PRINTTALK, "Spawn using right click.")
		ply:UnSpectate()
		ply:Spectate(6)
		ply:SetMoveType(10)

		elseif table.HasValue(AllCombineEntities, info.Entity:GetClass()) and info.Entity:GetNWString("owner") == "none" or info.Entity:GetNWString("owner") == ""..ply:EntIndex()..""
			then
			print(info.Entity:GetClass())
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

	if ply:KeyPressed(IN_ATTACK2) then

			ply:UnSpectate()
			ply:Spawn()
	end
end


function GM:KeyPress(ply,key)
local info=ply:GetEyeTraceNoCursor()
	if key == IN_USE then
		if table.HasValue(AllCombineEntities, info.Entity:GetClass()) and info.Entity:GetNWString("owner") == "none" or info.Entity:GetNWString("owner") == ""..ply:EntIndex()..""
			then
			print(info.Entity:GetClass())
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
	ply:SetTeam(1)
    ply:SetCustomCollisionCheck(true)
	ply:StripAmmo()
	ply:StripWeapons()
	ply:SetCollisionGroup(11)

	if GetConVarString("css_player_loadout") == "" then else
			print("[Combine Squad Survival]: Loaded "..GetConVarString("css_player_loadout").." for the players at start.")
			local sentence = ""..GetConVarString("css_player_loadout")..""
			local words = string.Explode( ",", sentence )
		table.foreach(words, function(key,value)
			ply:Give(value)
		end)
	end
	/*
	ply:Give("weapon_shotgun")
	ply:Give("weapon_ar2")
	ply:Give("weapon_frag")
	*/
	ply:GiveAmmo( 15, "Buckshot", true )
	ply:GiveAmmo( 150, "AR2", true )
	ply:GiveAmmo( 1, "Grenade", true )		
	ply:SetModel("models/player/combine_super_soldier.mdl")

	ply:SetupHands()
	ply:SetWalkSpeed(150)
	ply:SetRunSpeed(250)
	ply:SetCrouchedWalkSpeed(0.3)
	ply:AllowFlashlight(true)
	ply:SetNoCollideWithTeammates(1)


end

function GM:OnEntityCreated(entity)


if entity:GetModel("models/combine_dropship_container.mdl")  then
	entity:SetCollisionGroup(1)

end

 if table.HasValue(AllCombineEntities, entity:GetClass()) then
	entity:AddRelationship(  "player D_LI 99")
	entity:SetNWString("selected","0")
	entity:SetNWVector("HoldPosition","NO_VECTOR")
	entity:SetNWString("FollowMe", "no")
	entity:SetNWString("Squad", "")
	--entity:SetKeyValue("squadname", "")
	if GetConVarNumber("css_combine_nocollide") == 1 then
	entity:SetCollisionGroup(11)
	end
elseif entity:IsNPC() then
	if entity:GetClass() == "npc_headcrab_fast" then entity:SetName("Fast Headcrab") end
	if entity:GetClass() == "npc_headcrab" then entity:SetName("Headcrab") end
	if entity:GetClass() == "npc_zombine" then entity:SetName("Zombine") end
	if entity:GetClass() == "npc_zombie" then entity:SetName("Zombie") end
	if entity:GetClass() == "npc_fastzombie" then entity:SetName("Fast Zombie") end
	if entity:GetClass() == "npc_headcrab_black" then entity:SetName("Poison Headcrab") end
	if entity:GetClass() == "npc_poisonzombie" then entity:SetName("Poison Zombie") end
	if entity:GetClass() == "npc_antlion" then entity:SetName("Antlion") 
	if IsMounted("ep1") or IsMounted("ep2")then if math.random(1,2) == 1 then entity:SetKeyValue( "spawnflags", 262144 )  end end end
	if entity:GetClass() == "npc_antlionguard" then entity:SetName("Antlion Guard") end
	if entity:GetClass() == "npc_headcrab" then entity:SetName("Headcrab") end
	entity:AddRelationship( "player D_HT 20" )
	entity:SetCollisionGroup(3)

	table.foreach(AllCombineEntities, function(key,value)
		entity:AddRelationship( ""..value.." D_HT 20" )
	end)
	end
end
function SpawnRollermine( pos,owner )
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
end

function SpawnSniper( pos, ang,owner )
	NPC = ents.Create( "npc_sniper" )
	NPC:SetPos( pos+Vector(0,0,-30) )
	NPC:SetAngles( ang ) 
	NPC:Spawn()
	NPC:SetHealth(10)
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetName("Sniper")
	NPC:SetNWString("name","Sniper")
	--NPC:SetKeyValue( "PaintInterval", 1 )
	table.foreach(AllCombineEntities, function(key,value)
		NPC:Fire ( "SetRelationship", ""..value.." D_LI 99" )
		NPC:Fire ( "SetRelationship", "player D_LI 99" )
	end)	

end

function SpawnCeilingTurretStrong( pos, ang,owner )
	NPC = ents.Create( "npc_turret_ceiling" )
	NPC:SetPos( pos )
	NPC:SetAngles( ang ) 
	NPC:SetKeyValue( "spawnflags", "32" )
	NPC:Spawn()
	NPC:SetHealth(2)
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetName("Camera")
	NPC:SetNWString("name","Camera")
end


function SpawnTurret( pos, ang, owner )
	NPC = ents.Create( "npc_turret_floor" )
	NPC:SetPos( pos )
	NPC:SetAngles( ang ) 
	NPC:Spawn()
	NPC:SetName("Turret")
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("name","Turret")

end

function SpawnMetropolice( pos, owner )
	NPC = ents.Create( "npc_metropolice" )
	NPC:SetKeyValue("Manhacks", 1) 
	NPC:SetKeyValue( "model", ""..GetConVarString("css_metrocop_model").."" )
	NPC:SetPos( pos )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:SetKeyValue("squadname", "Combine")
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
		NPC:Give(""..table.Random(NPC_WEAPON_PACK_2_RAPID_FIRE).."")
	else
	NPC:Give("ai_weapon_smg1")
	end
	NPC:SetName("Metrocop")
	NPC:Spawn()
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

end


function SpawnCombineSRappel( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "2") 
	NPC:SetPos( pos)
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "waitingtorappel", 1 )
	NPC:SetKeyValue( "spawnflags", 512 )
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
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
	NPC:Fire("BeginRappel","",0)
	NPC:EmitSound("items/ammo_pickup.wav",75,100)

end

function SpawnCombineS( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "2") 
	NPC:SetPos( pos )
	NPC:SetKeyValue( "model",""..GetConVarString("css_soldier_model").."")
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:Spawn()
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
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


	--NPC:Fire("StartPatrolling","",0)
end

function SpawnCombineShotgunner ( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "5") 
	NPC:SetPos( pos )
	if GetConVarString("css_shotgunner_model") == "models/Combine_Soldier.mdl" then
	NPC:SetSkin(1)
	else
	NPC:SetKeyValue( "model",""..GetConVarString("css_shotgunner_model").."")
	end

	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:Spawn()
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
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

	--NPC:Fire("StartPatrolling","",0)
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
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "1") 
	NPC:SetKeyValue( "model",""..GetConVarString("css_elite_model").."")
	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 768 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
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

end
function SpawnBasicNPC( pos,npc )
	NPC = ents.Create( ""..npc.."" )
	NPC:SetPos( pos )
	NPC:Spawn()
	print("Spawned"..npc.."")

	--NPC:SetHealth("9000")
end


function SpawnHunter( pos,owner )
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
end

function SpawnCombinePrisonGuard( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "1") 
	NPC:SetKeyValue( "model",""..GetConVarString("css_guard_model").."")
	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 512+256 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
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

end


function SpawnRebel(pos)
	NPC = ents.Create( "npc_citizen" )
	NPC:SetPos( pos )
	NPC:SetKeyValue("squadname", "Rebels")
	NPC:SetKeyValue("citizentype", "3")
	NPC:SetName("Rebel")
	NPC:SetKeyValue("spawnflags", 8+256+512)
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("css_use_NPC_PACK_weapons") == 1 then
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
--if damaged:Health() < 1 and damaged:IsNPC() then damaged:Remove() end
damage:ScaleDamage(GetConVarNumber("css_damage_multiplier"))



if table.HasValue(AllCombineEntities, damaged:GetClass()) then 

if damaged:GetClass() == "npc_sniper" then
damaged:SetHealth(damaged:Health()-damage:GetDamage())
end
--print(damage:GetDamageType())
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


	
function GM:InitPostEntity()
if !combinespawnzones then
combinespawnzones = {}
			table.foreach(SPAWNPOINTS, function(key,spawnpoint)
				for k, v in pairs(ents.GetAll()) do
					if v:GetClass() == spawnpoint then
						table.insert(combinespawnzones, v:GetPos())
					end
				end
			end)
end
canplay=1
NPCstospawn=0
WaveNumber=0
WaveSpawnReference=0
started=0
gamemodetime = CurTime()+10
CanTalk=1
end

function GM:OnNPCKilled(victim, killer, weapon)
if victim:GetClass() == "npc_turret_floor" then return true end
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
 if table.HasValue(AllCombineEntities, killer:GetClass())
 then
 
 if canplay==1 then
	killer:EmitSound(table.Random(CombineChat_Kill), 75, 100)
	canplay=0
	timer.Simple(4, function()  canplay=1 end)
	end
 
 if killer:GetNWString("owner") != "none" then
	local owner = ents.GetByIndex(tonumber(killer:GetNWString("owner")))
	owner:AddFrags(1) 
 end
 end

  if table.HasValue(AllCombineEntities, victim:GetClass())
 then 
  if victim:GetNWString("owner") != "none" then
	local owner = ents.GetByIndex(tonumber(victim:GetNWString("owner")))
  owner:PrintMessage(HUD_PRINTTALK, ""..victim:GetNWString("name").." has died!")
  owner:SetFrags(math.Round(owner:Frags()/2,0))
	owner:EmitSound(table.Random(CombineChat_Dead), 75, 100)
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
end


function FirstSpawn(ply)
if configfound==1 then
ply:PrintMessage(HUD_PRINTTALK, "Prepare yourself and say !start when you are ready.")
ply:PrintMessage(HUD_PRINTTALK, "Say !stop if you want a break.")
end
timer.Simple(3, function() ply:SendLua("CombineBootsRun()")  end)

ply:SendLua("localownerid="..ply:EntIndex().."")
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )

/*
function GM:ShouldCollide(ent1,ent2)
	if ent1:GetClass() == "npc_combinedropship" then 	

		if ent2:GetClass() == "npc_combine_s" then
		print("lelele")
			return false
		end
	end
	if ent2:GetClass() == "npc_combinedropship" then
		if ent1:GetClass() == "npc_combine_s"  then
			print("lelele")

			return false
		end
	end
	
	
	return true
end
*/
function SpawnHeli( pos,owner)

	NPC = ents.Create( "npc_helicopter" )
	NPC:SetKeyValue( "ignoreunseenenemies", 1 )
	NPC:SetKeyValue( "spawnflags", 262144 )
	NPC:SetPos( pos+Vector(0,0,100) )
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
	NPC:SetHealth("100")

end
function SpawnGunship( pos,owner)

	NPC = ents.Create( "npc_combinegunship" )
	NPC:SetKeyValue( "ignoreunseenenemies", 1 )
	NPC:SetKeyValue( "spawnflags", 262144 )
	NPC:SetPos( pos+Vector(0,0,100) )
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
	NPC:SetHealth("100")

end

function SpawnDropship( pos,owner)

	NPC = ents.Create( "npc_combinedropship" )
	NPC:SetKeyValue( "CrateType", 1 )
	NPC:SetCollisionGroup(3)

	NPC:SetKeyValue( "GunRange", 2048 )

    NPC:SetCustomCollisionCheck(true)

	NPC:SetKeyValue( "ignoreunseenenemies", 0 )

	--NPC:SetKeyValue( "spawnflags", 262144 )
	NPC:SetPos( pos+Vector(0,0,100) )
	NPC:Spawn()
	NPC:Activate()
	NPC:Fire("activate","",0)
	--NPC:SetCollisionGroup(1)
	NPC:SetName("Dropship")
	NPC:SetNWString("owner",""..owner.."")
	NPC:SetNWString("selected","0")
	NPC:SetNWVector("HoldPosition","NO_VECTOR")
	NPC:SetNWString("FollowMe", "no")
	NPC:SetNWString("Squad", "no")
	NPC:SetKeyValue("squadname", "")
	NPC:SetNWString("name","Dropship")
	NPC:SetHealth("200")

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
			canister:SetKeyValue( "HeadcrabCount", /*math.random(3,6)*/ 0 )
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
		timer.Simple(100, function() canister:Remove() end)
	else
	PrintMessage(HUD_PRINTTALK, "[Overwatch]: Denied. Place is not reachable.") 

	end
end