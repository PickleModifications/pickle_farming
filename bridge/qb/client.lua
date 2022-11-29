if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports["qb-core"]:GetCoreObject()

function ShowNotification(text)
	QBCore.Functions.Notify(text)
end

function ShowHelpNotification(text)
    AddTextEntry('qbHelpNotification', text)
    BeginTextCommandDisplayHelp('qbHelpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

function ServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb,  ...)
end

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text)
    ShowNotification(text)
end)
