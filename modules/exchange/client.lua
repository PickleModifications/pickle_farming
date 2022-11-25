local Interact = false
local LocalNPCs = {}

function GetLocalNPC(index)
    return LocalNPCs[index]
end

function CreateLocalNPC(index)
    if (LocalNPCs[index]) then 
        DestroyLocalNPC(index)
    end
    LocalNPCs[index] = {}
    local cfg = Config.Exchange[index]
    local coords, heading = v3(cfg.Location)
    local npc = CreateNPC(cfg.NPCModel, coords.x, coords.y, coords.z, heading, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityHeading(npc, heading)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    LocalNPCs[index].npc = npc
end

function DestroyLocalNPC(index)
    if (LocalNPCs[index]) then
        DeleteEntity(LocalNPCs[index].npc) 
        LocalNPCs[index] = nil
    end
end

function ExchangeRequest(index)
    ServerCallback("pickle_farming:exchangeProcess", function(result)
        if result then 
            if (Config.Exchange[index].Type == "Process") then 
                ShowNotification("Successfuly processed item.")
            elseif (Config.Exchange[index].Type == "Exchange") then 
                ShowNotification("Successfuly exchanged item(s).")
            end
        else
            if (Config.Exchange[index].Type == "Process") then 
                ShowNotification("You don't have any items to process.")
            elseif (Config.Exchange[index].Type == "Exchange") then 
                ShowNotification("You don't have any items to exchange.")
            end
        end
    end, index)
end

function InteractExchange(index)
    if Interact then return end
    Interact = true
    local data = Config.Exchange[index]
    if (data.Type == "Process") then 
        local ped = PlayerPedId()
        FreezeEntityPosition(ped, true)
        PlayAnim(ped, "mini@repair", "fixing_a_ped", -8.0, 8.0, -1, 49, 1.0)
        if Config.ExchangeSettings.EnableSkillCheck then
            local success = lib.skillCheck({'easy', 'medium', 'medium'})
            if success then 
                ExchangeRequest(index)
            else
                ShowNotification("Failed to process item.")
            end
        else
            Wait(1000 * Config.ExchangeSettings.ProcessTime)
            ExchangeRequest(index)
        end
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        Interact = false
    elseif (data.Type == "Exchange") then 
        ExchangeRequest(index)
        Interact = false 
    else
        dprint("Invalid type: ", data.Type)    
        Interact = false
    end
end

function ShowExchangeInteract(index)
    if (Config.Exchange[index].Type == "Process") then 
        ShowHelpNotification("Press ~INPUT_CONTEXT~ to process your plants.")
    elseif (Config.Exchange[index].Type == "Exchange") then 
        ShowHelpNotification("Press ~INPUT_CONTEXT~ to exchange your items.")
    end
end

CreateThread(function()
    while true do 
        local wait = 1000
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        for i=1, #Config.Exchange do 
            local data = Config.Exchange[i]
            local coords = v3(data.Location)
            local dist = #(pcoords - coords)
            local npc = GetLocalNPC(i)
            if dist < Config.ExchangeSettings.RenderDistance then 
                wait = 0
                if (data.NPCModel) then 
                    if not npc then 
                        CreateLocalNPC(i)
                    end 
                end
                if (dist < 1.5 and not ShowExchangeInteract(i) and IsControlJustPressed(1, 51)) then 
                    InteractExchange(i)
                end
            elseif data.NPCModel and npc then
                DestroyLocalNPC(i)
            end
        end
        Wait(wait)
    end
end)

CreateThread(function()
    Wait(1000)
    for i=1, #Config.Exchange do 
        local v = Config.Exchange[i]
        if (v.Blip) then 
            local data = v.Blip
            data.Location = v3(v.Location)
            CreateBlip(data)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k,v in pairs(LocalNPCs) do 
        DestroyLocalNPC(k)
    end
end)