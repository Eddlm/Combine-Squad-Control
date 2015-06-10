GM.Name = "Combine Squad Survival"
GM.Author = "Eddlm"
GM.Email = "eddmalaga@gmail.com"
GM.Website = "http://facepunch.com/showthread.php?t=1391522"
-- BLACK MESA --
--
DrVrejZombies = {"sent_vj_zss_fastrand","sent_vj_zss_randregularz","sent_vj_zss_zombierand","sent_vj_zss_zprand"}
BlackMesaSNPCsZombies = {"npc_vj_bmsz_zombiecop","npc_vj_bmsz_zombiesci","npc_vj_bmsz_zombiecop_nheadc","npc_vj_bmsz_zombiesci_nheadc","npc_vj_bmsz_zombiescito_nheadc"}
BlackMesaSNPCsMarines = {"npc_vj_bmssold_marines"}
NoMoreRoomInHell = {"sent_vj_nmrih_runrandz","sent_vj_nmrih_walkrandz","sent_vj_nmrih_randz"}
-- EYE: DIVINE CYBERMANCY npc_vj_eye_carnophage
--
DivineCybermancy = {"npc_vj_eye_deer","npc_vj_eye_kraak","npc_vj_eye_manduco","npc_vj_eye_forma"}
--npc_vj_eye_deusex,
DarkMessiah = {"npc_vj_dmvj_facehugger","npc_vj_dmvj_spider"}
SquadSurvivalWaves = {ZombieWave,AntLionWave}

-- insurgents -- npc_vj_mili_terrorist
playermodels = {
"models/player/group03/male_01.mdl",
"models/player/group03/male_02.mdl",
"models/player/group03/male_03.mdl",
"models/player/group03/male_04.mdl",
"models/player/group03/male_05.mdl",
"models/player/group03/male_06.mdl",
"models/player/group03/male_07.mdl",
"models/player/group03/male_08.mdl",
"models/player/group03/male_09.mdl",
}
AlienSwarm ={"npc_vj_as_boomer","npc_vj_as_drone","npc_vj_as_sbug"}
AmnesiaSNPCs = {"monster_amn_brute","monster_amn_grunt","monster_amn_suitor"}

TF2BotBlue = {"npc_demo_blue","npc_engineer_blue","npc_hwg_blue","npc_medic_blue","npc_pyro_blue","npc_scout_blue","npc_sniper_blue","npc_soldier_blue","npc_spy_blue"}
TF2BotBlueEnemies = {"npc_demo_blue","npc_engineer_blue","npc_hwg_blue","npc_medic_blue","npc_pyro_blue","npc_scout_blue","npc_sniper_blue","npc_soldier_blue","npc_spy_blue","npc_sentry_blue","tf2_dispenser_blue"}
CantHideInPlainSight={"npc_zombie","npc_fastzombie","npc_poisonzombie","npc_combine_s","npc_metropolice","npc_helicopter","npc_gunship"}
HLRenaissance1 = {"monster_alien_controller","monster_alien_grunt","monster_alien_slave",}
HLRenaissance2 = {"monster_gonome",}
HLRenaissance3 = {"monster_bullchicken","npc_devilsquid","npc_frostsquid","monster_houndeye"}
--,"monster_snark","monster_shocktrooper"
HLRenaissanceBosses={"monster_gargantua","monster_bigmomma","monster_babygarg"}

ZombiesDrop = {"weapon_shotgun","weapon_smg1","weapon_frag","weapon_ar2","item_box_buckshot","weapon_crowbar","weapon_357","weapon_crossbow","item_healthkit"}

