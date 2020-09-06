local function refresh()
	TriggerEvent("hackban:refresh")
end
RegisterCommand("hackban_refresh", refresh, true)
AddEventHandler("onResourceListRefresh", refresh)
