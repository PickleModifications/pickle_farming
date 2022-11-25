local Interact = false
local LocalPlants = {}

function GetPlayerOffset(seed)
    local cfg = Config.Seeds[seed]
    local ped = PlayerPedId()
    local pcoords = GetEntityCoords(ped)
    local offset = cfg.Prop.Offsets.Start
    local coords = GetOffsetFromEntityInWorldCoords(ped, offset.x, offset.y, offset.z - 1.0)
    return vec4(coords.x, coords.y, coords.z, GetEntityHeading(ped) - offset.w)
end

function IsPlantable(seed)
    local cfg = Config.Seeds[seed]
    local ped = PlayerPedId()
    local pcoords = GetEntityCoords(ped)
    local coords, heading = v3(GetPlayerOffset(seed))
    if cfg.Materials and #cfg.Materials > 0 then 
        local ray = StartShapeTestRay(pcoords, coords, 17, ped, 7)
        local _, hit, endCoords, surfaceNormal, materialHash, entity = GetShapeTestResultIncludingMaterial(ray)
        dprint("ATTEMPT PLANT: ", seed, "Material: ", materialHash)
        if hit then 
            local found = false
            for i=1, #cfg.Materials do 
                local material = cfg.Materials[i]
                if type(material) == "number" and materialHash == material then
                    found = true
                    break
                elseif (type(material) == "string" and Materials[material] ~= nil and Materials[material] == materialHash) then
                    found = true
                    break
                end
            end
            if found then 
                return true
            end
        end 
    end
    if cfg.Zones and #cfg.Zones > 0 then 
        local found = false
        for i=1, #cfg.Zones do 
            local zcoord, max_dist = v3(cfg.Zones[i])
            local dist = #(coords - zcoord)
            if dist < max_dist then 
                found = true
                break
            end
        end
        if found then 
            return true
        end
    end
    return false
end

function CreatePlant(seed)
    if Interact then return end
    Interact = true
    local cfg = Config.Seeds[seed]
    local coords, heading = v3(GetPlayerOffset(seed))
    if (IsPlantable(seed)) then 
        ServerCallback("pickle_farming:createPlant", function(result) 
            if result then 
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, true)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, 1)
                Wait(1000 * Config.Plant.PlantTime)
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                Interact = false
                ShowNotification("Planted seed.") 
            end
            Interact = false
        end, seed, coords)
    else
        dprint("FAILED TO PLANT: ", seed)
        ShowNotification("You can't plant this seed here.") 
        Interact = false
    end
end

function CreateLocalPlant(key)
    LocalPlants[key] = {}
    local data = GlobalState.Plants[key]
    local cfg = Config.Seeds[data.seed]
    local obj = CreateProp(cfg.Prop.Model, data.coords.x, data.coords.y, data.coords.z, false, true, false)
    FreezeEntityPosition(obj, true)
    LocalPlants[key].object = obj
    CreateThread(function()
        local lastValue = nil

        local startCoords = GetEntityCoords(LocalPlants[key].object)
        local waterPercent = data.water / cfg.WaterNeeded
        local offset = v3(data.coords) + lerp(vector3(0.0, 0.0, 0.0), v3(cfg.Prop.Offsets.End), waterPercent)
        SetEntityCoords(obj, offset.x, offset.y, offset.z, 0.0, 0.0, 0.0, false)
        
        while LocalPlants[key] and GlobalState.Plants[key] do 
            local data = GlobalState.Plants[key]
            local wait = 1000
            if lastValue ~= data.water then 
                Interact = true
                lastValue = data.water
                local startCoords = GetEntityCoords(LocalPlants[key].object)
                local waterPercent = data.water / cfg.WaterNeeded
                local offset = v3(data.coords) + lerp(vector3(0.0, 0.0, 0.0), v3(cfg.Prop.Offsets.End), waterPercent)
                local percent = 0.0
                while percent < 1.0 do
                    percent = percent + Config.Plant.GrowingPerTick
                    local newCoords = lerp(startCoords, offset, percent)
                    SetEntityCoords(obj, newCoords.x, newCoords.y, newCoords.z, 0.0, 0.0, 0.0, false)
                    Wait(Config.Plant.GrowingTick)
                end
                Interact = false
            end
            Wait(wait)
        end
    end)
