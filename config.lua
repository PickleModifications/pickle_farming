Config = {}

Config.Debug = true

Config.Plant = {
    WaterPerUse = 10, -- How many water points it should add to the plant.

    WaterTime = 5, -- How long to water the plant.
    HarvestTime = 5, -- How long to harvest the plant.
    PlantTime = 5, -- How long to plant the seed.

    WaterPostDelay = 0, -- Cooldown for Watering.
    MaxPlayerPlants = 5, -- Maximum plants a player can grow at a time.
    RenderDistance = 30.0, -- Distance to render spawned plants.

    -- Don't change the below unless needed.

    GrowingTick = 10, -- How often to tick the growing loop (only when growing).
    GrowingPerTick = 0.01, -- How much to add to the percent in the growing lerp.
}

-- Weed
-- Cocaine
-- Heroin

Config.Seeds = {
    ['corn_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "corn_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['tomato_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "tomato_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['wheat_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "wheat_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['broccoli_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "broccoli_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['carrot_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "carrot_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['potato_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "potato_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['pickle_seed'] = {
        Prop = {
            Model = `prop_plant_fern_02a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -1.0, 0.0),
                End = vector4(0.0, 0.0, 1.0, 0.0),
            }
        }, 
        Rewards = {
            {name = "pickle_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['weed_seed'] = {
        Prop = {
            Model = `bkr_prop_weed_lrg_01a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -2.4, 0.0),
                End = vector4(0.0, 0.0, 1.8, 0.0),
            }
        }, 
        Rewards = {
            {name = "weed_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['cocaine_seed'] = {
        Prop = {
            Model = `bkr_prop_weed_lrg_01a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -2.4, 0.0),
                End = vector4(0.0, 0.0, 1.8, 0.0),
            }
        }, 
        Rewards = {
            {name = "cocaine_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 100,
    },
    ['heroin_seed'] = {
        Prop = {
            Model = `bkr_prop_weed_lrg_01a`,
            Offsets = {
                Start = vector4(0.0, 1.0, -2.4, 0.0),
                End = vector4(0.0, 0.0, 1.8, 0.0),
            }
        }, 
        Rewards = {
            {name = "heroin_raw", min = 1, max = 2},
        },
        Materials = {"Farm", "Farm2", "Farm3"}, -- If planting location has this material, plant.
        Zones = {vector4(-98.9300, 1911.5332, 196.8396, 10.0)}, -- If planting location is inside this range, plant.
        WaterNeeded = 10,
    },
}

Config.ExchangeSettings = {
    RenderDistance = 30.0, -- If exchange is a ped, what distance to display the ped.
    EnableSkillCheck = true, -- DISABLE IF NOT USING OX_LIB.
    ProcessTime = 5, -- Only used when EnableSkillCheck is false.
}

Config.Exchange = {
    -- Processing
    {
        Type = "Process", -- Find first processable item, then reward per required.
        Blip = {
            Label = "Job: Farming (Processing)",
            ID = 171,
            Color = 47,
            Scale = 0.85,
        },
        Location = vector4(2423.5002, 4985.6943, 45.9, 43.7853),
        Catalog = {
            ["corn_raw"] = {required = 2, name = "corn", min = 1, max = 1},
            ["tomato_raw"] = {required = 2, name = "tomato", min = 1, max = 1},
            ["wheat_raw"] = {required = 2, name = "wheat", min = 1, max = 1},
            ["broccoli_raw"] = {required = 2, name = "broccoli", min = 1, max = 1},
            ["carrot_raw"] = {required = 2, name = "carrot", min = 1, max = 1},
            ["potato_raw"] = {required = 2, name = "potato", min = 1, max = 1},
            ["pickle_raw"] = {required = 2, name = "pickle", min = 1, max = 1},
        }
    },
    -- Selling
    {
        Type = "Exchange", -- Go through entire inventory and exchange items for reward.
        Blip = {
            Label = "Job: Farming (Selling)",
            ID = 207,
            Color = 47,
            Scale = 0.85,
        },
        NPCModel = `a_m_m_farmer_01`,
        Location = vector4(1300.8643, 4318.9258, 37.1653, 301.4995),
        Catalog = {
            ["corn"] = {name = "money", min = 20, max = 40},
            ["tomato"] = {name = "money", min = 20, max = 40},
            ["wheat"] = {name = "money", min = 20, max = 40},
            ["broccoli"] = {name = "money", min = 20, max = 40},
            ["carrot"] = {name = "money", min = 20, max = 40},
            ["potato"] = {name = "money", min = 20, max = 40},
            ["pickle"] = {name = "money", min = 20, max = 40},
        }
    },
}

Config.Blips = {
    {
        Label = "Job: Farming (Fields)",
        ID = 677,
        Color = 47,
        Scale = 0.85,
        Location = vector3(2516.3718, 4845.3442, 36.1397)
    },
    {
        Label = "Job: Farming (Fields)",
        ID = 677,
        Color = 47,
        Scale = 0.85,
        Location = vector3(2225.2822, 5586.5454, 53.8013)
    },
    {
        Label = "Job: Farming (Fields)",
        ID = 677,
        Color = 47,
        Scale = 0.85,
        Location = vector3(-98.9300, 1911.5332, 196.8396)
    },
}