CombineSoldiers = {"npc_combine_s", "npc_metropolice","npc_hunter","npc_fassassin","npc_cremator","npc_rollermine"}
CombineHelicopters = {"npc_helicopter","npc_combinegunship","npc_combinedropship"}
AllCombineEntities = {"npc_combine_s", "npc_metropolice","npc_hunter","npc_fassassin","npc_cremator","npc_rollermine","npc_helicopter","npc_combinegunship","npc_manhack","npc_turret_floor","npc_turret_ceiling","npc_combinedropship","npc_sniper"}
ControllableCombineEntities = {"npc_combine_s", "npc_metropolice","npc_hunter","npc_fassassin","npc_cremator","npc_rollermine","npc_helicopter","npc_combinegunship","npc_combinedropship"}
REBEL_WEAPONS = { "ai_weapon_crossbow","ai_weapon_smg1","ai_weapon_shotgun","ai_weapon_ar2"}

Zombies = {"npc_zombie","npc_fastzombie","npc_poisonzombie","npc_zombine"}
Monsters = {"npc_antlion","npc_antlionguard"}

KillsWithWeapon={"npc_combine_s", "npc_metropolice","npc_citizen","player"}

SPAWNPOINTS = {
"info_player_terrorist",
"info_player_counterterrorist",
"info_player_start",
"info_player_deathmatch",
}

function ISaid( ply, text, public )
	
  if text == "!help" then

	timer.Simple(1, function() ply:SendLua("notification.AddLegacy('Spawn your soldiers using the Q menu. Select them with E while alive, Left  Click while dead.',   NOTIFY_HINT  , 10 )")
	end)
	timer.Simple(12, function() ply:SendLua("notification.AddLegacy('say !hordes, !antlions, !zombies, !document or !hunted to start a minimode.',   NOTIFY_HINT  , 10 )")
	end)
timer.Simple(24, function() ply:SendLua("notification.AddLegacy('Every enemy your Squad kills, its a point for you. These points are used to buy units.',   NOTIFY_HINT  , 10 )")
end)
end

    if text == "!deploysoldiers" and CountCombine() < GetConVarNumber("squad_survival_max_combine") then
			for k, v in pairs(ents.FindByClass("npc_combinedropship")) do
			SpawnCombineSRappel(v:GetPos()+Vector(50,0,-100),ply:EntIndex())
			SpawnCombineSRappel(v:GetPos()+Vector(-50,0,-100),ply:EntIndex())
			SpawnCombineSRappel(v:GetPos()+Vector(0,50,-100),ply:EntIndex())
			SpawnCombineSRappel(v:GetPos()+Vector(0,-50,-100),ply:EntIndex())

			end
		return false
	end
    if text == "!deploymines"  then
			for k, v in pairs(ents.FindByClass("npc_combinedropship")) do
			v:Fire("DropMines",4,4)
			end
		return false 
	end

