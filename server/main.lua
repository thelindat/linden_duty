RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer and job.name ~= lastJob.name then
		if Config.Jobs[lastJob.name] then Config.Jobs[lastJob.name][xPlayer.source] = nil end
		if Config.Jobs[job.name] then AddPlayer(xPlayer) end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew)
	TriggerClientEvent('linden_duty:updateTables', playerId, Config)
	if Config.Jobs[xPlayer.job.name] then AddPlayer(xPlayer) end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		if ESX == nil then return end
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if Config.Jobs[xPlayer.job.name] then AddPlayer(xPlayer) end
		end
		Wait(500)
		StartLoop()
	end
end)

AddPlayer = function(xPlayer)
	Config.Jobs[xPlayer.job.name][xPlayer.source] = xPlayer.name
end

AddEventHandler('esx:playerDropped', function(playerId, reason)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer and Config.Jobs[xPlayer.job.name] then
		Config.Jobs[xPlayer.job.name][playerId] = nil
	end
end)

StartLoop = function()
	CreateThread(function()
		for k, v in pairs(Config.Jobs) do
			Config.Count[k] = 0
		end
		while true do
			local sendData = false
			for job, table in pairs(Config.Jobs) do
				local count = 0
				for source, name in pairs(table) do
					count = count + 1
				end
				if Config.Count[job] ~= count then
					Config.Count[job] = count
					sendData = true
				end
			end
			if sendData then TriggerClientEvent('linden_duty:updateTables', -1, Config) end
			Wait(5000)
		end
	end)
end
