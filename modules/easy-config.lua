local configMap = {
	EventFilterString = {
		convar = "hackban_eventFilter",
		default = "{hackban:testTrigger}{hackban:testTrigger%d*}",
	},

	KickReason = {
		convar = "hackban_kickReason",
		default = "big sad :("
	},
	
	ModelBlacklistString  = {
		convar = "hackban_blockedModels",
		default = "nero, nero2"
	},
}

Config = {}

local function refreshConfig()
	for configKey, configProperties in pairs(configMap) do
		local convar = configProperties.convar
		local configValue = GetConvar(convar, configProperties.default or "__nil")

		-- Hack: falsy values as default for GetConvar = broken!
		if configValue == "__nil" then
			configValue = false
		else
			-- Attempt to parse defaults of the number type as numbers
			if type(configProperties.default) == "number" then 
				configValue = tonumber(configValue) or configValue
			end
		end

		Config[configKey] = configValue
	end
end
refreshConfig()
AddEventHandler("hackban:refresh", refreshConfig)
