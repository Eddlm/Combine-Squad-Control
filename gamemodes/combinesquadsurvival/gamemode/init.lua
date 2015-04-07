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
timer.Create( "ZombieWave", 5, 20, ZombieWave )
PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Necrotics are coming.")
elseif randomnumber == 2 then
timer.Create( "AntLionWave", 5, 20, AntLionWave )
PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.")
else
timer.Create( "RebelWave", 5, 20, RebelWave )
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

end

function AddonCycleLong()
local randompl = d
--PrintMessage(HUD_PRINTTALK, "AddonCycleLong")
timer.Create( "AddonCycleLong", 20, 1, AddonCycleLong)
--timer.Simple(20, AddonCycleLong )
if CountEntity("npc_combine_s") > 1 then
randompl = table.Random(ents.FindByClass("npc_combine_s"))
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
 if CurTime() > gamemodetime+2 then
 --print("Addon Cycle")
gamemodetime = CurTime()


	for k, v in pairs(ents.GetAll()) do
	if table.HasValue(AllCombineEntities, v:GetClass()) and v:Health() > 0 then
	--if !v:GetEnemy() and !v:IsMoving() and math.random(1,4) == 1 then  v:EmitSound(table.Random(CombineChat_Idle), 75, 100) end
		if v:GetNWVector("HoldPosition") != "NO_VECTOR"  then
			if v:GetNWString("Squad") == "no" then
				if v:GetPos():Distance(v:GetNWVector("HoldPosition")) > GetConVarNumber("cc_hold_position_tolerance")
 and !v:IsMoving()then
					v:SetLastPosition(v:GetNWVector("HoldPosition"))
					v:SetSchedule(SCHED_FORCED_GO_RUN)			
				end
			else			
				if v:GetPos():Distance(v:GetNWVector("HoldPosition")) > GetConVarNumber("cc_hold_position_tolerance")
 and !v:IsMoving() then
					v:SetLastPosition(v:GetNWVector("HoldPosition"))
					v:SetSchedule(SCHED_FORCED_GO_RUN)			
				end			
			end		

			if math.random(1,3) == 1 and !v:IsMoving() and !v:GetEnemy() then v:SetSchedule(SCHED_ALERT_SCAN)				  
			end
		end
		
		if v:GetNWString("FollowMe") != "no" then
		local owner = ents.GetByIndex(v:GetNWString("owner"))
				if v:GetPos():Distance(owner:GetPos()+ (owner:GetForward()*-100)) > 400  then
					--print(owner:GetName())
					v:SetLastPosition((owner:GetPos() + (owner:GetForward()*-100))+Vector(math.random(-50,50),math.random(-50,50),0))
					v:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		
		if !v:GetEnemy() and v:Health() < 100 then v:SetHealth(v:Health()+1) end			
end



if !table.HasValue(AllCombineEntities, v:GetClass()) and v:IsNPC() and !v:IsMoving() then
if CountEntity("npc_combine_s") > 0 then
	 randompl = table.Random(ents.FindByClass("npc_combine_s"))
	else
	 randompl = table.Random(ents.FindByClass("player"))
end
	v:SetEnemy(randompl)
	v:SetTarget(randompl)
	v:SetSchedule( SCHED_TARGET_CHASE )
	--print(randompl:GetClass())
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
			v:SetKeyValue( "ignoreunseenenemies", 0 )
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
		v:SetKeyValue("squadname", "Combine")
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
			v:SetKeyValue( "ignoreunseenenemies", 0 )
			v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetNWVector("HoldPosition","NO_VECTOR")	
			v:SetNWString("FollowMe","no")
		client:SendLua("squad2followingyou=0")
		client:SendLua("squad2holdingposition=0")
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
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "yes" then
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
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("Squad") == "yes" and v:GetNWString("owner") == ""..client:EntIndex().."" then
			v:SetNWVector("HoldPosition", client:GetEyeTraceNoCursor().HitPos+Vector(math.random(-50,50),math.random(-50,50),0) )
			v:SetLastPosition(client:GetEyeTraceNoCursor().HitPos)
			v:SetSchedule(SCHED_FORCED_GO_RUN)
			v:SetKeyValue( "ignoreunseenenemies", 0 )
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
		v:SetNWString("Squad", "yes")
		if CanTalk==1 then CanTalk=0  v:EmitSound(table.Random(CombineChat_Form), 75, 100)   timer.Simple(1,function() CanTalk=1 end) end

			client:SendLua("squad1=true")

		end
		end	
		end
