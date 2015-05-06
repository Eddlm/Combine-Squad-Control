AddCSLuaFile( "shared.lua" )
include( "shared.lua" )


darkencolor = Color(255,0,0)
HUDTEXT = "Hidden"
HUDCOLOR = Color(0,255,0)
light_above_limit = 3
LIGHTEXT = 'Visible'
LIGHTCOLOR = Color(255,0,0)
lightcol = 0
playerfrags=0
pointscolor=Color(255,255,255)
EnemyCountHUD=0
CanShowCommands = false


net.Receive( "Spotted", function( length, client )
	HUDTEXT = 'Spotted'
	HUDCOLOR=Color(255,8,8)
end )

net.Receive( "Hidden", function( length, client )
	HUDTEXT = 'Safe'
	HUDCOLOR=Color(0,255,0)
end )

net.Receive( "NotVisible", function( length, client )
	LIGHTEXT = 'Not Visible'
	LIGHTCOLOR = Color(0,255,0) 
end )

net.Receive( "Visible", function( length, client )
	LIGHTEXT = 'Visible'
	LIGHTCOLOR = Color(255,255,0)
end )

function AddPoints()
pointscolor=Color(0,255,0)
timer.Simple(1,function() pointscolor=Color(255,255,255) end)
end
function DeductPoints()
pointscolor=Color(255,0,0)
timer.Simple(1,function() pointscolor=Color(255,255,255) end)
end
highlightkey = 2
orderskey= 2
localownerid=1
canshow=1
outlinestoggle=1
squad2=false
squad2holdingposition=0
squad2followingyou=0
squad1holdingposition=0
squad1followingyou=0
squad1=false
squad1numbers=0
squad2numbers=0
totalcombinenumber=0

killicon.AddFont( "prop_physics",		"HL2MPTypeDeath",	"9",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_smg1",		"HL2MPTypeDeath",	"/",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_357",			"HL2MPTypeDeath",	".",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_ar2",			"HL2MPTypeDeath",	"2",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "crossbow_bolt",		"HL2MPTypeDeath",	"1",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_shotgun",		"HL2MPTypeDeath",	"0",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_rpg_missile",		"HL2MPTypeDeath",	"3",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "npc_grenade_frag",	"HL2MPTypeDeath",	"4",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_pistol",		"HL2MPTypeDeath",	"-",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "prop_combine_ball",	"HL2MPTypeDeath",	"8",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "grenade_ar2",		"HL2MPTypeDeath",	"7",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_stunstick",	"HL2MPTypeDeath",	"!",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "npc_satchel",		"HL2MPTypeDeath",	"*",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "npc_tripmine",		"HL2MPTypeDeath",	"*",	Color( 255, 80, 0, 255 ) )
killicon.AddFont( "ai_weapon_crowbar",		"HL2MPTypeDeath",	"6",	Color( 255, 80, 0, 255 ) )

if !ConVarExists("css_orders") then
	CreateClientConVar( "css_orders", KEY_Q, true, false )
end

if !ConVarExists("css_highlight") then
	CreateClientConVar( "css_highlight", KEY_X, true, false )
end
-- GetConVarNumber("css_highlight")
net.Receive( "PlayerKillNotice", function( len, ply )
	GAMEMODE:AddDeathNotice(net.ReadString(), 0, net.ReadString(), net.ReadString(), 1001)
end)

--GetConVarNumber("css_ddd")
hook.Add( "PreDrawHalos", "AddHalos", function()
if LocalPlayer():GetNWString("side") == "combine" then

	if LocalPlayer() and LocalPlayer():GetPos()  then
		for k, v in pairs(ents.GetAll()) do
			if v:GetNWString("name") == "TheDocument" and ( LocalPlayer():GetPos():Distance( v:GetPos() ) ) < 300  then halo.Add( {v}, Color( 255,255,255 ), 1, 1, 1, true, true ) end
			if table.HasValue(AllCombineEntities, v:GetClass())  then

				if v:GetNWString("selected") == "1" and v:GetNWString("owner") == tostring(localownerid) then
						halo.Add( {v}, Color( 255,255,255 ), 1, 1, 1, true, true )
				elseif v:GetNWString("Squad") == "squad1" and v:GetNWString("owner") == tostring(localownerid) and input.IsKeyDown(GetConVarNumber("css_highlight")) then
						halo.Add( {v}, Color( 150,0,0 ), 1, 1, 1, true, true )
						
				elseif v:GetNWString("Squad") == "squad2" and v:GetNWString("owner") == tostring(localownerid) and input.IsKeyDown(GetConVarNumber("css_highlight")) then
						halo.Add( {v}, Color( 0,0,150 ), 1, 1, 1, true, true )
						
				elseif v:GetNWString("owner") == tostring(localownerid) and input.IsKeyDown( GetConVarNumber("css_highlight")) then
						halo.Add( {v}, Color( 100,100,100 ), 1, 1, 1, true, true )				
				end
			end
		end
	end

else		
		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetEyeTraceNoCursor().HitPos, 500)) do
			if table.HasValue(AllCombineEntities, v:GetClass()) then
				if v:IsValid() then
						halo.Add( {v}, Color( 84,2,2 ), 1, 1, 1, true, true )
				end
			end
			if v:GetClass() == "item_healthcharger" and LocalPlayer():Health() < 40 and LocalPlayer():Health() > 0 then
				halo.Add( {v}, Color( 0,204,255 ), 1, 1, 1, true, true )
			end

		end	
