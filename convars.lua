Convars = {
	KickMessage = "hackban_kickMessage",
	
	UnsafeEventsArray = "hackban_unsafeEvents",
	BlockedModelArray = "hackban_blockedModels",
	BlockedPhraseArray = "hackban_blockedPhrases",
	BlockedExplosionArray = "hackban_blockedExplosions",
}

local getConvar = GetConvar

-- Hack: falsy values in GetConvar default will give a native error, patch around that for ease of use :D
function GetConvar(convar, defaultValue)
	local convarValue = getConvar(convar, "__nil__")

	if convarValue == "__nil__" then
		return defaultValue
	end
	
	return convarValue
end

function GetConvarBool(convar, defaultValue)
	local convarValue = getConvar(convar, "__nil__")
	
	if convarValue == "__nil__" then
		if defaultValue ~= nil then
			return defaultValue
		end

		return false
	end

	if convarValue == "false" or convarValue == "0" then
		return false
	end

	return true
end
