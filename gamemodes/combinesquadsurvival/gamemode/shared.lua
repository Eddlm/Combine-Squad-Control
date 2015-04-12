GM.Name = "Combine Squad Survival"
GM.Author = "Eddlm"
GM.Email = "eddmalaga@gmail.com"
GM.Website = "http://facepunch.com/showthread.php?t=1391522"


HLRenaissance1 = {"monster_alien_controller","monster_alien_grunt","monster_alien_slave",}
HLRenaissance2 = {"monster_gonome",}
HLRenaissance3 = {"monster_bullchicken","npc_devilsquid","npc_frostsquid","monster_houndeye"}
--,"monster_snark","monster_shocktrooper"
HLRenaissanceBosses={"monster_gargantua","monster_bigmomma","monster_babygarg"}



RelationshipIssuesSet={"npc_sniper"}
RelationshipIssuesAddEntity={"npc_fassassin","npc_cremator"}
NoRelationshipIssues={"npc_combine_s", "npc_metropolice","npc_hunter","npc_rollermine","npc_helicopter","npc_gunship","npc_manhack","npc_turret_floor","npc_turret_ceiling","npc_combinedropship"}

CombineSoldiers = {"npc_combine_s", "npc_metropolice","npc_hunter","npc_fassassin","npc_cremator","npc_rollermine","npc_sniper"}
CombineHelicopters = {"npc_helicopter","npc_combinegunship","npc_combinedropship"}
AllCombineEntities = {"npc_combine_s", "npc_metropolice","npc_hunter","npc_fassassin","npc_cremator","npc_rollermine","npc_helicopter","npc_combinegunship","npc_manhack","npc_turret_floor","npc_turret_ceiling","npc_combinedropship","npc_sniper"}
REBEL_WEAPONS = { "ai_weapon_crossbow","ai_weapon_smg1","ai_weapon_shotgun","ai_weapon_ar2"}

Zombies = {"npc_headcrab_fast","npc_zombie","npc_fastzombie","npc_headcrab_black","npc_poisonzombie"}
Monsters = {"npc_antlion","npc_antlionguard"}

KillsWithWeapon={"npc_combine_s", "npc_metropolice","npc_citizen","player"}

SPAWNPOINTS = {
"info_player_terrorist",
"info_player_counterterrorist",
"info_player_start",
"info_player_deathmatch",
}

function ISaid( ply, text, public )
	

    if text == "!deploysoldiers" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
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

if GetConVarNumber("cc_extra_beta_npcs") == 1 then
    if text == "!assassin" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombineAssasin(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
    if text == "!cremator" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombineCremator(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
end

	    if text == "!start" and started != 1 then
		started=1
		AddonCycleLong()
		return false
	end
	    if text == "!stop" and started == 1 then
		started=0
		timer.Remove( "AddonCycleLong")
		return false
		end
		
	    if text == "!zombies" and started != 1 then
		ZombieWave()
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Zombies are coming.") 
		timer.Create( "ZombieWave", 2, 20, ZombieWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
	v:GiveAmmo( 15, "Buckshot", true )
	v:GiveAmmo( 150, "AR2", true )
	v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end
		
	    if text == "!antlions" and started != 1 then
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Antlions are coming.") 
		timer.Create( "AntLionWave", 2, 20, AntLionWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
	v:GiveAmmo( 15, "Buckshot", true )
	v:GiveAmmo( 150, "AR2", true )
	v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end
		
	    if text == "!rebels" and started != 1 then
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Rebels are coming.") 
		timer.Create( "RebelWave", 2, 20, RebelWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
	v:GiveAmmo( 15, "Buckshot", true )
	v:GiveAmmo( 150, "AR2", true )
	v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end

	if	GetConVarNumber("cc_hlrenaissance") == 1 then
		    if text == "!hlrenaissance1" and started != 1 then
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: Done.") 
		timer.Create( "hlrenaissance1", 2, 20, hlrenaissance1 )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
			v:GiveAmmo( 15, "Buckshot", true )
			v:GiveAmmo( 150, "AR2", true )
			v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end	
		    if text == "!hlrenaissance2" and started != 1 then
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: Done.") 
		timer.Create( "hlrenaissance2", 2, 20, hlrenaissance1 )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
			v:GiveAmmo( 15, "Buckshot", true )
			v:GiveAmmo( 150, "AR2", true )
			v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end	
		    if text == "!hlrenaissance3" and started != 1 then
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: Done.") 
		timer.Create( "hlrenaissance3", 2, 20, hlrenaissance3 )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
			v:GiveAmmo( 15, "Buckshot", true )
			v:GiveAmmo( 150, "AR2", true )
			v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end	

			   if text == "!hlrenaissanceboss" and started != 1 then
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: Done.") 
		timer.Create( "hlrenaissanceboss", 2, 1, hlrenaissanceboss )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
			v:GiveAmmo( 15, "Buckshot", true )
			v:GiveAmmo( 150, "AR2", true )
			v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end	
		
		
		end
		
--	if string.sub( text, 1, 1 ) == "!" then return false end

end	
hook.Add( "PlayerSay", "ISaid", ISaid )




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


CombineChat_Idle = {"npc/combine_soldier/vo/sightlineisclear.wav","npc/combine_soldier/vo/stabilizationteamholding.wav","npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav","npc/combine_soldier/vo/reportingclear.wav","npc/combine_soldier/vo/hasnegativemovement.wav","npc/combine_soldier/vo/reportallradialsfree.wav","npc/combine_soldier/vo/reportallpositionsclear.wav","npc/combine_soldier/vo/stayalertreportsightlines.wav","npc/combine_soldier/vo/sectorissecurenovison.wav","npc/combine_soldier/vo/standingby].wav","npc/combine_soldier/vo/teamdeployedandscanning.wav","npc/metropolice/vo/wearesociostablethislocation.wav"}


CombineChat_Select = {"npc/combine_soldier/vo/readyweapons.wav"}

CombineChat_Go={"npc/metropolice/vo/keepmoving.wav","npc/combine_soldier/vo/gosharpgosharp.wav","npc/combine_soldier/vo/movein.wav","npc/combine_soldier/vo/unitisinbound.wav","npc/combine_soldier/vo/gosharp.wav"}



if IsMounted("ep1") or IsMounted("ep2") then

table.insert(Zombies, "npc_zombine")

end