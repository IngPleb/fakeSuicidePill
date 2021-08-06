ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('fakeSuicidePill', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('fakeSuicidePill', 1)
    TriggerClientEvent('suicidepills:fakepillused', source)

    if Config.ShowUseFakePillNotification then
        TriggerClientEvent('esx:showNotification', source, _U('fakeSuicidePill_used'))
    end

    if not Config.Mode == "control" and not Config.Mode == "duration"then
        TriggerClientEvent('suicidepills:stoppill', source)
        error("Invalid oblivion pill mode! Look in config file")
    end

end)

ESX.RegisterUsableItem('suicidePill', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('suicidePill', 1)
	TriggerClientEvent('suicidepills:deathpillused', source)
	
	if Config.ShowUseRealPillNotification then
		TriggerClientEvent('esx:showNotification', source, _U('realSuicidePill_used'))
	end
end)
