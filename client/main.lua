local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local PID           			= 0
local GUI           			= {}
local huesosQTE                     = 0
ESX 			    			= nil
GUI.Time            			= 0
local cuerpoQTE            = 0
local cerebroQTE       			= 0
local corazonQTE					= 0
local medulasQTE					= 0
local instestinosQTE				= 0
local myJob 					= nil
local PlayerData 				= {}
local GUI 						= {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
AddEventHandler('rnx_organ:hasEnteredMarker', function(zone)
        ESX.UI.Menu.CloseAll()
        if zone == 'CerebroFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'cerebro_harvest'
                CurrentActionMsg  = _U('press_collect_cerebro')
                CurrentActionData = {}
            end
        end
        if zone == 'CorazonFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'corazon_harvest'
                CurrentActionMsg  = _U('press_collect_corazon')
                CurrentActionData = {}
            end
        end
        if zone == 'MedulasFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'medulas_harvest'
                CurrentActionMsg  = _U('press_collect_medulas')
                CurrentActionData = {}
            end
        end
        if zone == 'InstestinosFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'instestinos_harvest'
                CurrentActionMsg  = _U('press_collect_instestinos')
                CurrentActionData = {}
            end
        end
        if zone == 'HuesosFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'huesos_harvest'
                CurrentActionMsg  = _U('press_collect_huesos')
                CurrentActionData = {}
            end
        end
		if zone == 'CoserCuerpos' then
            if myJob ~= "police" then
                    CurrentAction     = 'organ_treatment'
                    CurrentActionMsg  = _U('press_process_organ')
                    CurrentActionData = {}
            end
        end
        if zone == 'VentaCuerpos' then
            if myJob ~= "police" then
                if cuerpoQTE >= 1 then
                    CurrentAction     = 'body_resell'
                    CurrentActionMsg  = _U('press_sell_body')
                    CurrentActionData = {}
                end
            end
        end
    end)
AddEventHandler('rnx_organ:hasExitedMarker', function(zone)
        CurrentAction = nil
        ESX.UI.Menu.CloseAll()
        TriggerServerEvent('rnx_organ:stopHarvestCerebro')
        TriggerServerEvent('rnx_organ:stopHarvestCorazon')
        TriggerServerEvent('rnx_organ:stopHarvestMedulas')
        TriggerServerEvent('rnx_organ:stopHarvestInstestinos')
        TriggerServerEvent('rnx_organ:stopHarvestHuesos')
        TriggerServerEvent('rnx_organ:stopTransformOrgan')
        TriggerServerEvent('rnx_organ:stopSellBody')
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
                DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end
end)
RegisterNetEvent('rnx_organ:ReturnInventory')
AddEventHandler('rnx_organ:ReturnInventory', function(cerebroNbr, corazonNbr, medulasNbr, instestinosNbr, huesosNbr, organpNbr, jobName, currentZone)
	cerebroQTE       = cerebroNbr
	corazonQTE 	  = corazonNbr
	medulasQTE 	  = medulasNbr
	instestinosQTE       = instestinosbr
	huesosQTE       = huesosNbr
	cuerpoQTE = organpNbr
	myJob         = jobName
	TriggerEvent('rnx_organ:hasEnteredMarker', currentZone)
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords      = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker  = false
        local currentZone = nil
        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 1) then
                isInMarker  = true
                currentZone = k
            end
        end
        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            lastZone                = currentZone
            TriggerServerEvent('rnx_organ:GetUserInventory', currentZone)
        end
        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('rnx_organ:hasExitedMarker', lastZone)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, 38) then
                if CurrentAction == 'cerebro_harvest' then
                    TriggerServerEvent('rnx_organ:startHarvestCerebro')
                end
                if CurrentAction == 'corazon_harvest' then
                    TriggerServerEvent('rnx_organ:startHarvestCorazon')
                end
                if CurrentAction == 'medulas_harvest' then
                    TriggerServerEvent('rnx_organ:startHarvestMedulas')
                end
                if CurrentAction == 'instestinos_harvest' then
                    TriggerServerEvent('rnx_organ:startHarvestInstestinos')
                end
                if CurrentAction == 'huesos_harvest' then
                    TriggerServerEvent('rnx_organ:startHarvestHuesos')
                end
                if CurrentAction == 'organ_treatment' then
                    TriggerServerEvent('rnx_organ:startTransformOrgan')
                end
                if CurrentAction == 'body_resell' then
                    TriggerServerEvent('rnx_organ:startSellBody')
                end
                CurrentAction = nil
            end
        end
    end
end)