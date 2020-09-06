function HandlePlayer(source)
	source = tonumber(source) or false
	if not source then return end

	DropPlayer(source, GetConvar(Convars.KickMessage, "hackban™ isn't even configured correctly, how tragic"))
end

TriggerEvent("hackban:refresh")
