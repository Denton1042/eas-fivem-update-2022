local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function IsJobAllowed(jobname)
	local allowed = false

	for i=1, #Config.EAS.AllowedJobs do
		if jobname == Config.EAS.AllowedJobs[i] then
			allowed = true
		end
	end

	return allowed
end

RegisterNetEvent("alert:sv", function (msg, msg2)
	local xPlayer = ESX.GetPlayerFromId(source)
	if IsJobAllowed(xPlayer.job.name) then
    	TriggerClientEvent("SendAlert", -1, msg, msg2)
	else
		print(('%s [%s] tried to explot alert:sv'):format(xPlayer.getName(), xPlayer.identifier))
	end
end)

RegisterCommand("alert", function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	if IsJobAllowed(xPlayer.job.name) then
		TriggerClientEvent('alert:Send', source, xPlayer.job.name, Config.EAS.Departments)
	else
		TriggerClientEvent('esx:showNotification', source, "~r~You are not allowed to use this command!")
	end
end, false)
