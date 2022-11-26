function GetExchangeItems(source, index)
    local data = Config.Exchange[index]
    local exchange = {}
    for k,v in pairs(data.Catalog) do 
        local count = Search(source, k)
        if (count > 0 and CanCarryItem(source, v.name, v.min)) then 
            exchange[#exchange + 1] = {
                remove = k,
                required = v.required,
                amount = count,
                name = v.name,
                min = v.min,
                max = v.max,
            }
        end
    end
    return exchange
end

function ExchangeItems(source, index)
    local data = Config.Exchange[index]
    local exchangeType = data.Type
    local exchangeItems = GetExchangeItems(source, index)
    if #exchangeItems < 1 then 
        return false
    end 
    if (exchangeType == "Process") then
        local item = exchangeItems[1]
        local amount = (item.min < item.max and math.random(item.min, item.max) or item.min)
        RemoveItem(source, item.remove, item.required)
        AddItem(source, item.name, amount)
        return true
    elseif (exchangeType == "Exchange") then
        for i=1, #exchangeItems do 
            local item = exchangeItems[i]
            local amount = (item.min < item.max and math.random(item.min, item.max) or item.min)
            RemoveItem(source, item.remove, item.amount)
            AddItem(source, item.name, item.amount * amount)
        end
        return true
    else
        return false
    end
end

RegisterCallback("pickle_farming:exchangeProcess", function(source, cb, index)
    local data = Config.Exchange[index]
    if (data) then 
        cb(ExchangeItems(source, index))
    else
        cb(false)
    end
end)
