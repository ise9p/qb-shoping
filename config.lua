Config = {}

Config.Inventory = "ox" -- Options: "qb", "ox", "esx"
Config.Target = "qb" -- "qb" or "ox"
Config.Notify = "ox" -- "qb" or "ox"

Config.Webhooks = {
    enabled = true,
    url = "YOUR_DISCORD_WEBHOOK_URL_HERE",
    color = 3447003, -- Blue color
    logTitle = "Shop System Logs"
}

Config.ShopTypes = {
    ["general"] = {
        items = {
            { name = 'tosti',         price = 2 },
            { name = 'water_bottle',  price = 2 },
            { name = 'kurkakola',     price = 2 },
            { name = 'twerks_candy',  price = 2 },
            { name = 'snikkel_candy', price = 2 },
            { name = 'sandwich',      price = 2 },
        },
        label = "24/7 Shop",
        ped = `mp_m_shopkeep_01`,
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        blip = {
            sprite = 59,
            color = 2,
            scale = 0.5
        }
    },
    ["liquor"] = {
        items = {
            { name = 'beer',    price = 7 },
            { name = 'whiskey', price = 10 },
            { name = 'vodka',   price = 12 },
        },
        label = "LTD Gasoline",
        ped = `mp_m_shopkeep_01`,
        scenario = "WORLD_HUMAN_STAND_MOBILE",
        blip = {
            sprite = 59,
            color = 2,
            scale = 0.5
        }
    },
    ["weapons"] = {
        items = {
            { name = 'WEAPON_KNIFE', price = 250 },
			{ name = 'WEAPON_BAT', price = 250 },
			{ name = 'weapon_hatchet', price = 250 },
        },
        label = "AmmuNation",
        ped = `s_m_y_ammucity_01`,
        scenario = "WORLD_HUMAN_COP_IDLES",
        blip = {
            sprite = 110,
            color = 69,
            scale = 0.5
        }
    },
    ["YouTool"] = {
        items = {
            { name = 'phone', price = 1000 },
            { name = 'laptop', price = 2500 }
        },
        label = "YouTool",
        ped = `mp_m_waremech_01`,
        scenario = "WORLD_HUMAN_CLIPBOARD",
        blip = {
            sprite = 402,
            color = 18,
            scale = 0.6
        }
    }
}

Config.Shops = {
    ["247"] = {
        name = "shop_247",
        type = "general",
        label = "24/7 Shop",
        locations = {
            vector4(24.47, -1346.62, 29.5, 271.66),
            vector4(-3039.54, 584.38, 7.91, 17.27),
            vector4(-3242.97, 1000.01, 12.83, 357.57),
            vector4(1728.07, 6415.63, 35.04, 242.95),
            vector4(1959.82, 3740.48, 32.34, 301.57),
            vector4(549.13, 2670.85, 42.16, 99.39),
            vector4(2677.47, 3279.76, 55.24, 335.08),
            vector4(2556.66, 380.84, 108.62, 356.67),
            vector4(372.66, 326.98, 103.57, 253.73),
        }
    },
    ["liquor"] = {
        name = "shop_liquor",
        type = "liquor",
        label = "LTD Gasoline",
        locations = {
            vector4(-47.02, -1758.23, 29.42, 45.05),
            vector4(-706.06, -913.97, 19.22, 88.04),
            vector4(-1820.02, 794.03, 138.09, 135.45),
            vector4(1164.71, -322.94, 69.21, 101.72),
            vector4(1697.87, 4922.96, 42.06, 324.71),
        }
    },
    ["ammu"] = {
        name = "shop_ammu",
        type = "weapons",
        label = "AmmuNation",
        locations = {
            vector4(-661.96, -933.53, 21.83, 177.05),
            vector4(809.68, -2159.13, 29.62, 1.43),
            vector4(1692.67, 3761.38, 34.71, 227.65),
            vector4(-331.23, 6085.37, 31.45, 228.02),
            vector4(253.63, -51.02, 69.94, 72.91),
            vector4(23.0, -1105.67, 29.8, 162.91),
            vector4(2567.48, 292.59, 108.73, 349.68),
            vector4(-1118.59, 2700.05, 18.55, 221.89),
            vector4(841.92, -1035.32, 28.19, 1.56),
            vector4(-1304.19, -395.12, 36.7, 75.03),
            vector4(-3173.31, 1088.85, 20.84, 244.18),
        }
    },
    ["YouTool"] = {
        name = "shop_YouTool",
        type = "YouTool",
        label = "YouTool",
        locations = {
            vector4(-162.41, -1444.24, 31.45, 320.69),
        }
    }
}



Config.GetFormattedItems = function(shopType)
    if not shopType then return {} end
    local items = Config.ShopTypes[shopType].items
    
    if Config.Inventory == "ox" then
        return items
    else
        local formatted = {}
        for k, v in pairs(items) do
            formatted[v.name] = {
                name = v.name,
                price = v.price,
                amount = 50,
                info = {},
                type = "item",
                slot = k
            }
        end
        return formatted
    end
end