end)


net.Receive( "disbandsquad", function( length, client )

		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("Squad") == "yes" and v:GetNWString("owner") == ""..client:EntIndex().."" then
		v:SetNWString("Squad", "no")
		v:SetKeyValue("squadname", "Combine")
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
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "yes" then
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

end)


net.Receive( "squadfollowme", function( length, client )
client:EmitSound(table.Random(CombineChat_Regroup), 75, 100)

		for k, v in pairs(ents.GetAll()) do

		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("Squad") == "yes"  then
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
			v:SetKeyValue( "ignoreunseenenemies", 0 )
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



net.Receive( "selectedgohere", function( length, client )
client:EmitSound(table.Random(CombineChat_Go), 75, 100)
CanTalk=1

local attack=0
		for k, v in pairs(ents.GetAll()) do
		if table.HasValue(AllCombineEntities, v:GetClass()) and v:GetNWString("owner") == ""..client:EntIndex().."" and v:GetNWString("selected") == "1" then
			for _, enemy in pairs(ents.FindInSphere(client:GetEyeTraceNoCursor().HitPos,100)) do
			if !table.HasValue(AllCombineEntities, enemy:GetClass()) and enemy:IsNPC() then
			enemy:SetName("target")
			v:SetKeyValue( "ignoreunseenenemies", 0 )

		--	v:Fire("ThrowGrenadeAtTarget","target",0)
			v:AddEntityRelationship( enemy, D_HT, 99 )
			v:SetEnemy(enemy)
			attack=1
			end
			end
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
	ply:Give("weapon_shotgun")
	ply:Give("weapon_ar2")
	ply:Give("weapon_frag")
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

 if table.HasValue(AllCombineEntities, entity:GetClass()) then
	entity:AddRelationship( "player D_LI 99" )
	entity:SetNWString("owner","none")
	entity:SetNWString("selected","0")
	entity:SetNWVector("HoldPosition","NO_VECTOR")
	entity:SetNWString("FollowMe", "no")
	entity:SetNWString("Squad", "no")
	--entity:SetKeyValue("squadname", "")

	--local randompl = table.Random(player.GetAll())
	--entity:SetTarget(randompl)
elseif entity:IsNPC() then
	if entity:GetClass() == "npc_headcrab_fast" then entity:SetName("Fast Headcrab") end
	if entity:GetClass() == "npc_zombie" then entity:SetName("Zombie") end
	if entity:GetClass() == "npc_fastzombie" then entity:SetName("Fast Zombie") end
	if entity:GetClass() == "npc_headcrab_black" then entity:SetName("Poison Headcrab") end
	if entity:GetClass() == "npc_poisonzombie" then entity:SetName("Poison Zombie") end
	if entity:GetClass() == "npc_antlion" then entity:SetName("Antlion") end
	if entity:GetClass() == "npc_antlionguard" then entity:SetName("Antlion Guard") end
	if entity:GetClass() == "npc_headcrab" then entity:SetName("Headcrab") end
	local randompl = table.Random(ents.FindByClass("player"))
	entity:AddRelationship( "player D_HT 1" )
	entity:SetCollisionGroup(3)
	entity:AddRelationship( "npc_combine_s D_HT 20" )
	end
end



function SpawnCombineS( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "2") 
	NPC:SetPos( pos )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:Spawn()
	if GetConVarNumber("cc_use_NPC_PACK_weapons") == 1 then
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


	--NPC:Fire("StartPatrolling","",0)
end

function SpawnCombineShotgunner ( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "5") 
	NPC:SetPos( pos )
	NPC:SetSkin(1)
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:SetKeyValue( "spawnflags", 512 )
	NPC:Spawn()
	if GetConVarNumber("cc_use_NPC_PACK_weapons") == 1 then
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

	--NPC:Fire("StartPatrolling","",0)
end


function SpawnCombineElite( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "1") 
	NPC:SetKeyValue( "model", "models/Combine_Super_Soldier.mdl" )
	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 768 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("cc_use_NPC_PACK_weapons") == 1 then
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

end
function SpawnBasicNPC( pos,npc )
	NPC = ents.Create( ""..npc.."" )
	NPC:SetPos( pos )
	NPC:Spawn()
	print("Spawned"..npc.."")

	--NPC:SetHealth("9000")
end


function SpawnCombinePrisonGuard( pos,owner )
	NPC = ents.Create( "npc_combine_s" )
	NPC:SetKeyValue("NumGrenades", "1") 
	NPC:SetKeyValue( "model", "models/Combine_Soldier_PrisonGuard.mdl" )
	NPC:SetPos( pos )
	NPC:SetKeyValue( "spawnflags", 512+256 )
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("cc_use_NPC_PACK_weapons") == 1 then
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

end


function SpawnRebel(pos)
	NPC = ents.Create( "npc_citizen" )
	NPC:SetPos( pos )
	NPC:SetKeyValue("squadname", "Rebels")
	NPC:SetKeyValue("citizentype", "3")
	NPC:SetName("Rebel")
	--NPC:SetKeyValue("spawnflags", "65536")
	NPC:SetKeyValue( "ignoreunseenenemies", 0 )
	NPC:Spawn()
	if GetConVarNumber("cc_use_NPC_PACK_weapons") == 1 then
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
	NPC:AddEntityRelationship( player.GetByID(1), D_LI, 99 )

end

function SpawnCombineCremator( pos,owner )
	NPC = ents.Create( "npc_cremator" )
	NPC:AddRelationship( "player D_LI 99" )

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
	NPC:AddRelationship( "player D_LI 99" )
	NPC:AddEntityRelationship( player.GetByID(1), D_LI, 99 )
end

-- BETA NPCs

if file.Exists( "gamemodes/combinecontrol/gamemode/maps/"..game.GetMap()..".lua", "GAME" ) then
include("/maps/"..game.GetMap()..".lua")
print("[The Hunt]: map configuration file found, "..game.GetMap()..".lua")
configfound=1

else
configfound=0
print("[The Hunt]: map config file not found. The Hunt will not start.")
--include("/maps/nomap.lua")
end



function GM:EntityTakeDamage(damaged,damage)

if damaged:IsNPC() and damaged:GetClass() == damage:GetAttacker():GetClass()then
damage:ScaleDamage(0)
damaged:SetSchedule(SCHED_MOVE_AWAY)
end

if damage:GetAttacker():GetClass() != "npc_headcrab_black" then
damage:ScaleDamage(GetConVarNumber("cc_damage_multiplier"))
end

if table.HasValue(AllCombineEntities, damaged:GetClass()) then 
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
gamemodetime = CurTime()
CanTalk=1
end
function GM:OnNPCKilled(victim, killer, weapon)

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


function SpawnStaticProp( pos, ang, model )
	ITEM = ents.Create("prop_physics" )
	ITEM:SetPos( pos )
	ITEM:SetAngles(ang)
	ITEM:SetModel(model)
	ITEM:Spawn()
	ITEM:Fire("DisableMotion","",0)
end

function SpawnCanister( pos )

	traceRes = util.QuickTrace(pos, Vector(0,0,2000), player.GetAll())
	print(traceRes.Entity)
	if traceRes.Entity == NULL or traceRes.HitSky then 
		print("[The Hunt]: Place is suitable for canister deployment ")	
		local canister = ents.Create( "env_headcrabcanister" )
			canister:SetAngles(Angle(-70,math.random(180,-180),0))
			canister:SetPos(pos)
			canister:SetKeyValue( "HeadcrabType", math.random(0,2) )
			canister:SetKeyValue( "HeadcrabCount", math.random(3,6) )
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
		print("[The Hunt]: Place is NOT suitable for canister deployment. Player is under a low ceiling.")	
	end
end