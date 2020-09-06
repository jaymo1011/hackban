local blockedExplosions = {}

-- Very simply cancel blocked explosions
AddEventHandler("explosionEvent", function(_, explosionData)
	if blockedExplosions[tostring(explosionData.explosionType)] then
		CancelEvent()
	end
end)

-- Handle config refreshing
AddEventHandler("hackban:refresh", function()
	pcall(function()
		for _, explosionIndex in ipairs(json.decode(GetConvar(Convars.BlockedExplosionArray, "[]"))) do
			blockedExplosions[tostring(explosionIndex)] = true
		end
	end)
end)
