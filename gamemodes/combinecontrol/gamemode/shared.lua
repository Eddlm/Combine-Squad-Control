GM.Name = "CombineControl"
GM.Author = "Eddlm"
GM.Email = "eddmalaga@gmail.com"
GM.Website = "http://facepunch.com/showthread.php?t=1391522"

AllCombineEntities = {"npc_combine_s", "npc_metropolice","npc_hunter","npc_fassassin","npc_cremator","npc_rollermine"}
REBEL_WEAPONS = { "ai_weapon_crossbow","ai_weapon_smg1","ai_weapon_shotgun","ai_weapon_ar2"}

Zombies = {"npc_headcrab_fast","npc_zombie","npc_fastzombie","npc_headcrab_black","npc_poisonzombie"}
Monsters = {"npc_antlion","npc_antlionguard"}

SPAWNPOINTS = {
"info_player_terrorist",
"info_player_counterterrorist",
"info_player_start",
"info_player_deathmatch",
}

function ISaid( ply, text, public )

	--string.sub( text, 1, 4 ) == "/all"

    if text == "!soldier" and CountCombine() < GetConVarNumber("cc_max_combine") then
		SpawnCombineS(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end

    if text == "!shotgunner" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombineShotgunner(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
	

    if text == "!elite" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombineElite(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
    if text == "!guard" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombinePrisonGuard(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
	
	/*
if GetConVarNumber("cc_extra_beta_npcs") == 1 then
    if text == "!assasin" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombineAssasin(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
    if text == "!cremator" and CountCombine() < GetConVarNumber("cc_max_combine")+( table.Count(player.GetAll())*2) then
		SpawnCombineCremator(ply:GetEyeTraceNoCursor().HitPos+Vector(0,0,30),ply:EntIndex())
		return false
	end
end
*/
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
    if text == "!mortar" then

timer.Simple(1,function() 		SpawnCanister(ply:GetEyeTraceNoCursor().HitPos)end)
ply:EmitSound("npc/combine_soldier/vo/overwatchrequestskyshield.wav")
PrintMessage(HUD_PRINTTALK, "[Overwatch]: Requested mortar round at "..tostring(ply:GetEyeTraceNoCursor().HitPos).."") 
		return false
	end
	    if text == "!zombies" and started != 1 then
		ZombieWave()
		PrintMessage(HUD_PRINTTALK, "[Overwatch]: More Zombies are coming.") 
		timer.Create( "ZombieWave", 5, 20, ZombieWave )
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
		timer.Create( "AntLionWave", 5, 20, AntLionWave )
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
		timer.Create( "RebelWave", 5, 20, RebelWave )
		WaveNumber=WaveNumber+1
		for k, v in pairs(player.GetAll()) do
	v:GiveAmmo( 15, "Buckshot", true )
	v:GiveAmmo( 150, "AR2", true )
	v:GiveAmmo( 1, "Grenade", true )	
		end
		return false
		end
end	
hook.Add( "PlayerSay", "ISaid", ISaid )



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