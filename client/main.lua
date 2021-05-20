StartResource = function()
	if Config.Jobs[ESX.PlayerData.job.name] then
		ESX.PlayerLoaded = true
		StartLoop()
	end
end

StartLoop = function()
	CreateThread(function()
		print('You are on duty')
		while ESX.PlayerLoaded do
			if not Config.Jobs[ESX.PlayerData.job.name] then break end
			--print(ESX.PlayerData.job.name)
			Wait(1000)
		end
		print('You are off duty')
		-- Loop ends and the resource is now doing nothing on the client
	end)
end

RegisterNetEvent('linden_duty:updateTables')
AddEventHandler('linden_duty:updateTables', function(data)
	Config = data
	for k, v in pairs(Config.Count) do
		print(k..' '..v)
	end
end)
