ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingCerebro = {}
local PlayersHarvestingCorazon   = {}
local PlayersHarvestingMedulas  = {}
local PlayersHarvestingInstestinos = {}
local PlayersHarvestingHuesos   	= {}
local PlayersTransformingOrgan 	= {}
local PlayersSellingBody      	= {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function CountCops()
	local xPlayers = ESX.GetPlayers()
	CopsConnected = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end
	SetTimeout(5000, CountCops)
end
CountCops()
local function HarvestCerebro(source)
	SetTimeout(5000, function()
		if PlayersHarvestingCerebro[source] == true then 
			local xPlayer  = ESX.GetPlayerFromId(source)
			local cerebro = xPlayer.getInventoryItem('cerebro')
			if cerebro.limit ~= -1 and cerebro.count >= cerebro.limit then
				xPlayer.addInventoryItem('cerebro', 1)
				HarvestCerebro(source)
			else
				xPlayer.addInventoryItem('cerebro', 1)
				HarvestCerebro(source)
			end
		end
	end)
end

RegisterServerEvent('rnx_organ:startHarvestCerebro')
AddEventHandler('rnx_organ:startHarvestCerebro', function()
	local _source = source
	PlayersHarvestingCerebro[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
	HarvestCerebro(_source)
end)

RegisterServerEvent('rnx_organ:stopHarvestCerebro')
AddEventHandler('rnx_organ:stopHarvestCerebro', function()
	local _source = source
	PlayersHarvestingCerebro[_source] = false
end)
local function HarvestCorazon(source)
	SetTimeout(5000, function()
		if PlayersHarvestingCorazon[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local corazon = xPlayer.getInventoryItem('corazon')
			if corazon.limit ~= -1 and corazon.count >= corazon.limit then
				xPlayer.addInventoryItem('corazon', 1)
				HarvestCorazon(source)
			else
				xPlayer.addInventoryItem('corazon', 1)
				HarvestCorazon(source)
			end

		end
	end)
end
RegisterServerEvent('rnx_organ:startHarvestCorazon')
AddEventHandler('rnx_organ:startHarvestCorazon', function()
	local _source = source
	PlayersHarvestingCorazon[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
	HarvestCorazon(_source)
end)

RegisterServerEvent('rnx_organ:stopHarvestCorazon')
AddEventHandler('rnx_organ:stopHarvestCorazon', function()
	local _source = source
	PlayersHarvestingCorazon[_source] = false
end)
local function HarvestMedulas(source)
	SetTimeout(5000, function()
		if PlayersHarvestingMedulas[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local medulas = xPlayer.getInventoryItem('medulas')
			if medulas.limit ~= -1 and medulas.count >= medulas.limit then
				xPlayer.addInventoryItem('medulas', 1)
				HarvestMedulas(source)
			else
				xPlayer.addInventoryItem('medulas', 1)
				HarvestMedulas(source)
			end

		end
	end)
end
RegisterServerEvent('rnx_organ:startHarvestMedulas')
AddEventHandler('rnx_organ:startHarvestMedulas', function()
	local _source = source
	PlayersHarvestingMedulas[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
	HarvestMedulas(_source)
end)
RegisterServerEvent('rnx_organ:stopHarvestMedulas')
AddEventHandler('rnx_organ:stopHarvestMedulas', function()
	local _source = source
	PlayersHarvestingMedulas[_source] = false
end)
local function HarvestInstestinos(source)
	SetTimeout(5000, function()
		if PlayersHarvestingInstestinos[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local instestinos = xPlayer.getInventoryItem('instestinos')
			if instestinos.limit ~= -1 and instestinos.count >= instestinos.limit then
				xPlayer.addInventoryItem('instestinos', 1)
				HarvestInstestinos(source)
			else
				xPlayer.addInventoryItem('instestinos', 1)
				HarvestInstestinos(source)
			end
		end
	end)
end
RegisterServerEvent('rnx_organ:startHarvestInstestinos')
AddEventHandler('rnx_organ:startHarvestInstestinos', function()
	local _source = source
	PlayersHarvestingInstestinos[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
	HarvestInstestinos(_source)
end)
RegisterServerEvent('rnx_organ:stopHarvestInstestinos')
AddEventHandler('rnx_organ:stopHarvestInstestinos', function()
	local _source = source
	PlayersHarvestingInstestinos[_source] = false
end)
local function HarvestHuesos(source)
	SetTimeout(5000, function()
		if PlayersHarvestingHuesos[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local huesos = xPlayer.getInventoryItem('huesos')
			if huesos.limit ~= -1 and huesos.count >= huesos.limit then
				xPlayer.addInventoryItem('huesos', 1)
				HarvestHuesos(source)
			else
				xPlayer.addInventoryItem('huesos', 1)
				HarvestHuesos(source)
			end
		end
	end)
end
RegisterServerEvent('rnx_organ:startHarvestHuesos')
AddEventHandler('rnx_organ:startHarvestHuesos', function()
	local _source = source
	PlayersHarvestingHuesos[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))
	HarvestHuesos(_source)
end)
RegisterServerEvent('rnx_organ:stopHarvestHuesos')
AddEventHandler('rnx_organ:stopHarvestHuesos', function()
	local _source = source
	PlayersHarvestingHuesos[_source] = false
end)
local function TransformOrgan(source)
    SetTimeout(10000, function()
        if PlayersTransformingOrgan[source] == true then
            local xPlayer  = ESX.GetPlayerFromId(source)
            local huesosQuantity = xPlayer.getInventoryItem('huesos').count
            local poochQuantity = xPlayer.getInventoryItem('cuerpo').count
            local cerebroQuantity = xPlayer.getInventoryItem('cerebro').count
            local corazonQuantity = xPlayer.getInventoryItem('corazon').count
            local medulasQuantity = xPlayer.getInventoryItem('medulas').count
            local instestinosQuantity = xPlayer.getInventoryItem('instestinos').count
            if poochQuantity > 35 then
                TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
            elseif huesosQuantity >= 10 and cerebroQuantity >= 1 and corazonQuantity >= 1 and medulasQuantity >= 10 and instestinosQuantity >= 10 then
                xPlayer.removeInventoryItem('huesos', 10)
                xPlayer.removeInventoryItem('cerebro', 1)
                xPlayer.removeInventoryItem('corazon', 1)
                xPlayer.removeInventoryItem('medulas', 10)
                xPlayer.removeInventoryItem('instestinos', 10)
                xPlayer.addInventoryItem('cuerpo', 1)
                TransformOrgan(source)
            else
                TriggerClientEvent('esx:showNotification', source, _U('not_enough_organ'))
            end
        end
    end)
end
RegisterServerEvent('rnx_organ:startTransformOrgan')
AddEventHandler('rnx_organ:startTransformOrgan', function()
	local _source = source
	PlayersTransformingOrgan[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))
	TransformOrgan(_source)
end)
RegisterServerEvent('rnx_organ:stopTransformOrgan')
AddEventHandler('rnx_organ:stopTransformOrgan', function()
	local _source = source
	PlayersTransformingOrgan[_source] = false
end)
local function SellBody(source)
	if CopsConnected < Config.RequiredCopsBody then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police') .. CopsConnected .. '/' .. Config.RequiredCopsBody)
		return
	end
	SetTimeout(7500, function()
		if PlayersSellingBody[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local poochQuantity = xPlayer.getInventoryItem('cuerpo').count
			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('cuerpo', 1)
				if CopsConnected == 0 then
                    xPlayer.addAccountMoney('black_money', 5000)
                    TriggerClientEvent('esx:showNotification', source, _U('sold_one_body'))
                elseif CopsConnected == 1 then
                    xPlayer.addAccountMoney('black_money', 10000)
                    TriggerClientEvent('esx:showNotification', source, _U('sold_one_body'))
                elseif CopsConnected == 2 then
                    xPlayer.addAccountMoney('black_money', 15000)
                    TriggerClientEvent('esx:showNotification', source, _U('sold_one_body'))
                elseif CopsConnected == 3 then
                    xPlayer.addAccountMoney('black_money', 20000)
                    TriggerClientEvent('esx:showNotification', source, _U('sold_one_body'))
                elseif CopsConnected == 4 then
                    xPlayer.addAccountMoney('black_money', 25000)
                    TriggerClientEvent('esx:showNotification', source, _U('sold_one_body'))
                elseif CopsConnected >= 5 then
                    xPlayer.addAccountMoney('black_money', 30000)  
                    TriggerClientEvent('esx:showNotification', source, _U('sold_one_body'))
                end				
				SellBody(source)
			end
		end
	end)
end
RegisterServerEvent('rnx_organ:startSellBody')
AddEventHandler('rnx_organ:startSellBody', function()
	local _source = source
	PlayersSellingBody[_source] = true
	TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
	SellBody(_source)
end)
RegisterServerEvent('rnx_organ:stopSellBody')
AddEventHandler('rnx_organ:stopSellBody', function()

	local _source = source

	PlayersSellingBody[_source] = false

end)
RegisterServerEvent('rnx_organ:GetUserInventory')
AddEventHandler('rnx_organ:GetUserInventory', function(currentZone)
	local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('rnx_organ:ReturnInventory', 
    	_source, 
    	xPlayer.getInventoryItem('cerebro').count, 
		xPlayer.getInventoryItem('corazon').count,  
		xPlayer.getInventoryItem('medulas').count,  
		xPlayer.getInventoryItem('instestinos').count,
		xPlayer.getInventoryItem('huesos').count, 
		xPlayer.getInventoryItem('cuerpo').count,
		xPlayer.job.name, 
		currentZone
    )
end)