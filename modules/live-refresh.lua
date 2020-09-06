local function refresh()
	print("Configuration loaded for hackban")
	TriggerEvent("hackban:refresh")
end
RegisterCommand("hackban_refresh", refresh, true)
AddEventHandler("onResourceListRefresh", refresh)

-- Always try to load the config when the resource starts
CreateThread(function()
	refresh()
end)