if GetConVarNumber("squad_survival_extra_beta_npcs") == 1 then
    if text == "!assassin" and CountCombine() < GetConVarNumber("squad_survival_max_combine") then
		SpawnCombineAssasin(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
    if text == "!cremator" and CountCombine() < GetConVarNumber("squad_survival_max_combine") then
		SpawnCombineCremator(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
end


	    if text == "!hunted" and ply:GetNWString("side") == "combine" then
		ply:SendLua('notification.AddProgress( "HuntedPreparation", "Say !ready to spawn where you are." )')
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
		ply:SetNWString("side", "rebel")
		ply:StripAmmo()
		ply:StripWeapons()		
		ply:SetMoveType(MOVETYPE_NOCLIP)
		for k, v in pairs(player.GetAll() ) do 
		if v:EntIndex() != ply:EntIndex() then
			v:SendLua("notification.AddLegacy('Hunted minimode started. All players must find and kill "..ply:GetName()..".',    NOTIFY_ERROR   , 5 )")	
			end
		end

		return false
		end			
			
		if text == "!ready" and ply.huntedready==1 then
			ply:SendLua('notification.Kill( "HuntedPreparation" )')
			for k, v in pairs(player.GetAll() ) do 
				if v:EntIndex() != ply:EntIndex() then
					v:SendLua("notification.AddLegacy('The Hunted has appeared!',    NOTIFY_HINT   , 5 )")
				end
			end
			ply.huntedready = 0

			for k, v in pairs(ply:GetWeapons() ) do
				v:SetRenderMode( RENDERMODE_TRANSALPHA )
				v:SetColor(Color(255,255,255,255))
			end
			ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			ply:SetColor(  Color(255,255,255,255))
			ply:SetNoTarget(false)
			ply:SetMoveType(MOVETYPE_WALK )
			UpdateRelationships()
			if GetConVarString("squad_survival_player_loadout") == "" then else

				local sentence = ""..GetConVarString("squad_survival_player_loadout")..""
				local words = string.Explode( ",", sentence )
				table.foreach(words, function(key,value)
					ply:Give(value)
				end)
				ply:GiveAmmo( 15, "Buckshot", true )
				ply:GiveAmmo( 350, "AR2", true )
				ply:GiveAmmo( 2, "Grenade", true )	
			end	
			return false
		end			

		
		if text == "!stophunted" and ply.huntedready == 1 then
		ply:SendLua('notification.Kill( "HuntedPreparation" )')
		for k, v in pairs(player.GetAll() ) do 
			if ply != v then
				v:SendLua("notification.AddLegacy('"..ply:GetName().." is no longer Hunted!',    NOTIFY_HINT   , 5 )")
			end
		end
			ply.huntedready = 0
			ply:SetNWString("side","combine")
			for k, v in pairs(ply:GetWeapons() ) do
			v:SetRenderMode( RENDERMODE_TRANSALPHA )
			v:SetColor(Color(255,255,255,255))
			end
			ply:SetRenderMode( RENDERMODE_TRANSALPHA )
			ply:SetColor(  Color(255,255,255,255))
			ply:SetNoTarget(false)
			ply:SetMoveType(MOVETYPE_WALK )
			if GetConVarString("squad_survival_player_loadout") == "" then else

				local sentence = ""..GetConVarString("squad_survival_player_loadout")..""
				local words = string.Explode( ",", sentence )
				table.foreach(words, function(key,value)
					ply:Give(value)
				end)
				ply:GiveAmmo( 15, "Buckshot", true )
				ply:GiveAmmo( 350, "AR2", true )
				ply:GiveAmmo( 2, "Grenade", true )	
			end			
				ply:SetModel("models/player/combine_super_soldier.mdl")
			UpdateRelationships()
elseif text == "!stophunted" and ply.huntedready != 1 then ply:SendLua("notification.AddLegacy('You can only stop this minimode while in preparation mode!',    NOTIFY_ERROR   , 5 )")
		end

	    if text == "!hordes" and started != 1 then
		started=1
		CanSpawnCombine=0
		for k, v in pairs(player.GetAll() ) do 
				v:SendLua("notification.AddProgress( 'Hordes', 'Horde Minimode' )")
		end
		AddonCycleLong()
		return false
	end
	    if text == "!stop" then
		CanSpawnCombine=1
		started=0
		for k, v in pairs(player.GetAll() ) do 
				v:SendLua("notification.Kill( 'Hordes' )")
		end
		timer.Remove( "AddonCycleLong")
		return false
		end
	    if text == "!document" then Minimode_FindTheDocuments() return false end
			   
			   if text == "!remove" then
				if ply:GetEyeTraceNoCursor().Entity then
					if ply:GetEyeTraceNoCursor().Entity:GetNWString("owner") == ""..ply:EntIndex().."" then 	ply:GetEyeTraceNoCursor().Entity:Remove() 
					end
				end
				return false end

	    if text == "!zombies" and started != 1 then
		for k, v in pairs(player.GetAll() ) do 
				v:SendLua("notification.AddLegacy('"..ply:GetName().." started a Zombies wave!',    NOTIFY_HINT   , 5 )")
		end
		--ZombieWave()
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Zombies are coming.") 
		timer.Create( "ZombieWave", 0.5, 20, ZombieWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
			v:GiveAmmo( 15, "Buckshot", true )
			v:GiveAmmo( 150, "AR2", true )
			v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end
		
	    if text == "!antlions" and started != 1 then
		for k, v in pairs(player.GetAll() ) do 
				v:SendLua("notification.AddLegacy('"..ply:GetName().." started an Antlion wave!',    NOTIFY_HINT   , 5 )")
		end
		--PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.") 
		timer.Create( "AntLionWave", 0.5, 20, AntLionWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
	v:GiveAmmo( 15, "Buckshot", true )
	v:GiveAmmo( 150, "AR2", true )
	v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end

		

		
		--
if text == "!tf2bots" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "352877666"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an TF2 Bot wave!',    NOTIFY_HINT   , 5 )")
							v:SendLua("notification.AddLegacy('WARNING: Sentry models wont show properly and throw errors! I am working on it.',    NOTIFY_ERROR   , 8 )")
					end
					--PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.") 
					timer.Create( "TF2BotBlueWave", 2, 5, TF2BotBlueWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the TF2 Bots addon!',    NOTIFY_ERROR   , 8 )") end
		end
		--
		---

if text == "!bmszombies" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "173344427"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started a Black Mesa Zombies wave!',    NOTIFY_HINT   , 5 )")
					end
					--PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.") 
					timer.Create( "BlackMesaSNPCsZombiesWave", 2, 5, BlackMesaSNPCsZombiesWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
					v:GiveAmmo( 15, "Buckshot", true )
					v:GiveAmmo( 150, "AR2", true )
					v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the BlackMesa SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end		
		
		---
	
		--
if text == "!marines" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "173344427"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started a Marines wave!',    NOTIFY_HINT   , 5 )")
					end
					--PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.") 
					timer.Create( "BlackMesaSNPCsMarinesWave", 1, 5, BlackMesaSNPCsMarinesWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
					v:GiveAmmo( 15, "Buckshot", true )
					v:GiveAmmo( 150, "AR2", true )
					v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the BlackMesa SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end
		--		

if text == "!amnesia" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "160134938"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an Amnesia SNPC wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "AmnesiaWave", 1, 5, AmnesiaWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the Amnesia SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end
		
		--		

if text == "!swarm" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "126336699"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an Alien Swarm wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "AlienSwarmWave", 1, 5, AlienSwarmWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the Alien Swarm SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end



if text == "!messiah" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "111626188"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started a Dark Messiah wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "DarkMessiahWave", 1, 5, DarkMessiahWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the Dark Messiah SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end
if text == "!cybermancy" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "144564818"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started a Divine Cybermancy wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "DivineCybermancyWave", 1, 5, DivineCybermancyWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the Divine Cybermancy SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end	

if text == "!hellzombies" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "221942657"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started a No More Room In Hell wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "NoMoreRoomInHellWave", 1, 5, NoMoreRoomInHellWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the No More Room In Hell SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end		


if text == "!zombies2" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "152529683"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started a Zombies wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "DrVrejZombiesWave", 1, 5, DrVrejZombiesWave )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the Zombies SNPCs addon!',    NOTIFY_ERROR   , 8 )") end
		end		
		
		--	
/*		
	    if text == "!rebels" then
	--ply:SendLua("notification.AddLegacy('Rebel waves are disabled until I fix them.',    NOTIFY_ERROR   , 5 )")

		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Rebels are coming.") 
		timer.Create( "RebelWave", 2, 20, RebelWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
	v:GiveAmmo( 15, "Buckshot", true )
	v:GiveAmmo( 150, "AR2", true )
	v:GiveAmmo( 1, "Grenade", true )	
		end
-- 
		return false
		end
*/		
---

if text == "!hlrenaissance1" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "125988781"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an HL:Renaissance(1) wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "hlrenaissance1", 5, 5, hlrenaissance1 )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the HL:Renaissance addon!',    NOTIFY_ERROR   , 8 )") end
		end

if text == "!hlrenaissance2" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "125988781"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an HL:Renaissance(2) wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "hlrenaissance2", 5, 5, hlrenaissance2 )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the HL:Renaissance addon!',    NOTIFY_ERROR   , 8 )") end
		end

if text == "!hlrenaissance3" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "125988781"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an HL:Renaissance(3) wave!',    NOTIFY_HINT   , 5 )")
					end
					timer.Create( "hlrenaissance3", 5, 5, hlrenaissance3 )
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the HL:Renaissance addon!',    NOTIFY_ERROR   , 8 )") end
		end

if text == "!hlrenaissanceboss" and started != 1 then
local can=0
	table.foreach(engine.GetAddons(), function(key,addon) 
		if addon.wsid == "125988781"  and addon.mounted == true then can=1 end
	end)
			if can==1 then
					for k, v in pairs(player.GetAll() ) do 
							v:SendLua("notification.AddLegacy('"..ply:GetName().." started an HL:Renaissance BOSS wave!',    NOTIFY_HINT   , 5 )")
					end
							hlrenaissanceboss()
					WaveNumber=WaveNumber+1
					for k, v in pairs(player.GetAll()) do
				v:GiveAmmo( 15, "Buckshot", true )
				v:GiveAmmo( 150, "AR2", true )
				v:GiveAmmo( 1, "Grenade", true )	
					end
					return false
			else ply:SendLua("notification.AddLegacy('The server does not have the HL:Renaissance addon!',    NOTIFY_ERROR   , 8 )") end
		end
		
---

	  if text == "!red"  then ply:SendLua("notification.AddLegacy('Model color changed to red.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 1, 0, 0 )) end
	  if text == "!blue"  then ply:SendLua("notification.AddLegacy('Model color changed to blue.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 0.1, 0.6, 1)) end
	  if text == "!black"  then ply:SendLua("notification.AddLegacy('Model color changed to black.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 0, 0, 0 )) end
	  if text == "!white"  then ply:SendLua("notification.AddLegacy('Model color changed to white.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 1, 1, 1 )) end
	  if text == "!pink"  then ply:SendLua("notification.AddLegacy('Model color changed to pink.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 1, 0.5, 1 )) end
	  if text == "!green"  then ply:SendLua("notification.AddLegacy('Model color changed to green.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 1, 0, 0 )) end
	  if text == "!gray"  then ply:SendLua("notification.AddLegacy('Model color changed to gray.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 0.3, 0.3, 0.3 )) end
	  if text == "!yellow"  then ply:SendLua("notification.AddLegacy('Model color changed to yellow',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 1, 1,0)) end
	  if text == "!darkblue"  then ply:SendLua("notification.AddLegacy('Model color changed to dark blue.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 0, 0,0.5)) end
	  if text == "!brown"  then ply:SendLua("notification.AddLegacy('Model color changed to brown.',    NOTIFY_GENERIC    , 5 )") ply:SetPlayerColor(Vector( 0.3, 0,0)) end
	  
	  if text == "!elite"  then
	  ply:SetNWString("model","models/player/combine_super_soldier.mdl")
	  ply:SetModel(ply:GetNWString("model"))
	  ply:SendLua("notification.AddLegacy('Model changed to Elite Soldier.',    NOTIFY_GENERIC    , 5 )")
	  end
	  if text == "!guard"  then
	  ply:SetNWString("model","models/player/combine_soldier_prisonguard.mdl")
	  ply:SetModel(ply:GetNWString("model")) 
	  ply:SendLua("notification.AddLegacy('Model changed to Prison Guard .',    NOTIFY_GENERIC    , 5 )")
	  end
	  if text == "!police"  then 
	  ply:SetNWString("model","models/player/police.mdl")
	  ply:SetModel(ply:GetNWString("model")) 
	  ply:SendLua("notification.AddLegacy('Model changed to Metrocop.',    NOTIFY_GENERIC    , 5 )")
		end
	  if text == "!fempolice"  then 
	  ply:SetNWString("model","models/player/police_fem.mdl")
	  ply:SetModel(ply:GetNWString("model")) 
	  ply:SendLua("notification.AddLegacy('Model changed to Metrocop (female).',    NOTIFY_GENERIC    , 5 )")
		end
	  if text == "!soldier"  then 
	  ply:SetNWString("model","models/player/combine_soldier.mdl")
	  ply:SetModel(ply:GetNWString("model")) 
	  ply:SendLua("notification.AddLegacy('Model changed to Soldier.',    NOTIFY_GENERIC    , 5 )")
	end
	if string.sub( text, 1, 1 ) == "!" then return false end
end	
hook.Add( "PlayerSay", "ISaid", ISaid )


function GM:AllowPlayerPickup(ply,ent) 

if ent:GetNWString("name") == "TheDocument" then
ent:Remove()
local player = ply
FindTheDocumentsWin(player)
end

return true
end


CombinePlayerModels={"models/player/police_fem.mdl",
"models/player/combine_soldier_prisonguard.mdl",
"models/player/police.mdl",
"models/player/combine_soldier.mdl"}

NPC_WEAPON_PACK_2_RAPID_FIRE={"npc_acr","npc_m4a1iron","npc_m4a1holo","npc_hk416","npc_g36","npc_ak47","npc_fal","npc_m249","npc_hk21e","npc_ump45","npc_p90","npc_mp5","npc_uzi","npc_m24","npc_M76"}

NPC_WEAPON_PACK_2_PISTOLS={"npc_m9","npc_m1911","npc_deagle"}

NPC_WEAPON_PACK_2_RPGS={"npc_rpg7","npc_matador","npc_m202"}

NPC_WEAPON_PACK_2_SHOTGUNS={"npc_mossberg590"}

NPC_WEAPON_PACK_2_SNIPERS={"npc_m82","npc_as50","npc_awp"}

NPC_WEAPON_PACK_2_ALL={"npc_acr","npc_m4a1iron","npc_m4a1holo","npc_hk416","npc_g36","npc_ak47","npc_fal","npc_m249","npc_hk21e","npc_ump45","npc_p90","npc_mp5","npc_uzi","npc_m24","npc_M76","npc_m9","npc_m1911","npc_deagle","npc_rpg7","npc_matador","npc_m202","npc_mossberg590","npc_m82","npc_as50","npc_awp"}

CombineBootSound = {
"npc/combine_soldier/gear1.wav",
"npc/combine_soldier/gear2.wav",
"npc/combine_soldier/gear3.wav",
"npc/combine_soldier/gear4.wav",
"npc/combine_soldier/gear5.wav",
}


CombineChat_Form={"npc/combine_soldier/vo/weaponsoffsafeprepforcontact.wav","npc/combine_soldier/vo/teamdeployedandscanning.wav","npc/combine_soldier/vo/standingby].wav","npc/combine_soldier/vo/stayalertreportsightlines.wav","npc/combine_soldier/vo/prepforcontact.wav","npc/combine_soldier/vo/readyweapons.wav","npc/metropolice/vo/isreadytogo.wav"}
CombineChat_Okay={"npc/combine_soldier/vo/copythat.wav","npc/combine_soldier/vo/copy.wav","npc/combine_soldier/vo/engaging.wav","npc/combine_soldier/vo/executingfullresponse.wav","npc/combine_soldier/vo/affirmative.wav","npc/combine_soldier/vo/affirmative2.wav","npc/combine_soldier/vo/unitismovingin.wav","npc/metropolice/vo/movingtohardpoint.wav","npc/metropolice/vo/movingtohardpoint2.wav","npc/metropolice/vo/rodgerthat.wav","npc/metropolice/vo/sterilize.wav"}
CombineChat_Hold = {"npc/combine_soldier/vo/hardenthatposition.wav","npc/metropolice/vo/holdthisposition.wav"}
CombineChat_Regroup = {"npc/combine_soldier/vo/targetcompromisedmovein.wav","npc/combine_soldier/vo/targetmyradial.wav","npc/combine_soldier/vo/coverhurt.wav","npc/combine_soldier/vo/coverme.wav"}

CombineChat_Damaged = {"npc/combine_soldier/vo/coverhurt.wav",
"npc/combine_soldier/vo/overwatchsectoroverrun.wav","npc/combine_soldier/vo/overwatchrequestreinforcement.wav","npc/combine_soldier/vo/requestmedical.wav","npc/combine_soldier/vo/requeststimdose.wav","npc/combine_soldier/vo/ripcordripcord.wav","npc/combine_soldier/vo/sharpzone.wav"}

CombineChat_Kill = {"npc/combine_soldier/vo/contained.wav","npc/combine_soldier/vo/hasnegativemovement.wav","npc/combine_soldier/vo/onecontained.wav","npc/combine_soldier/vo/onedown.wav","npc/combine_soldier/vo/stabilizationteamhassector.wav"}

CombineChat_Dead={"npc/combine_soldier/vo/heavyresistance.wav","npc/combine_soldier/vo/overwatchsectoroverrun.wav","npc/combine_soldier/vo/overwatchteamisdown.wav",""}
CombineChat_Killed={"npc/combine_soldier/die1.wav","npc/combine_soldier/die1.wav","npc/combine_soldier/die1.wav"}

CombineChat_Idle = {"npc/combine_soldier/vo/sightlineisclear.wav","npc/combine_soldier/vo/stabilizationteamholding.wav","npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav","npc/combine_soldier/vo/reportingclear.wav","npc/combine_soldier/vo/hasnegativemovement.wav","npc/combine_soldier/vo/reportallradialsfree.wav","npc/combine_soldier/vo/reportallpositionsclear.wav","npc/combine_soldier/vo/stayalertreportsightlines.wav","npc/combine_soldier/vo/sectorissecurenovison.wav","npc/combine_soldier/vo/standingby].wav","npc/combine_soldier/vo/teamdeployedandscanning.wav","npc/metropolice/vo/wearesociostablethislocation.wav"}


CombineChat_Select = {"npc/combine_soldier/vo/readyweapons.wav"}

CombineChat_Go={"npc/metropolice/vo/keepmoving.wav","npc/combine_soldier/vo/gosharpgosharp.wav","npc/combine_soldier/vo/movein.wav","npc/combine_soldier/vo/unitisinbound.wav","npc/combine_soldier/vo/gosharp.wav"}

FindTheDocuments_Models = {"models/props_c17/furniturefrawer001a.mdl","models/props_c17/furnituredrawer001a_chunk03.mdl","models/props_c17/furnituremattress001a.mdl","models/props_c17/furnituremattress001a.mdl","models/props_c17/furnituredrawer002a.mdl","models/props_c17/furnituretable001a.mdl","models/props_c17/furnituretable002a.mdl","models/props_c17/furnituretable003a.mdl","models/props_combine/breendesk.mdl","models/props_interiors/furniture_desk01a.mdl","models/props_wasteland/controlroom_desk001b.mdl","models/props_wasteland/kitchen_counter001b.mdl","models/props_wasteland/kitchen_counter001d.mdl","models/props_wasteland/kitchen_shelf002a.mdl","models/props_wasteland/kitchen_shelf001a.mdl","models/props_wasteland/kitchen_counter001c.mdl","models/props_wasteland/kitchen_counter001a.mdl","models/props_wasteland/prison_bedframe001b.mdl","models/props_combine/breendesk.mdl","models/props/cs_militia/shelves.mdl","models/props/cs_militia/shelves_wood.mdl","models/props/cs_militia/table_kitchen.mdl","models/props/cs_militia/table_shed.mdl","models/props/cs_office/shelves_metal.mdl","models/props/cs_office/table_coffee.mdl","models/props/cs_office/table_meeting.mdl","models/props_junk/trashdumpster01a.mdl"}


if IsMounted("ep1") or IsMounted("ep2") then

table.insert(Zombies, "npc_zombine")

end