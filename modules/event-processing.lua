local checkedEvents = {}

AddEventHandler("__hackban_internal:netEventTriggered", function(eventName, source, eventPayload)
	-- Get the safety of this event
	local eventSafety = checkedEvents[eventName]
	--local data = msgpack.unpack(eventPayload)

	-- If we don't yet know the safety of this event, find that out before continuing
	if not eventSafety then
		for _, pattern in ipairs(BlockedEvents) do
			if string.match(eventName, string.sub(pattern,2,-2)) then
				eventSafety = "unsafe"
				break
			end
		end

		eventSafety = eventSafety or "safe"
		checkedEvents[eventName] = eventSafety
	end

	-- If this event is not safe, kick the player who triggered it
	if eventSafety ~= "safe" then
		HandlePlayer(source)
	end
end)

-- Clear the pre-filtered events on refresh because, yeah
AddEventHandler("hackban:refresh", function()
	for ev in pairs(checkedSafeEvents) do
		checkedSafeEvents[ev] = nil
	end
end)
