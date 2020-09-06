// Tell the resource manager that we handle all events
RegisterResourceAsEventHandler("*")

const passbackEvent = "__hackban_internal:netEventTriggered";

// Override the event function
Citizen.setEventFunction(async function(name, payloadSerialized, source) {
	// Don't trigger on ourselves (if some malicious user was to send this as a net event)
	if (name == passbackEvent) {
		return;
	}

	// Don't trigger on non-net events
	if (!source.startsWith('net')) {
		return;
	}

	// Trigger an event for every net event triggered
	// This kinda is a bit screwy but it allows us to see every net event that gets triggered at a single endpoint
	TriggerEvent(passbackEvent, name, parseInt(source.substr(4)), payloadSerialized);
});
