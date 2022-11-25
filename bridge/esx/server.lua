if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function RegisterCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

function Search(source, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(name)
    if item ~= nil then 
        return item.count
    else
        return 0
    end
end

function AddItem(source, name, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.addInventoryItem(name, amount)
end

function RemoveItem(source, name, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.removeInventoryItem(name, amount)
end

function CanCarryItem(source, name, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.canCarryItem(name, amount)
end

function RegisterUsableItem(...)
    ESX.RegisterUsableItem(...)
end