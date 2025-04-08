local QBCore = exports['qb-core']:GetCoreObject()
local peds = {}
local blips = {}

local function OpenShopInventory(shopName)
    if Config.Inventory == "ox" then
        exports.ox_inventory:openInventory('shop', { type = shopName })
    else
        local ShopItems = {}
        if Config.Inventory == "qb" then
            for k, v in pairs(Config.Items) do
                ShopItems[k] = {
                    name = v.name,
                    price = v.price,
                    amount = 999,
                    info = {},
                    type = v.type,
                    slot = #ShopItems + 1,
                }
            end
            TriggerServerEvent("inventory:server:OpenInventory", "shop", shopName, ShopItems)
        end
    end
end


CreateThread(function()
    for shopId, shop in pairs(Config.Shops) do
        for _, coords in pairs(shop.locations) do

            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            local blipConfig = Config.ShopTypes[shop.type].blip
            SetBlipSprite(blip, blipConfig.sprite)
            SetBlipScale(blip, blipConfig.scale)
            SetBlipColour(blip, blipConfig.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(shop.label)
            EndTextCommandSetBlipName(blip)
            table.insert(blips, blip)

            local model = Config.ShopTypes[shop.type].ped
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(0) end
            
            local ped = CreatePed(0, model, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
            TaskStartScenarioInPlace(ped, Config.ShopTypes[shop.type].scenario, 0, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            
            if Config.Target == "qb" then
                exports['qb-target']:AddTargetEntity(ped, {
                    options = {
                        {
                            type = "client",
                            event = "qb-shop:client:OpenShop",
                            icon = "fas fa-shop",
                            label = "Open Shop",
                            shop = shop.name
                        }
                    },
                    distance = 2.5
                })
            elseif Config.Target == "ox" then
                exports.ox_target:addLocalEntity(ped, {
                    {
                        name = 'shop_' .. shop.name,
                        icon = "fas fa-shop",
                        label = "Open Shop",
                        onSelect = function()
                            TriggerEvent('qb-shop:client:OpenShop', { shop = shop.name })
                        end,
                        distance = 2.5
                    }
                })
            end
            
            table.insert(peds, ped)
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, v in pairs(peds) do
            DeletePed(v)
        end
        for _, v in pairs(blips) do
            RemoveBlip(v)
        end
    end
end)

RegisterNetEvent('qb-shop:client:OpenShop')
AddEventHandler('qb-shop:client:OpenShop', function(data)
    OpenShopInventory(data.shop)
end)