end

function DestroyLocalPlant(key)
    if LocalPlants[key] then 
        DeleteEntity(LocalPlants[key].object)
        LocalPlants[key] = nil
    end
end

function GetLocalPlant(key)
    return LocalPlants[key]
end

function GetPlantCoords(key)
    local data = GlobalState.Plants[key]
    local cfg = Config.Seeds[data.seed]
    local coords = vector3(data.coords.x, data.coords.y, GetEntityCoords(PlayerPedId()).z)
    return coords
end

function InteractPlant(key)
    if Interact then return end
    Interact = true
    local data = GlobalState.Plants[key]
    local cfg = Config.Seeds[data.seed]
    local percent = math.floor((data.water / cfg.WaterNeeded) * 100)
    if percent >= 100 then 
        ServerCallback("pickle_farming:harvestPlant", function(result)
            if (result) then 
                local ped = PlayerPedId()
                FreezeEntityPosition(ped, true)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, 1)
                Wait(1000 * Config.Plant.HarvestTime)
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                Interact = false
            else
                Interact = false
            end
        end, key) 
    else
        ServerCallback("pickle_farming:waterPlant", function(result)
            if (result) then 
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local can = CreateObject(`prop_wateringcan`, coords.x, coords.y, coords.z, true, true, true)
                local boneID = GetPedBoneIndex(ped, 0x8CBD)
                local off = vector3(0.15, 0.0, 0.4)
                local rot = vector3(0.0, -180.0, -140.0)
                FreezeEntityPosition(ped, true)
                AttachEntityToEntity(can, ped, boneID, off.x, off.y, off.z, rot.x, rot.y, rot.z, false, false, false, true, 1, true)
                PlayAnim(PlayerPedId(), "missfbi3_waterboard", "waterboard_loop_player", -8.0, 8.0, -1, 49, 1.0)
                local ecoords = GetOffsetFromEntityInWorldCoords(can, 0.0, 0.0, 0.0)
                PlayEffect("core", "ent_sht_water", can, vec3(0.34, 0.0, 0.2), vec3(0.0, 0.0, 0.0), 1000 * Config.Plant.WaterTime, function()
                    ClearPedTasks(PlayerPedId())
                    DeleteEntity(can)
                    FreezeEntityPosition(ped, false)
                    Wait(1000 * Config.Plant.WaterPostDelay)
                    Interact = false
                end)
            else
                Interact = false
            end
        end, key) 
    end
end

function ShowPlantInteract(key)
    local data = GlobalState.Plants[key]
    local cfg = Config.Seeds[data.seed]
    local percent = math.floor((data.water / cfg.WaterNeeded) * 100)
    if percent < 100 then 
        ShowHelpNotification("Press ~INPUT_CONTEXT~ to water the plant (".. percent .."%).")
    else
        ShowHelpNotification("Press ~INPUT_CONTEXT~ to harvest the plant.")
    end
end

CreateThread(function()
    while true do 
        local wait = 1000
        local Plants = GlobalState.Plants
        local pcoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Plants) do 
            local coords = GetPlantCoords(k)
            local dist = #(coords - pcoords)
            local plant = GetLocalPlant(k)
            if (dist < Config.Plant.RenderDistance) then 
                wait = 0
                if (not plant) then 
                    CreateLocalPlant(k)
                end
                if (not Interact and dist < 1.5 and not ShowPlantInteract(k) and IsControlJustPressed(1, 51)) then 
                    InteractPlant(k)
                end
            elseif (plant) then 
                DestroyLocalPlant(k)
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent("pickle_farming:removePlant", function(key)
    DestroyLocalPlant(key)
end)

RegisterNetEvent("pickle_farming:plantSeed", function(seed)
    CreatePlant(seed)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k,v in pairs(LocalPlants) do 
        DestroyLocalPlant(k)
    end
end)