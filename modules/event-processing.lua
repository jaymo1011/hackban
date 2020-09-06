local checkedEvents = {}
local eventPatterns = {}

AddEventHandler("__hackban_internal:netEventTriggered", function(eventName, source, eventPayload)
	-- Get the safety of this event
	local eventSafety = checkedEvents[eventName]

	-- If we don't yet know the safety of this event, find that out before continuing
	if not eventSafety then
		for _, pattern in ipairs(eventPatterns) do
			if string.match(eventName, string.sub(pattern,2,-2)) then
				eventSafety = "unsafe"
				break
			end
		end

		eventSafety = eventSafety or "safe"	
		checkedEvents[eventName] = eventSafety
	end

	-- If this event is unsafe, kick the player who triggered it
	if eventSafety ~= "safe" then
		HandlePlayer(source)
	end
end)

AddEventHandler("hackban:refresh", function()
	-- TODO: Find a better way to handle the JSON decoding and erroring
	pcall(function()
		eventPatterns = json.decode(GetConvar(Convars.UnsafeEventsArray, "[]"))
	end)

	-- Clear the pre-filtered events as well :)
	for ev in pairs(checkedEvents) do
		checkedEvents[ev] = nil
	end
end)
