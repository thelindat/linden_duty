RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	Wait(500)
	StartResource()
end)

RegisterNetEvent('esx:onPlayerLogout')	-- Trigger this event when a player logs out to character selection
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

CreateThread(function()	-- If the resource is started while the player is active, force it to load
	Wait(500)
	if ESX.IsPlayerLoaded() then StartResource() end
end)

OnPlayerData = function(key, val)
	if key == 'job' then	
	local job = Config.Jobs[val.name]
	if job then StartResource() end
	end
end
