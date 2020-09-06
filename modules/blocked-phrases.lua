local blockedPhrases = {}

AddEventHandler("chatMessage", function(source, author, content)
	for _, pattern in ipairs(blockedPhrases) do
		-- If either the author or content contains a blocked phrase, don't let it propagate
		if string.find(string.lower(author), pattern) or string.find(string.lower(content), pattern) then
			CancelEvent()
			return
		end
	end
end)

-- Handle config refreshing
AddEventHandler("hackban:refresh", function()
	-- TODO: better error handling and information for stupid people
	local noError, newBlockedPhrases = pcall(function()
		return json.decode(GetConvar(Convars.BlockedPhraseArray, "[]"))
	end)

	if noError then
		blockedPhrases = newBlockedPhrases
	end
end)

