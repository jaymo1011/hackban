-- Blocked models storage
local blockedModels = {}

-- Hook into the entityCreating event (only works on onesync!)
AddEventHandler("entityCreating", function(entity)
	-- Get the model of the entity being created
	local entityModel = GetEntityModel(entity)
	
	-- If the model is blocked then cancel the event, instantly deleting the entity
	if blockedModels[tonumber(entityModel)] then
		CancelEvent()
	end
end)

-- Handle config refreshing
AddEventHandler("hackban:refresh", function()
	local noError, newBlockedModelList = pcall(function()
		local blockedModelConfig = json.decode(GetConvar(Convars.BlockedModelArray, "[]"))
		local newBlockedModels = {}
		
		for _, modelStr in ipairs(blockedModelConfig) do
			newBlockedModels[tonumber(GetHashKey(modelStr))] = true
		end

		return newBlockedModels
	end)

	if noError then
		blockedModels = newBlockedModelList
	end
end)