end
	
end)

hook.Add( "HUDPaint", "HuntHud", function()
if LocalPlayer():GetNWString("side") == "combine" then

if !LocalPlayer():Alive() then
draw.DrawText( "·", "TargetIDsmall", ScrW() * 0.5, ScrH() * 0.49, Color(255,255,255), TEXT_ALIGN_CENTER )
end

draw.DrawText( "Points: "..playerfrags.."", "TargetIDsmall", ScrW()/2, ScrH()/1.02, pointscolor, TEXT_ALIGN_CENTER )
if EnemyCountHUD > 0 then
draw.DrawText( "Enemies: "..EnemyCountHUD.."", "TargetIDsmall", ScrW()/2, ScrH()/1.06, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
end

local color = Color( 0,255,0 )
if squad1==false then color = Color( 255,0,0 ) else color = Color( 0,255,0 ) end
draw.SimpleText( "Alpha ("..squad1numbers..")", "TargetID", ScrW()/2.4, ScrH()/1.06,color, TEXT_ALIGN_CENTER)
if squad2==false then color = Color( 255,0,0 ) else color = Color( 0,255,0 ) end
draw.SimpleText( "Bravo ("..squad2numbers..")", "TargetID", ScrW()/1.7, ScrH()/1.06, color, TEXT_ALIGN_CENTER)


draw.DrawText( "Total units: "..totalcombinenumber.."", "TargetIDsmall", ScrW()/2, ScrH()/1.04, Color(255,255,255), TEXT_ALIGN_CENTER )

if squad2holdingposition==1 then
	text = "Holding Position"
else
	text = "Not Holding Position"
end
draw.SimpleText( text, "TargetIDSmall", ScrW()/1.7, ScrH()/1.04, Color( 0,255,255 ), TEXT_ALIGN_CENTER)

if squad1holdingposition==1 then
	text = "Holding Position"
else
	text = "Not Holding Position"
end
draw.SimpleText( text, "TargetIDSmall", ScrW()/2.4, ScrH()/1.04, Color( 0,255,255 ), TEXT_ALIGN_CENTER)

if squad2followingyou==1 then
	text = "Following you"
else
	text = "Not Following you"
end
draw.SimpleText( text, "TargetIDSmall", ScrW()/1.7, ScrH()/1.02, Color( 0,255,255 ), TEXT_ALIGN_CENTER)


if squad1followingyou==1 then
	text = "Following you"
else
	text = "Not Following you"
end
draw.SimpleText( text, "TargetIDSmall", ScrW()/2.4, ScrH()/1.02, Color( 0,255,255 ), TEXT_ALIGN_CENTER)

else
		draw.RoundedBox(6 , ScrW()*0.027, ScrH() * 0.84, 140, 44, Color(255,255,255,20))

		draw.DrawText( LIGHTEXT, "TargetID", ScrW() * 0.03, ScrH() * 0.84, LIGHTCOLOR, TEXT_ALIGN_LEFT )
		draw.DrawText( "Illumination: "..math.Round(lightcol,1).."", "TargetID", ScrW() * 0.03, ScrH() * 0.86, darkencolor, TEXT_ALIGN_LEFT )
end


if CanShowCommands == true then
local line = 0
draw.RoundedBox(6 , ScrW()*0.25, ScrH() * 0.2, ScrW()*0.5, ScrH() * 0.25+100, Color(255,255,255,20))
draw.DrawText( "Wave Commands", "TargetID", ScrW()*0.5,(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_CENTER )
line=line+20
draw.DrawText( "HL2: !zombies, !antlions", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
line=line+20
draw.DrawText( "Amnesia SNPCs: !amnesia", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
line=line+20
draw.DrawText( "TF2Bots: !tf2bots", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )

line=line+20
draw.DrawText( "BlackMesa SNPCs: !marines, !bmszombies", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )

line=line+20
draw.DrawText( "Half Life: Renaissance: !hlrenaissance1, !hlrenaissance2, !hlrenaissance3, !hlrenaissanceboss", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )

line=line+20
draw.DrawText( "Divine Cybermancy SNPCs:  !cybermancy", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )

line=line+20
draw.DrawText( "No More Room In Hell SNPCs:  !hellzombies", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )


line=line+20
draw.DrawText( "DrVrej Zombies:  !zombies2", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
line=line+20
draw.DrawText( "Alien Swarm:  !swarm", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
line=line+20
draw.DrawText( "Dark Messiah:  !messiah", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )


line=line+50
draw.DrawText( "Minimode Commands", "TargetID", ScrW()*0.5,(ScrH() * 0.2)+line, Color(255,255,255), TEXT_ALIGN_CENTER )
line=line+20
draw.DrawText( "Hunted: !hunted, !stophunted", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
line=line+20
draw.DrawText( "Find the Document: !document", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
line=line+20
draw.DrawText( "Automatic waves: !hordes, !stop", "TargetID", ScrW()*0.25+5, line+(ScrH() * 0.2), Color(255,255,255), TEXT_ALIGN_LEFT )
end

end)

hook.Add("Tick", "KeyDown_Test", function()
if LocalPlayer():GetNWString("side") == "combine" then

if input.IsKeyDown(GetConVarNumber("css_orders")) then
gui.EnableScreenClicker(true)		
	if canshow==1 then
		canshow=0
			gui.EnableScreenClicker(true)		
			Regroup:SetVisible(true)
			SquadGoHere:SetVisible(true)
			SquadHoldPosition:SetVisible(true)
			SelectedGoHere:SetVisible(true)
			SelectedFollowMe:SetVisible(true)
			SelectedHoldPosition:SetVisible(true)
			UnselectAll:SetVisible(true)
			SquadFollowMe:SetVisible(true)
			DisbandSquad:SetVisible(true)
			FormSquadFromSelected:SetVisible(true)
			SquadRegroup:SetVisible(true)		
			SelectAllNonSelected:SetVisible(true)		
			Squad2FollowMe:SetVisible(true)
			Squad2Regroup:SetVisible(true)	
			DisbandSquad2:SetVisible(true)
			FormSquad2FromSelected:SetVisible(true)
			Squad2GoHere:SetVisible(true)
			Squad2HoldPosition:SetVisible(true)	
			MenuButton:SetVisible(true)
			MenuButtonAir:SetVisible(true)
			MenuButtonMachines:SetVisible(true)
			LaunMortar:SetVisible(true)
			DismissAirUnits:SetVisible(true)
			AddZoneSelected:SetVisible(true)
			ClearZoneSelected:SetVisible(true)
			RequestAmmo:SetVisible(true)
	end

elseif canshow==0 then 
canshow=1
			gui.EnableScreenClicker(false)
			Regroup:SetVisible(false)
			SquadGoHere:SetVisible(false)
			SquadHoldPosition:SetVisible(false)
			SelectedGoHere:SetVisible(false)
			SelectedFollowMe:SetVisible(false)
			SelectedHoldPosition:SetVisible(false)
			UnselectAll:SetVisible(false)
			SquadFollowMe:SetVisible(false)
			DisbandSquad:SetVisible(false)
			FormSquadFromSelected:SetVisible(false)
			SquadRegroup:SetVisible(false)	
			SelectAllNonSelected:SetVisible(false)		
			Squad2FollowMe:SetVisible(false)
			Squad2Regroup:SetVisible(false)	
			DisbandSquad2:SetVisible(false)
			FormSquad2FromSelected:SetVisible(false)
			Squad2GoHere:SetVisible(false)
			Squad2HoldPosition:SetVisible(false)
			MenuButton:SetVisible(false)
			MenuButtonAir:SetVisible(false)
			MenuButtonMachines:SetVisible(false)
			LaunMortar:SetVisible(false)
			DismissAirUnits:SetVisible(false)
			AddZoneSelected:SetVisible(false)
			ClearZoneSelected:SetVisible(false)
			RequestAmmo:SetVisible(false)
	end
end
end)



function OrdersMenu()
if Regroup then Regroup:Remove() end
if SquadGoHere then SquadGoHere:Remove() end
if SquadHoldPosition then SquadHoldPosition:Remove() end
if SelectedGoHere then SelectedGoHere:Remove() end
if SelectedFollowMe then SelectedFollowMe:Remove() end
if SelectedHoldPosition then SelectedHoldPosition:Remove() end
if UnselectAll then UnselectAll:Remove() end
if SquadFollowMe then SquadFollowMe:Remove() end
if DisbandSquad then DisbandSquad:Remove() end
if FormSquadFromSelected then FormSquadFromSelected:Remove() end
if SquadRegroup then SquadRegroup:Remove() end
if SelectAllNonSelected then SelectAllNonSelected:Remove() end

if Squad2FollowMe then Squad2FollowMe:Remove() end
if Squad2Regroup then Squad2Regroup:Remove() end
if DisbandSquad2 then DisbandSquad2:Remove() end
if FormSquad2FromSelected then FormSquad2FromSelected:Remove() end
if Squad2GoHere then Squad2GoHere:Remove() end
if Squad2HoldPosition then Squad2HoldPosition:Remove() end
if MenuButton then MenuButton:Remove() end
if MenuButtonAir then MenuButtonAir:Remove() end
if MenuButtonMachines then MenuButtonMachines:Remove() end
if LaunMortar then LaunMortar:Remove() end
if DismissAirUnits then DismissAirUnits:Remove() end
if AddZoneSelected then AddZoneSelected:Remove() end
if ClearZoneSelected then ClearZoneSelected:Remove() end
if RequestAmmo then RequestAmmo:Remove() end

		RequestAmmo = vgui.Create( "DButton" )
		RequestAmmo:SetPos( ScrW() * 0.48, ScrH() * 0.20 )
		RequestAmmo:SetText( "Ammo Drop (20)" )
		RequestAmmo:SetSize( 90, 30 )
		RequestAmmo.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("RequestAmmo")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		Regroup = vgui.Create( "DButton" )
		Regroup:SetPos( ScrW() * 0.48, ScrH() * 0.52 )
		Regroup:SetText( "Regroup" )
		Regroup:SetSize( 90, 30 )
		Regroup.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("regroup")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		
		SquadGoHere = vgui.Create( "DButton" )
		SquadGoHere:SetPos( ScrW() * 0.42, ScrH() * 0.48 )
		SquadGoHere:SetText( "Alpha Here" )
		SquadGoHere:SetSize( 90, 30 )
		SquadGoHere.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("squadgohere")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		SquadFollowMe = vgui.Create( "DButton" )
		SquadFollowMe:SetPos( ScrW() * 0.42, ScrH() * 0.44 )
		SquadFollowMe:SetText( "Alpha Follow Me" )
		SquadFollowMe:SetSize( 90, 30 )
		SquadFollowMe.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("squadfollowme")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		

		
		SquadHoldPosition = vgui.Create( "DButton" )
		SquadHoldPosition:SetPos( ScrW() * 0.42, ScrH() * 0.40 )
		SquadHoldPosition:SetText( "Alpha Hold Pos." )
		SquadHoldPosition:SetSize( 90, 30 )
		SquadHoldPosition.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("squadholdposition")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		FormSquadFromSelected = vgui.Create( "DButton" )
		FormSquadFromSelected:SetPos( ScrW() * 0.42, ScrH() * 0.60 )
		FormSquadFromSelected:SetText( "Form Alpha" )
		FormSquadFromSelected:SetSize( 90, 30 )
		FormSquadFromSelected.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("formsquadfromselected")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		DisbandSquad = vgui.Create( "DButton" )
		DisbandSquad:SetPos( ScrW() * 0.42, ScrH() * 0.56 )
		DisbandSquad:SetText( "Disband Alpha" )
		DisbandSquad:SetSize( 90, 30 )
		DisbandSquad.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("disbandsquad")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		
		SquadRegroup = vgui.Create( "DButton" )
		SquadRegroup:SetPos( ScrW() * 0.42, ScrH() * 0.52 )
		SquadRegroup:SetText( "Regroup Alpha" )
		SquadRegroup:SetSize( 90, 30 )
		SquadRegroup.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("regroupsquad")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

	

---
		Squad2GoHere = vgui.Create( "DButton" )
		Squad2GoHere:SetPos( ScrW() * 0.54, ScrH() * 0.48 )
		Squad2GoHere:SetText( "Bravo Here" )
		Squad2GoHere:SetSize( 90, 30 )
		Squad2GoHere.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("Squad2gohere")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		Squad2FollowMe = vgui.Create( "DButton" )
		Squad2FollowMe:SetPos( ScrW() * 0.54, ScrH() * 0.44 )
		Squad2FollowMe:SetText( "Bravo Follow Me" )
		Squad2FollowMe:SetSize( 90, 30 )
		Squad2FollowMe.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("Squad2followme")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		
		Squad2HoldPosition = vgui.Create( "DButton" )
		Squad2HoldPosition:SetPos( ScrW() * 0.54, ScrH() * 0.40 )
		Squad2HoldPosition:SetText( "Bravo Hold Pos." )
		Squad2HoldPosition:SetSize( 90, 30 )
		Squad2HoldPosition.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("Squad2holdposition")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		FormSquad2FromSelected = vgui.Create( "DButton" )
		FormSquad2FromSelected:SetPos( ScrW() * 0.54, ScrH() * 0.60 )
		FormSquad2FromSelected:SetText( "Form Bravo" )
		FormSquad2FromSelected:SetSize( 90, 30 )
		FormSquad2FromSelected.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("formSquad2fromselected")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		DisbandSquad2 = vgui.Create( "DButton" )
		DisbandSquad2:SetPos( ScrW() * 0.54, ScrH() * 0.56 )
		DisbandSquad2:SetText( "Disband Bravo" )
		DisbandSquad2:SetSize( 90, 30 )
		DisbandSquad2.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("disbandSquad2")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		
		Squad2Regroup = vgui.Create( "DButton" )
		Squad2Regroup:SetPos( ScrW() * 0.54, ScrH() * 0.52 )
		Squad2Regroup:SetText( "Regroup Bravo" )
		Squad2Regroup:SetSize( 90, 30 )
		Squad2Regroup.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("regroupSquad2")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

---	
SelectedGoHere = vgui.Create( "DButton" )
		SelectedGoHere:SetPos( ScrW() * 0.48, ScrH() * 0.48 )
		SelectedGoHere:SetText( "Go Here" )
		SelectedGoHere:SetSize( 90, 30 )
		SelectedGoHere.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("selectedgohere")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

SelectedHoldPosition = vgui.Create( "DButton" )
		SelectedHoldPosition:SetPos( ScrW() * 0.48, ScrH() * 0.40 )
		SelectedHoldPosition:SetText( "Hold Position" )
		SelectedHoldPosition:SetSize( 90, 30 )
		SelectedHoldPosition.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("selectedholdposition")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		
SelectedFollowMe = vgui.Create( "DButton" )
		SelectedFollowMe:SetPos( ScrW() * 0.48, ScrH() * 0.44 )
		SelectedFollowMe:SetText( "Follow Me" )
		SelectedFollowMe:SetSize( 90, 30 )
		SelectedFollowMe.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("selectedfollowme")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end
		
UnselectAll = vgui.Create( "DButton" )
		UnselectAll:SetPos( ScrW() * 0.48, ScrH() * 0.56 )
		UnselectAll:SetText( "Unselect All" )
		UnselectAll:SetSize( 90, 30 )
		UnselectAll.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("unselectall")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		SelectAllNonSelected = vgui.Create( "DButton" )
		SelectAllNonSelected:SetPos( ScrW() * 0.48, ScrH() * 0.60 )
		SelectAllNonSelected:SetText( "Select loners" )
		SelectAllNonSelected:SetSize( 90, 30 )
		SelectAllNonSelected.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("selectallnonselected")
			--net.WriteEntity( LocalPlayer())
			net.SendToServer()
		end

		LaunMortar = vgui.Create( "DButton" )
		LaunMortar:SetPos( ScrW() * 0.48, ScrH() * 0.28 )
		LaunMortar:SetText( "Mortar (100)" )
		LaunMortar:SetSize( 90, 30 )
		LaunMortar.DoClick = function()
			SpawnOrder("Mortar")
		end

		DismissAirUnits = vgui.Create( "DButton" )
		DismissAirUnits:SetPos( ScrW() * 0.54, ScrH() * 0.28 )
		DismissAirUnits:SetText( "Dismiss Air Units" )
		DismissAirUnits:SetSize( 90, 30 )
		DismissAirUnits.DoClick = function()
			SpawnOrder("DismissAirUnits")
		end
		
		
MenuButton = vgui.Create("DButton")
MenuButton:SetText( "Reinforcements" )
MenuButton:SetPos(ScrW() * 0.48, ScrH() * 0.24)
MenuButton:SetSize( 90, 30 )
MenuButton.DoClick = function ( btn )
    local MenuButtonOptions = DermaMenu() -- Creates the menu
    MenuButtonOptions:AddOption("Soldier (10)",function() SpawnOrder("Soldier") end ) -- Add options to the menu
    MenuButtonOptions:AddOption("Shotgunner (10)",function() SpawnOrder("Shotgunner") end )
    MenuButtonOptions:AddOption("Elite (20)",function() SpawnOrder("Elite") end)
    MenuButtonOptions:AddOption("Guard (15)", function() SpawnOrder("Guard") end)
    MenuButtonOptions:AddOption("Metrocop (10)",function() SpawnOrder("Metrocop") end )
    MenuButtonOptions:AddOption("Sniper (30)",function() SpawnOrder("Sniper") end )
if IsMounted('ep2') then
    MenuButtonOptions:AddOption("Hunter (50)",function() SpawnOrder("Hunter") end )

end
    MenuButtonOptions:Open() -- Open the menu AFTER adding your options
	MenuButtonOptions:SetPos(MenuButton:GetPos())

end

MenuButtonAir = vgui.Create("DButton")
MenuButtonAir:SetText( "Air Units" )
MenuButtonAir:SetPos(ScrW() * 0.54, ScrH() * 0.24)
MenuButtonAir:SetSize( 90, 30 )
MenuButtonAir.DoClick = function ( btn )
    local MenuButtonAirOptions = DermaMenu() -- Creates the menu
    MenuButtonAirOptions:AddOption("Helicopter (200)",function() SpawnOrder("Helicopter") end ) -- Add options to the menu
    MenuButtonAirOptions:AddOption("Gunship (250)",function() SpawnOrder("Gunship") end )
    MenuButtonAirOptions:AddOption("Dropship (100)",function() SpawnOrder("Dropship") end )
    MenuButtonAirOptions:Open() -- Open the menu AFTER adding your options
	MenuButtonAirOptions:SetPos(MenuButtonAir:GetPos())
end

MenuButtonMachines = vgui.Create("DButton")
MenuButtonMachines:SetText( "Machines" )
MenuButtonMachines:SetPos(ScrW() * 0.42, ScrH() * 0.24)
MenuButtonMachines:SetSize( 90, 30 )
MenuButtonMachines.DoClick = function ( btn )
    local MenuButtonMachinesOptions = DermaMenu() -- Creates the menu
    MenuButtonMachinesOptions:AddOption("Turret (10)",function() SpawnOrder("Turret") end ) -- Add options to the menu
    MenuButtonMachinesOptions:AddOption("Ceiling Turret (30)",function() SpawnOrder("CeilingTurret") end )
    MenuButtonMachinesOptions:AddOption("Rollermine (10)",function() SpawnOrder("Rollermine") end )
    MenuButtonMachinesOptions:AddOption("Mine (2)",function() SpawnOrder("Mine") end )
    MenuButtonMachinesOptions:Open() -- Open the menu AFTER adding your options
	MenuButtonMachinesOptions:SetPos(MenuButtonMachines:GetPos())
end


		AddZoneSelected = vgui.Create( "DButton" )
		AddZoneSelected:SetPos( ScrW() * 0.48, ScrH() * 0.64 )
		AddZoneSelected:SetText( "Add Patrolzone" )
		AddZoneSelected:SetSize( 90, 30 )
		AddZoneSelected.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("addzoneselected")
			net.SendToServer()
		end


		ClearZoneSelected = vgui.Create( "DButton" )
		ClearZoneSelected:SetPos( ScrW() * 0.48, ScrH() * 0.68 )
		ClearZoneSelected:SetText( "Clear Patrolzones" )
		ClearZoneSelected:SetSize( 90, 30 )
		ClearZoneSelected.DoClick = function()
			--print( "Button was clicked!" )
			canshow=1
			net.Start("ClearZoneSelected")
			net.SendToServer()
		end

		
RequestAmmo:SetVisible(false)
ClearZoneSelected:SetVisible(false)
AddZoneSelected:SetVisible(false)
DismissAirUnits:SetVisible(false)
LaunMortar:SetVisible(false)
MenuButtonMachines:SetVisible(false)
MenuButtonAir:SetVisible(false)
MenuButton:SetVisible(false)
Squad2FollowMe:SetVisible(false)
Squad2Regroup:SetVisible(false)	
DisbandSquad2:SetVisible(false)
FormSquad2FromSelected:SetVisible(false)
Squad2GoHere:SetVisible(false)
Squad2HoldPosition:SetVisible(false)		

SquadFollowMe:SetVisible(false)
SquadRegroup:SetVisible(false)	
DisbandSquad:SetVisible(false)
FormSquadFromSelected:SetVisible(false)
SquadGoHere:SetVisible(false)
SquadHoldPosition:SetVisible(false)
Regroup:SetVisible(false)
SelectedGoHere:SetVisible(false)
SelectedFollowMe:SetVisible(false)
SelectedHoldPosition:SetVisible(false)
UnselectAll:SetVisible(false)
SelectAllNonSelected:SetVisible(false)		

end
timer.Simple(1,OrdersMenu)

function SpawnOrder(selection)
		net.Start("SpawnRequest")
		net.WriteString(selection)
		net.SendToServer()
end

function GM:HUDDrawTargetID()



local tr = util.GetPlayerTrace( LocalPlayer() )
local trace = util.TraceLine( tr )
if (!trace.Hit) then return end
if (!trace.HitNonWorld) then return end

local text = "ERROR"
local font = "TargetID"


	if (trace.Entity:IsPlayer()) then
	if trace.Entity:GetNWString("side") == "combine" then
		text = trace.Entity:GetName()
		else return false
	end
	elseif trace.Entity:GetNWString("name") then
		text = trace.Entity:GetNWString("name")
	else 
		text=""
	end
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local MouseX, MouseY = gui.MousePos()
	
	if ( MouseX == 0 && MouseY == 0 ) then
		MouseX = ScrW() / 2
		MouseY = ScrH() / 2
	end
	
	local x = MouseX
	local y = MouseY
	
	x = x - w / 2
	y = y + 30
	
	-- The fonts internal drop shadow looks lousy with AA on
	--draw.SimpleText( text, font, x+1, y+1, Color(0,0,0,120) )
	--draw.SimpleText( text, font, x+2, y+2, Color(0,0,0,50) )
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	y = y + h + 5
	if (trace.Entity:Health() > 0) then
		text = "Health: "..trace.Entity:Health().. ""
		font = "TargetIDSmall"
		else text=""
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local x = MouseX - w / 2
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	if (trace.Entity:GetNWString("owner") == ""..localownerid.."") and table.HasValue(CombineSoldiers, trace.Entity:GetClass()) then
	-- Squad
	y = y + h + 5
	if (trace.Entity:GetNWString("Squad") == "no") then
		text = "No Squad"
		font = "TargetIDSmall"
	elseif (trace.Entity:GetNWString("Squad") == "squad1") then
		text = "Squad Alpha"
	elseif (trace.Entity:GetNWString("Squad") == "squad2") then
		text = "Squad Bravo"
		else text = ""
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local x = MouseX - w / 2
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	
	-- Hold Pos
	y = y + h + 5
	if (trace.Entity:GetNWString("HoldPosition") == "NO_VECTOR") then
		text = "Not Holding Position"
		font = "TargetIDSmall"
	else
		text = "Holding Position"
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local x = MouseX - w / 2
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	
	
	
	-- Following
	y = y + h + 5
	if (trace.Entity:GetNWString("FollowMe") == "no") then
		text = ""
		font = "TargetIDSmall"
	else
		text = "Following you"
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local x = MouseX - w / 2
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	end
end

function Test()
print("D")
notification.AddProgress( "Hordes", "Horde Minimode" )
timer.Simple( 5, function()
end )
end

function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf ) 
     ply:EmitSound(table.Random(CombineBootSound), 35, 100) -- Play the footsteps hunter is using
     return true -- Don't allow default footsteps
 end

function CombineBootsRun()
timer.Simple(0.3, CombineBootsRun)
	if LocalPlayer() then
		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(),900)) do
				if v:GetClass() == "npc_combine_s" then
					if v:GetVelocity():Length() > 80 then 
						v:EmitSound(table.Random(CombineBootSound), 65, 100)
						--sound.Play( table.Random(CombineBootSound), v:GetPos(), 75, 100, 0.5 )
						--print("Run")
					end
				end
		end
	end
end


hook.Add( "PostDrawOpaqueRenderables", "random_box_beam", function()
		for k,v in pairs(ents.GetAll()) do
			if v:GetNWString("name") == "TheDocument" and input.IsKeyDown(KEY_X ) then
			print("ddd")
				local Vector1 = v:GetPos()
				local Vector2 =  LocalPlayer():GetPos()+Vector(0,0,60)
				render.SetMaterial( Material( "cable/redlaser" ) )
				render.DrawBeam( Vector1, Vector2, 0.2, 1, 1, Color( 0,255,255 ) ) 
			end
		end
	end )

	
	

function light()
if LocalPlayer():GetNWString("side") == "rebel" then
	timer.Simple( 0.2, light )
	if LocalPlayer() then
		if LocalPlayer():Alive() then
			lightcol = (render.GetLightColor(LocalPlayer():GetPos())*Vector(100,100,100)):Length()
			if LocalPlayer():Health() > 0 and LocalPlayer():GetActiveWeapon() != NULL then

				if LocalPlayer():Crouching() then lightcol=lightcol-1 end
				if LocalPlayer():FlashlightIsOn() then if lightcol < 20 then lightcol = lightcol+30 end end
			end
			if LocalPlayer():GetVelocity():Length() > 200 then lightcol=lightcol+2 end
			if lightcol <= 2 then
				if light_above_limit != 0 then
				darkencolor = Color(0,255,0)
					if LocalPlayer():GetVelocity():Length() < 240 then
						if LocalPlayer():Alive() then
							--light_above_limit=0
							net.Start("light_below_limit")
							net.SendToServer()
						end
					end
				end
			end	
			if lightcol > 2 then
				if  lightcol >= 2 and lightcol < 10 then
					darkencolor = Color(190,190,190,255)
				end
				if lightcol > 10 then
					darkencolor = Color(255,255,255,255)
				end
				if light_above_limit != 1 then
					if LocalPlayer():Alive() then
						--light_above_limit=1
						net.Start("light_above_limit")
						net.SendToServer()
					end
				end
			end
		end
	end
end
end



function FinishTyping()
	print( "User has closed the chatbox." )
	CanShowCommands= false
end
hook.Add( "FinishChat", "ClientFinishTyping", FinishTyping )

function isStartTyping( isTeamChat )
	CanShowCommands = true
end
hook.Add( "StartChat", "HasStartedTyping", isStartTyping )