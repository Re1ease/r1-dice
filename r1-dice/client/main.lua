local showDice = false
local text, c1, c2, c3 = "", 0, 0, 0

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function Reset() showDice = false text, c1, c2, c3 = "", 0, 0, 0 end

local function PlayAnim()
	local ped = PlayerPedId()
	CreateThread(function()
		RequestAnimDict("anim@mp_player_intcelebrationmale@wank")
		while not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@wank") do
			Wait(5)
		end
		TaskPlayAnim(ped, "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, false, false, false)
	end)
	Wait(1000)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, "dice", 0.2)
	Wait(500)
	StopAnimTask(ped, "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, false, false, false)
end

RegisterNetEvent("r1-dice:client:roll")
AddEventHandler("r1-dice:client:roll", function(d1,d2,d3)
	if not showDice then
		if not d1 then text = math.random(1, 10).."/10" end
		if d1 then c1 = tonumber(d1) text = math.random(1, c1).."/"..c1 end
		if d2 then c2 = tonumber(d2) text = math.random(1, c2).."/"..c1..", "..math.random(1, c2).."/"..c2 end
		if d3 then c3 = tonumber(d3) text = math.random(1, c2).."/"..c1..", "..math.random(1, c2).."/"..c2..", "..math.random(1, c3).."/"..c3 end

		PlayAnim()
		showDice = true
		SetTimeout(5500, function() Reset() end)

		while showDice do
			Wait(5)
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z, text)
		end
	end
end)