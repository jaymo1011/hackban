local checkedSafeEvents = {}

AddEventHandler("__hackban_internal:netEventTriggered", function(eventName, source, eventPayload)
	--local data = msgpack.unpack(eventPayload)

	-- for perf reasons, we only match on events we haven't seen before
	if not checkedSafeEvents[eventName] then
		for pattern in string.gmatch(Config.EventFilterString, "%b{}") do
			if string.match(eventName, string.sub(pattern,2,-2)) then
				HandlePlayer(source)
				return
			end
		end

		checkedSafeEvents[eventName] = true
	end
end)

AddEventHandler("hackban:refresh", function()
	-- Clear the pre-filtered events because, yeah
	for ev in pairs(checkedSafeEvents) do
		checkedSafeEvents[ev] = nil
	end
end)
