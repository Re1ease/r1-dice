local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("roll", "Roll a dice", {}, false, function(source, args)
	local src = source
	local d1, d2, d3 = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
	if args[4] then return end
	if d1 and d1 > 10000 or d2 and d2 > 10000 or d3 and d3 > 10000 then return end
	TriggerClientEvent("r1-dice:client:roll", src, d1, d2, d3)
end, 'user')
