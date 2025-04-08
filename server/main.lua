local QBCore = exports['qb-core']:GetCoreObject()

local function SendDiscordLog(player, item, price)
    if not Config.Webhooks.enabled then return end
    
    local embed = {
        {
            ["color"] = Config.Webhooks.color,
            ["title"] = Config.Webhooks.logTitle,
            ["description"] = string.format("**Player:** %s\n**Item:** %s\n**Price:** $%s", 
                player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname,
                item.name,
                price
            ),
            ["footer"] = {
                ["text"] = os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(Config.Webhooks.url, function(err, text, headers) end, 'POST', json.encode({
        username = "Shop Logs",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

if Config.Inventory == "qb" then
    RegisterServerEvent('inventory:server:OpenInventory')
    AddEventHandler('inventory:server:OpenInventory', function(name, id, other)
        local src = source
        if name == "shop" then
            local shop = Config.Shops[id]
            TriggerClientEvent("inventory:client:OpenInventory", src, name, id, Config.GetFormattedItems(shop.type))
        end
    end)
elseif Config.Inventory == "ox" then
    CreateThread(function()
        Wait(2000)
        for _, shop in pairs(Config.Shops) do
            exports.ox_inventory:RegisterShop(shop.name, {
                name = Config.ShopTypes[shop.type].label,
                inventory = Config.GetFormattedItems(shop.type)
            })
        end
    end)
end

RegisterNetEvent('qb-shop:server:BuyItem')
AddEventHandler('qb-shop:server:BuyItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Items[data.item]
    
    if Player.Functions.RemoveMoney('cash', data.price) then
        Player.Functions.AddItem(data.name, 1)
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "Successfully purchased " .. item.label, "success")
        elseif Config.Notify == "ox" then
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Shop',
                description = "Successfully purchased " .. item.label,
                type = 'success'
            })
        end
        
        SendDiscordLog(Player, item, data.price)
    else
        if Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough money", "error")
        elseif Config.Notify == "ox" then
            TriggerClientEvent('ox_lib:notify', src, {
                title = 'Shop',
                description = "You don't have enough money",
                type = 'error'
            })
        end
    end
end)
