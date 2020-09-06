function HandlePlayer(source)
	source = tonumber(source) or false
	if not source then return end

	DropPlayer(source, Config.KickReason)
end
