-- Similar to events, we don't want to process the entire filter string for the same model all the time
local checkedModels = {}

-- Hook into the entityCreating event (only works on onesync!)
AddEventHandler("entityCreating", function(entity)
	-- Get the model of the entity being created and the safety of that model
	local entityModel = GetEntityModel(entity)
	local modelSafety = checkedModels[entityModel]

	-- Check for model safety if we don't yet know the safety of this specific model
	if modelSafety == nil then
		-- For each model in the model blacklist string...
		for model in string.gmatch(Config.ModelBlacklistString, "([^,%s]+),?%s*") do
			-- Check the hash of this blacklisted model string against this entity's model
			if GetHashKey(model) == entityModel then
				-- If they match, this model is blacklisted and not safe to spawn
				modelSafety = "unsafe"
				break
			end
		end

		modelSafety = modelSafety or "safe"
		checkedModels[entityModel] = modelSafety
	end

	-- If the model is unsafe then cancel the event, instantly deleting the entity
	if modelSafety == "unsafe" then
		CancelEvent()
	end
end)

-- Clear out the checked models on refresh in case config changed
AddEventHandler("hackban:refresh", function()
	for model in pairs(checkedModels) do
		checkedModels[model] = nil
	end
end)
