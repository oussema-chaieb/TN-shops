local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local inChips = false
local currentShop, currentData
local pedSpawned = false
local listen = false
local ShopPed = {}
local NewZones = {}
local pedSpawned2 = false
local ownablePed = {}
local price = 0
local StoreBlip = {}
local Item = nil
local Id = nil
local Amount = nil
-- Functions
local function createBlips()
    if pedSpawned then return end

    for store in pairs(Config.Locations) do
        if Config.Locations[store]["showblip"] then
            StoreBlip[Config.Locations[store]["id"]] = AddBlipForCoord(Config.Locations[store]["coords"]["x"], Config.Locations[store]["coords"]["y"], Config.Locations[store]["coords"]["z"])
            SetBlipSprite(StoreBlip[Config.Locations[store]["id"]], Config.Locations[store]["blipsprite"])
            SetBlipScale(StoreBlip[Config.Locations[store]["id"]], Config.Locations[store]["blipscale"])
            SetBlipDisplay(StoreBlip[Config.Locations[store]["id"]], 4)
            SetBlipColour(StoreBlip[Config.Locations[store]["id"]], Config.Locations[store]["blipcolor"])
            SetBlipAsShortRange(StoreBlip[Config.Locations[store]["id"]], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Locations[store]["label"])
            EndTextCommandSetBlipName(StoreBlip[Config.Locations[store]["id"]])
        end
    end
end

local function updateBlips(id,label)
    local blipcoords = GetBlipCoords(StoreBlip[id])
    RemoveBlip(StoreBlip[id])
    StoreBlip[id] = AddBlipForCoord(blipcoords.x, blipcoords.y, blipcoords.z)
    SetBlipSprite(StoreBlip[id], 52)
    SetBlipScale(StoreBlip[id], 0.7)
    SetBlipDisplay(StoreBlip[id], 4)
    SetBlipColour(StoreBlip[id], 0)
    SetBlipAsShortRange(StoreBlip[id], true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(StoreBlip[id])
end

local function Getitems(id)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-shops:server:GetShopItemsAndCategory', function(data)
        p:resolve(data)
    end,id)
    return Citizen.Await(p)
end

local function GetDuty(id)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-shops:server:GetDuty', function(data)
        p:resolve(data)
    end,id)
    return Citizen.Await(p)
end

local function GetAllItems(id)
    local data = Getitems(id)
    local combinedItemList = {}

    for _, categoryItems in pairs(data.itemList) do
        for _, item in ipairs(categoryItems) do
            table.insert(combinedItemList, item)
        end
    end

    return combinedItemList
end

local function GetShopLabel(id)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-shops:server:GetShopLabel', function(label)
        p:resolve(label)
    end,id)
    return Citizen.Await(p)
end

local function ownedOpenShop(id)
    local data = Getitems(id)
    print(data.categoryList)
    print(json.encode(data.itemList))
    local label = GetShopLabel(id)
    SendNUIMessage({
        action = "OPEN",
        data = {
            marketName = label,
            marketItemList = data.itemList,
            marketCategoryList = data.categoryList,
            marketJob = "",
        }
    })
    SetNuiFocus(true, true)
end

local function newOpenShop(name, itemList, categoryList, job)
    if job == "" then
        SendNUIMessage({
            action = "OPEN",
            data = {
                marketName = name,
                marketItemList = itemList,
                marketCategoryList = categoryList,
                marketJob = job,
            }
        })
        SetNuiFocus(true, true)
    else
        if job == PlayerData.job.name then
            SendNUIMessage({
                action = "OPEN",
                data = {
                    marketName = name,
                    marketItemList = itemList,
                    marketCategoryList = categoryList,
                    marketJob = job,
                }
            })
            SetNuiFocus(true, true)
        else
            QBCore.Functions.Notify('job required', 'error', 7500)
        end
    end
end

local function DisplayBuyShopMenu(name, id, price)
    local menu = {
        {
            header = name,
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        }
    }
    menu[#menu + 1] = {
        header =  "buy shop for "..price.. "$",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:buyshop',
            args = {
                id = id, 
                price = price, 
            }
        }
    }
    menu[#menu + 1] = {
        header = "close",
        icon = "fa-solid fa-angle-left",
        params = {event = 'qb-menu:client:closeMenu'}
    }
    exports['qb-menu']:openMenu(menu)
end

local function DisplayManageMenu(id)
    local menu = {
        {
            header = "Management menu",
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
        }
    }
    menu[#menu + 1] = {
        header =  "Manage store",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:managestore',
            args = {
                id = id, 
            },
        },
    }
    menu[#menu + 1] = {
        header =  "Manage funds",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:managefunds',
            args = {
                id = id, 
            },
        },
    }
    menu[#menu + 1] = {
        header =  "Toggle duty",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:toggleduty',
            args = {
                id = id, 
            },
        },
    }
    menu[#menu + 1] = {
        header =  "Change Store Name",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:changename',
            args = {
                id = id, 
            },
        },
    }
    menu[#menu + 1] = {
        header =  "Sell It Back",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:sellitback',
            args = {
                id = id, 
            },
        },
    }
    menu[#menu + 1] = {
        header =  "Sell It To Another",
        icon = "fa-solid fa-angle-right",
        params = {
            event = 'qb-shops:client:sellittoanother',
            args = {
                id = id, 
            },
        },
    }
    menu[#menu + 1] = {
        header = "Close Menu",
        icon = "fa-solid fa-angle-left",
        params = {event = 'qb-menu:client:closeMenu'}
    }
    exports['qb-menu']:openMenu(menu)
end

local function checkidsandowners()
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-shops:server:getidsandowners', function(result)
        p:resolve(result)
    end)
    return Citizen.Await(p)
end

local function checkhasowner(id)
    local hasowner = false
    local isowner = false
    local result = checkidsandowners()
    if not result then return hasowner, isowner end
    for k, v in pairs(result) do
        if v.shopid == id then
            hasowner = true
            if v.owner == PlayerData.citizenid then
                isowner = true
            end
        end
    end
    return hasowner, isowner
end

local function GetBalance(id)
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-shops:server:GetBalance', function(result)
        p:resolve(result)
    end,id)
    return Citizen.Await(p)
end

local function GetPlayerItems()
    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-shops:server:getPlayerItems', function(result)
        p:resolve(result)
    end,id)
    return Citizen.Await(p)
end

local function createPeds()
    if pedSpawned then return end

    for k, v in pairs(Config.Locations) do
        --local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

        RequestModel(v["ped"])
        while not HasModelLoaded(v["ped"]) do
            Wait(0)
        end

        ShopPed[k] = CreatePed(0, v["ped"], v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        TaskStartScenarioInPlace(ShopPed[k], v["scenario"], 0, true)
        FreezeEntityPosition(ShopPed[k], true)
        SetEntityInvincible(ShopPed[k], true)
        SetBlockingOfNonTemporaryEvents(ShopPed[k], true)


            exports['qb-target']:AddTargetEntity(ShopPed[k], {
                options = {
                    {
                        label = v["targetLabel"],
                        icon = v["targetIcon"],
                        item = v["item"],
                        action = function()
                            local hasowner, _ = checkhasowner(Config.Locations[k].id)
                            if hasowner then
                                ownedOpenShop(Config.Locations[k].id)
                            else
                                newOpenShop(v.label, v.itemList, v.categoryList, v.job)
                            end
                        end,
                    }
                },
                distance = 2.0
            })

    end

    pedSpawned = true
end

local function createOwnersPeds()
    if pedSpawned2 then return end

    for k, v in pairs(Config.Locations) do
        --if not v.ownable then return end
        --local current = type(v["ped2"]) == "number" and v["ped2"] or joaat(v["ped2"])

        RequestModel(v["ped2"])
        while not HasModelLoaded(v["ped2"]) do
            Wait(0)
        end

        ownablePed[k] = CreatePed(0, v["ped2"], v["coords2"].x, v["coords2"].y, v["coords2"].z-1, v["coords2"].w, false, false)
        TaskStartScenarioInPlace(ownablePed[k], v["scenario"], 0, true)
        FreezeEntityPosition(ownablePed[k], true)
        SetEntityInvincible(ownablePed[k], true)
        SetBlockingOfNonTemporaryEvents(ownablePed[k], true)


            exports['qb-target']:AddTargetEntity(ownablePed[k], {
                options = {
                    {
                        label = "Management",
                        icon = v["targetIcon"],
                        item = v["item"],
                        action = function()
                            local hasowner, isowner = checkhasowner(v.id)
                            if hasowner then
                                if isowner then
                                    price = v.price
                                    DisplayManageMenu(v.id)
                                else
                                    QBCore.Functions.Notify("You are not the owner", "error")
                                end
                            else
                                DisplayBuyShopMenu(v.label,v.id,v.price)
                            end
                        end,
                    }
                },
                distance = 2.0
            })

    end

    pedSpawned2 = true
end

local function deletePeds()
    if not pedSpawned then return end
    if not pedSpawned2 then return end

    for _, v in pairs(ShopPed) do
        DeletePed(v)
    end
    for _, v in pairs(ownablePed) do
        DeletePed(v)
    end
    pedSpawned = false
    pedSpawned2 = false
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    createBlips()
    createPeds()
    createOwnersPeds()
    TriggerServerEvent("qb-shops:sv:checklabels")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
    PlayerData = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    createBlips()
    createPeds()
    createOwnersPeds()
    TriggerServerEvent("qb-shops:sv:checklabels")
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deletePeds()
end)

RegisterNUICallback('close',function(cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('pay',function(data)
    TriggerServerEvent("qb-shop:sv:pay", data)
end)

RegisterNetEvent("qb-shops:client:buyshop", function(data)
    TriggerServerEvent("qb-shops:server:buyshop", data.id, data.price)
end)

RegisterNetEvent('qb-shops:cl:updatelabels', function(id, label)
    updateBlips(id,label)
end)

RegisterNetEvent('qb-shops:client:managestore', function(data) -- Menu, seens after selecting the "purchase reserves" option.
    exports['qb-menu']:openMenu({
        {
            header = "Management Items",
            isMenuHeader = true,
            icon = "fas fa-gas-pump",
        },
        {
            header = "add categorie",
            txt = "", 
            icon = "fas fa-usd",
            params = {
                event = "qb-shops:client:addcategorie",
                args = {
                    id = data.id,
                },
            },
        },
        {
            header = "remove categorie",
            txt = "", 
            icon = "fas fa-usd",
            params = {
                event = "qb-shops:client:removecategorie",
                args = {
                    id = data.id,
                },
            },
        },
        {
            header = "add item",
            txt = "", 
            icon = "fas fa-usd",
            params = {
                event = "qb-shops:client:additemtoshop",
                args = {
                    id = data.id,
                },
            },
        },
        {
            header = "remove item",
            txt = "", 
            icon = "fas fa-usd",
            params = {
                event = "qb-shops:client:removeitemfromshop",
                args = {
                    id = data.id,

                },
            },
        },
        {
            header = "Order items",
            txt = "", 
            icon = "fas fa-usd",
            params = {
                event = "qb-shops:client:orderitems",
                args = {
                    id = data.id,
                },
            },
        },
        {
            header = "change price",
            txt = "", 
            icon = "fas fa-usd",
            params = {
                event = "qb-shops:client:changeitemprice",
                args = {
                    id = data.id, 
                },
            },
        },
        {
            header = "Close Menu",
            txt = "", 
            icon = "fas fa-times-circle",
            params = {
                event = "qb-shops:client:retourmenu",
                args = {
                    id = data.id,
                },
            }
        },
    })
end)

RegisterNetEvent('qb-shops:client:managefunds', function(data)
    local balance = GetBalance(data.id)
    if balance then
        exports['qb-menu']:openMenu({
            {
                header = "Management Funds",
                txt = "Shop Balance : "..balance,
                isMenuHeader = true,
                icon = "fas fa-gas-pump",
            },
            {
                header = "Withdraw",
                icon = "fas fa-arrow-left",
                txt = "Withdraw money from the shop",
                params = {
                    event = "qb-shops:client:WithdrawFunds",
                    args = {
                        id = data.id, 
                    }
                },
            },
            {
                header = "Deposit",
                icon = "fas fa-arrow-right",
                txt = "Deposit money in the store",
                params = {
                    event = "qb-shops:client:DepositFunds",
                    args = {
                        id = data.id, 
                    }
                },
            },
            {
                header = "Return",
                txt = "", 
                icon = "fas fa-times-circle",
                params = {
                    event = "qb-shops:client:retourmenu",
                    args = {
                        id = data.id, 
                    },
                }
            },
        })
    end
end)

RegisterNetEvent('qb-shops:client:WithdrawFunds', function(data)
    local balance = GetBalance(data.id)
    local Withdraw = exports['qb-input']:ShowInput({
        header = "Current Balance : " ..balance,
        submitText = "SUBMIT",
        inputs = { {
            type = 'number',
            isRequired = true,
            name = 'amount',
            text = "Money to withdraw"
        }}
    })
    if Withdraw then
        Wait(100)
        local amount = tonumber(Withdraw.amount)
        if not Withdraw.amount then QBCore.Functions.Notify("Number invalid", 'error', 7500) return end
        if amount < 1 then QBCore.Functions.Notify("you can not withdraw less than 1$", 'error', 7500) return end
        if amount > balance then QBCore.Functions.Notify("Your Store do not have that much of money", 'error', 7500) return end
        if (balance - amount) < 0 then
            QBCore.Functions.Notify("Your Store do not have that much of money", 'error', 7500)
        else
            TriggerServerEvent('qb-shops:server:Withdraw', amount, data.id, balance)
        end    
    end
end)

RegisterNetEvent('qb-shops:client:DepositFunds', function(data)
    local balance = GetBalance(data.id)
    local CitizenID = QBCore.Functions.GetPlayerData().citizenid
    local money = QBCore.Functions.GetPlayerData().money['cash']
    local Deposit = exports['qb-input']:ShowInput({
        header = "Store Balance = " ..balance,
        submitText = "SUBMIT",
        inputs = { {
            type = 'number',
            isRequired = true,
            name = 'amount',
            text = "Money to Deposit"
        }}
    })
    if Deposit then
        Wait(100)
        local amount = tonumber(Deposit.amount)
        if not Deposit.amount then QBCore.Functions.Notify("Invalid Number", 'error', 7500) return end
        if amount < 1 then QBCore.Functions.Notify("You can not deposit less than 1$", 'error', 7500) return end
        if amount > money then
            QBCore.Functions.Notify("you dont have enough money in your packet", "error")
        else
            TriggerServerEvent('qb-shops:server:Deposit', amount, data.id, balance)
        end    
    end
end)

RegisterNetEvent('qb-shops:client:retourmenu', function(data) -- Menu, seens after selecting the "purchase reserves" option.
    DisplayManageMenu(data.id)
end)

RegisterNetEvent('qb-shops:client:addcategorie', function(data)
    local label = GetShopLabel(data.id)
    local menu = exports["qb-input"]:ShowInput({
        header = label,
        submitText = "SUBMIT",
        inputs = {
            {
                type = "text",
                text = "name",
                name = "name",
                isRequired = true
            },
            {
                type = "text",
                text = "Description",
                name = "desc",
                isRequired = true
            },
        }
    })
    if menu then
        TriggerServerEvent('qb-shops:server:addcategorie', data.id, menu.name, menu.desc)
    end
end)

RegisterNetEvent('qb-shops:client:removecategorie', function(data)
    local label = GetShopLabel(data.id)
    local shopIt = Getitems(data.id)
    local shopCategory = shopIt.categoryList
    local categoryKeys = {}
    for key, _ in pairs(shopCategory) do
        categoryKeys[#categoryKeys + 1] = {
            text = key,
            value = key,
        }
    end
    local menu = exports["qb-input"]:ShowInput({
        header = label,
        submitText = "SUBMIT",
        inputs = {
            {
                type = "select",
                text = "Select Categorie",
                name = "cat",
                options = categoryKeys,
                isRequired = true
            },
        }
    })
    if menu then
        TriggerServerEvent('qb-shops:server:removecategorie', data.id, menu.cat)
    end
end)

RegisterNetEvent('qb-shops:client:additemtoshop', function(data)
    local label = GetShopLabel(data.id)
    local items = GetPlayerItems()
    local shopIt = Getitems(data.id)
    local shopCategory = shopIt.categoryList
    local categoryKeys = {}
    if next(shopCategory) == nil then return QBCore.Functions.Notify("you need to add category first", "error") end
    for key, _ in pairs(shopCategory) do
        categoryKeys[#categoryKeys + 1] = {
            text = key,
            value = key,
        }
    end
    local itemlist = {}
    for _, item in pairs(items) do
        if QBCore.Shared.Items[item.name] then
            if item.amount >= 1 then
                itemlist[#itemlist + 1] = {
                    text = item.label.." "..Lang:t('shop.player_stock', {amount = item.amount}),
                    value = item.name, 
                    amount = item.amount
                }
            end
        end
    end
    local menu = exports["qb-input"]:ShowInput({
        header = label,
        submitText = "SUBMIT",
        inputs = {
            {
                type = "select",
                text = "Select Item",
                name = "item",
                options = itemlist,
                isRequired = true
            },
            {
                type = "select",
                text = "Select Categorie",
                name = "cat",
                options = categoryKeys,
                isRequired = true
            },
            {
                type = "number",
                text = "amount",
                name = "amount",
                isRequired = true
            },
            {
                type = "number",
                text = "Price",
                name = "price",
                isRequired = true
            },
            {
                text = "Item Type", -- text you want to be displayed as a input header
                name = "type", -- name of the input should be unique otherwise it might override
                type = "radio", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
                options = { -- The options (in this case for a radio) you want displayed, more than 6 is not recommended
                    { value = "item", text = "item" }, -- Options MUST include a value and a text option
                    { value = "weapon", text = "weapon" }, -- Options MUST include a value and a text option
                },
                default = "item", -- Default radio option, must match a value from above, this is optional
            },
        }
    })
    if menu then
        if not menu.item and not menu.amount and not menu.type and not menu.cat then
            return
        else
            if menu.item and tonumber(menu.amount) > 0 then
                TriggerServerEvent('qb-shops:server:addshopitem', data.id, menu.item, tonumber(menu.amount), tonumber(menu.price), menu.type, menu.cat)
            end
        end
    end
end)

RegisterNetEvent('qb-shops:client:removeitemfromshop', function(data)
    local label = GetShopLabel(data.id)
    local allItems = GetAllItems(data.id)
    if next(allItems) == nil then return QBCore.Functions.Notify("no item to remove", "error") end
    local itemlist = {}
    for _, item in pairs(allItems) do
        print(item.name)
        if QBCore.Shared.Items[item.name] then
            if item.amount >= 1 then
                itemlist[#itemlist + 1] = {
                    text = QBCore.Shared.Items[item.name].label.." "..Lang:t('shop.in_stock', {amount = item.amount, price = item.price}),
                    value = item.name, 
                    amount = item.amount
                }
            end
        end
    end
    local menu = exports["qb-input"]:ShowInput({
        header = label,
        submitText = "SUBMIT",
        inputs = {
            {
                type = "select",
                text = "Select Item",
                name = "item",
                options = itemlist,
                isRequired = true
            },
            {
                type = "number",
                text = Lang:t('shop.amount'),
                name = "amount",
                isRequired = true
            },
        }
    })
    if menu then
        if not menu.item and not menu.amount then
            return
        else
            if menu.item and tonumber(menu.amount) > 0 then
                print("ok")
                TriggerServerEvent("qb-shops:server:removeitemfromshop", menu.item, tonumber(menu.amount), data.id)
            end
        end
    end
end)

RegisterNetEvent('qb-shops:client:orderitems', function(data)
    local OrdreMenu = {
        {
            header = "Order Menu",--Lang:t('menu.dryMeny'),
            isMenuHeader = true
        }
    }
    for k, v in pairs(Config.Orders.items) do
        OrdreMenu[#OrdreMenu + 1] = {
            header = QBCore.Shared.Items[v.item].label,
            icon = "fa-solid fa-circle",
            txt = "Order this item with price : "..v.price.." $",
            params = {
                event = 'qb-shops:client:amountorderitem',
                args = {
                    id = data.id,
                    item = v.item,
                    categorie = v.categorie,
                    price = v.price
                }
            }
        }
    end
    OrdreMenu[#OrdreMenu + 1] = {
        header = Lang:t('menu.exitHeader'),
        params = {
            event = "qb-menu:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(OrdreMenu)
end)
local Categorie = nil
RegisterNetEvent('qb-shops:client:amountorderitem', function(data)
    local menu = exports["qb-input"]:ShowInput({
        header = "how many",
        submitText = "SUBMIT",
        inputs = {
            {
                type = "number",
                text = "123",
                name = "amount",
                isRequired = true
            },
        }
    })
    if menu then
        if not menu.amount then
            return
        else
            if tonumber(menu.amount) > 0 then
                Categorie = data.categorie
                TriggerServerEvent("qb-shops:server:orderitems", data.item, data.price, tonumber(menu.amount), data.id)
            else
                return QBCore.Functions.Notify("must be greater than 0", "error")
            end
        end
    end
end)

RegisterNetEvent('qb-shops:client:changeitemprice', function(data)
    local label = GetShopLabel(data.id)
    local items = GetAllItems(data.id)
    if next(items) == nil then return QBCore.Functions.Notify("you need to add items first", "error") end
    local itemlist = {}
    for _, item in pairs(items) do
        if QBCore.Shared.Items[item.name] then
            if item.amount >= 1 then
                itemlist[#itemlist + 1] = {
                    text = QBCore.Shared.Items[item.name].label.." "..Lang:t('shop.in_stock', {amount = item.amount, price = item.price}),
                    value = item.name, 
                    amount = item.amount
                }
            end
        end
    end
    local menu = exports["qb-input"]:ShowInput({
        header = label,
        submitText = "SUBMIT",
        inputs = {
            {
                type = "select",
                text = "Select Item",
                name = "item",
                options = itemlist,
                isRequired = true
            },
            {
                type = "number",
                text = "Price",
                name = "price",
                isRequired = true
            },
        }
    })
    if menu then
        if not menu.item and not menu.price then
            return
        else
            if menu.item and tonumber(menu.price) > 0 then
                TriggerServerEvent("qb-shops:server:changeitemprice", menu.item, tonumber(menu.price), data.id)
            else
                return
            end
        end
    end
end)

local function togglePeds(id)

    for k, v in pairs(Config.Locations) do
        if v.id == id then
            --local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

            RequestModel(v["ped"])
            while not HasModelLoaded(v["ped"]) do
                Wait(0)
            end
    
            ShopPed[k] = CreatePed(0, v["ped"], v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
            TaskStartScenarioInPlace(ShopPed[k], v["scenario"], 0, true)
            FreezeEntityPosition(ShopPed[k], true)
            SetEntityInvincible(ShopPed[k], true)
            SetBlockingOfNonTemporaryEvents(ShopPed[k], true)
    
            if Config.UseTarget then
                exports['qb-target']:AddTargetEntity(ShopPed[k], {
                    options = {
                        {
                            label = v["targetLabel"],
                            icon = v["targetIcon"],
                            item = v["item"],
                            action = function()
                                local hasowner, _ = checkhasowner(Config.Locations[k].id)
                                if hasowner then
                                    ownedOpenShop(Config.Locations[k].id)
                                else
                                    newOpenShop(v.label, v.itemList, v.categoryList, v.job)
                                end
                            end,
                        }
                    },
                    distance = 2.0
                })
            end
        end
    end
end

RegisterNetEvent('qb-shops:client:toggleduty', function(data) 
    local duty = GetDuty(data.id)
    if duty == 0 then
        for k, v in pairs(Config.Locations) do
            if v.id == data.id then
                DeletePed(ShopPed[k])
            end
        end
        TriggerServerEvent('qb-shops:server:toggleduty', 1, data.id)
        QBCore.Functions.Notify("you give your employement a repot and you take the job", "success")
    elseif duty == 1 then
        togglePeds(data.id)
        TriggerServerEvent('qb-shops:server:toggleduty', 0, data.id)
        QBCore.Functions.Notify("your employer is back to his job", "success")
    else
        QBCore.Functions.Notify("duty !!!!!!!!", "error")
    end
end)

RegisterNetEvent('qb-shops:client:changename', function(data) -- Menu for changing the label of the owned station.
    local label = GetShopLabel(data.id)
    local NewName = exports['qb-input']:ShowInput({
        header = "Choose a new name instead of "..label,
        submitText = "SUBMIT",
        inputs = { {
            type = 'text',
            isRequired = true,
            name = 'newname',
            text = label
        }}
    })
    if NewName then
        if not NewName.newname then QBCore.Functions.Notify("Invalid Name", 'error', 5000) return end
        NewName = NewName.newname
        if type(NewName) ~= "string" then QBCore.Functions.Notify("Invalid Name", 'error') return end
        if string.len(NewName) > Config.NameChangeMaxChar then QBCore.Functions.Notify("Name is too long", 'error') return end
        if string.len(NewName) < Config.NameChangeMinChar then QBCore.Functions.Notify("Name is too short", 'error') return end
        Wait(100)
        TriggerServerEvent("qb-shops:server:updatelocationname", NewName, data.id) 
        QBCore.Functions.Notify("you successfly change the name of the store", 'success', 5000)
    end
end)

RegisterNetEvent('qb-shops:client:sellitback', function(data)
    TriggerServerEvent('qb-shops:server:sellitback', data.id, (price * 0.5))
end)

RegisterNetEvent('qb-shops:client:sellittoanother', function(data) -- Menu for changing the label of the owned station.
    local NewName = exports['qb-input']:ShowInput({
        header = "sell your shop",
        submitText = 'sell to another player',
        inputs = { 
            {
                type = 'number',
                isRequired = true,
                name = 'id',
                text = "player id"
            },
            {
                type = 'number',
                isRequired = true,
                name = 'price',
                text = 'price'
            }
        }
    })
    if NewName then
        TriggerServerEvent("qb-shops:server:sellittoanother", tonumber(NewName.id), tonumber(NewName.price), data.id) 
    end
end)

-- RegisterNetEvent('qb-shops:client:sellshoptoplayer', function(playerid, price, shopid)
--     local NewName = exports['qb-input']:ShowInput({
--         header = "Buy Shop",
--         submitText = 'Do you agree to buy this shop with price',
--         inputs = { 
--             {
--                 text = "$ "..price, -- text you want to be displayed as a input header
--                 name = "billtype", -- name of the input should be unique otherwise it might override
--                 type = "radio", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
--                 options = { -- The options (in this case for a radio) you want displayed, more than 6 is not recommended
--                     { value = "yes", text = "Yes" }, -- Options MUST include a value and a text option
--                     { value = "no", text = "No" }, -- Options MUST include a value and a text option
--                 },
--                 default = "no", -- Default radio option, must match a value from above, this is optional
--             },
--         }
--     })
--     if NewName then
--         if NewName.billtype == "no" then
--             QBCore.Functions.Notify("you decline the shop sell offer", 'error', 5000)
--         else
--             TriggerServerEvent("qb-shops:server:sellittoanother", playerid, price, shopid) 
--         end
--     end
-- end)

RegisterNetEvent('qb-shops:client:openscriptshop', function(data)
    SendNUIMessage({
        action = "OPEN",
        data = {
            marketName = data.label,
            marketItemList = data.itemList,
            marketCategoryList = data.categoryList,
            marketJob = "fuck",
        }
    })
    SetNuiFocus(true, true)
end)
local PlaceBlip = nil
local DrugObject = nil
local DrugObject2 = nil
local DrugTaken,DrugTaken2 = 0,0
local haspackage,haspackage2 = false,false
local Vehicle = nil
local pack = nil
local packagetrunk = 0
local anim = false
local minus = 0
local PlaceDepotPayoutBlip = nil
local Place

local function PlaceB()
	PlaceBlip = AddBlipForCoord(Config.Orders.delivery[Place].Pos.x, Config.Orders.delivery[Place].Pos.y, Config.Orders.delivery[Place].Pos.z)
	SetBlipSprite(PlaceBlip, 310)
	SetBlipColour(PlaceBlip, 0)
	SetBlipAlpha(PlaceBlip, 250)
	SetBlipScale(PlaceBlip, 0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Place')
	EndTextCommandSetBlipName(PlaceBlip)
end

local function PlaceDepotPayoutB()
	PlaceDepotPayoutBlip = AddBlipForCoord(Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z)
	SetBlipSprite(PlaceDepotPayoutBlip, 500)
	SetBlipColour(PlaceDepotPayoutBlip, 0)
	SetBlipAlpha(PlaceDepotPayoutBlip, 250)
	SetBlipScale(PlaceDepotPayoutBlip, 0.8)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Payout')
	EndTextCommandSetBlipName(PlaceDepotPayoutBlip)
end

local function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 49, 0, false, false, false)
	end)
end

local function tookitems(num)
    local ped = PlayerPedId()
    startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
    QBCore.Functions.Progressbar("search_for_item", "You pick items...", 1000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
    end, function()
    end)
    Wait(1000)
    ClearPedTasks(ped)
    local coordsPED = GetEntityCoords(ped)
    local packmodel = math.random(1,2)
    anim = true
    if packmodel == 1 then
        pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01b'), coordsPED.x, coordsPED.y, coordsPED.z,  false,  true, true)
    else
        pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01'), coordsPED.x, coordsPED.y, coordsPED.z,  false,  true, true)
    end
    SetEntityCollision(pack, false)		
    AttachEntityToEntity(pack, ped, GetPedBoneIndex(ped, 57005), 0.25, 0.05, -0.2, 300.0, 250.0, 20.0, true, true, false, true, 1, true)

    SetVehicleDoorsLocked(Vehicle, 2)
    if num == 1 then
        haspackage = true
        DrugTaken = DrugTaken + 1
        if DrugTaken > 2 then
            DeleteEntity(DrugObject)
            DrugObject = nil
            RemoveBlip(PlaceDrugBlip)
            DrugTaken = 0
        end
    elseif num == 2 then
        haspackage2 = true
        DrugTaken2 = DrugTaken2 + 1
        if DrugTaken2 > 2 then
            DeleteEntity(DrugObject2)
            DrugObject2 = nil
            RemoveBlip(PlaceDrugBlip2)
            DrugTaken2 = 0
        end
    end
end



local function startdelivery(item, id, amount)
    if not IsAnyVehicleNearPoint(Config.Orders.carspawn[id].x, Config.Orders.carspawn[id].y, Config.Orders.carspawn[id].z, 2) then	
        QBCore.Functions.SpawnVehicle(Config.Orders.carmodel, function(vehicle)
            SetVehicleNumberPlateText(vehicle, "DON_"..tostring(math.random(1000, 9999)))
            SetEntityHeading(vehicle, Config.Orders.carspawn[id].w)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
            SetVehicleEngineOn(vehicle, true, true)
            SetVehicleDirtLevel(vehicle, 0.0)
            exports[Config.Fuel]:SetFuel(vehicle, 100)
            Vehicle = vehicle
            Item = item
            Id = id
            Amount = amount
        end, Config.Orders.carspawn[id], true)
        Place = math.random(1,15)
        PlaceB()

        CreateThread(function()

            DrugObject = CreateObject(GetHashKey('hei_prop_heist_weed_pallet'), Config.Orders.delivery[Place].DrugPos.x, Config.Orders.delivery[Place].DrugPos.y, Config.Orders.delivery[Place].DrugPos.z-1, false, true, true)
            PlaceObjectOnGroundProperly(DrugObject)
            FreezeEntityPosition(DrugObject, true)

            exports['qb-target']:AddTargetEntity(DrugObject, {
                options = { {
                    icon = "fas fa-sack-dollar",
                    label = "take items",
                    action = function()
                        tookitems(1)
                    end
                }
                },
                distance = 1.5
            })

            DrugObject2 = CreateObject(GetHashKey('hei_prop_heist_weed_pallet'), Config.Orders.delivery[Place].DrugPos2.x, Config.Orders.delivery[Place].DrugPos2.y, Config.Orders.delivery[Place].DrugPos2.z-1, false, true, true)
            PlaceObjectOnGroundProperly(DrugObject2)
            FreezeEntityPosition(DrugObject2, true)

            exports['qb-target']:AddTargetEntity(DrugObject2, {
                options = { {
                    icon = "fas fa-sack-dollar",
                    label = "take items",
                    action = function()
                        tookitems(2)
                    end
                }
                },
                distance = 1.5
            })
        end)
    else
        QBCore.Functions.Notify("The spawn site is blocked!", "error")
    end
end

RegisterNetEvent('qb-shops:client:startorderitems', function(item, id, amount)
    QBCore.Functions.Notify("Take my car and go to your first destination", "success")
    startdelivery(item, id, amount)
end)

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		 	if haspackage or haspackage2 then
				sleep = 5 
				local trunkpos = GetOffsetFromEntityInWorldCoords(Vehicle, 0, -2.5, 0)
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, trunkpos.x, trunkpos.y, trunkpos.z, true) < 2.5 then
					DrawText3Ds(trunkpos.x, trunkpos.y, trunkpos.z + 0.25, 'To put down drugs, press [~g~E~w~]')
					if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(ped, false) then
						DeleteEntity(pack)
						startAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search")
                        QBCore.Functions.Progressbar("put_item", "You put the drugs down...", 1000, false, false, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function()
                        end, function()
                        end)
						Citizen.Wait(1000)
                        anim = false
						ClearPedTasks(ped)
						haspackage = false
						haspackage2 = false
						SetVehicleDoorsLocked(Vehicle, 1)
						ClearPedTasks(ped)
						TaskPlayAnim(ped, 'anim@heists@box_carry@', "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0)					
					
						
						local coordsPED = GetEntityCoords(ped)
						
						if packmodel == 1 then
							Config.Package[packagetrunk].pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01b'), coordsPED.x, coordsPED.y, coordsPED.z, false, true, true)
						else
							Config.Package[packagetrunk].pack = CreateObject(GetHashKey('hei_prop_heist_weed_block_01'), coordsPED.x, coordsPED.y, coordsPED.z, false, true, true)
						end
						SetEntityCollision(Config.Package[packagetrunk].pack, false)

						if packagetrunk < 4 then
							AttachEntityToEntity(Config.Package[packagetrunk].pack, Vehicle, GetEntityBoneIndexByName(Vehicle, 'boot'), -0.2, 1.8-minus, 0.05, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						elseif packagetrunk >= 4 and packagetrunk < 8 then
							if minus >= 1.0 then
								minus = 0.0
							end
							AttachEntityToEntity(Config.Package[packagetrunk].pack, Vehicle, GetEntityBoneIndexByName(Vehicle, 'boot'), 0.2, 1.8-minus, 0.05, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						else 
							if minus >= 1.0 then
								minus = 0.0
							end
							AttachEntityToEntity(Config.Package[packagetrunk].pack, Vehicle, GetEntityBoneIndexByName(Vehicle, 'boot'), 0.0, 1.8-minus, 0.18, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						end
						minus = minus + 0.25
						packagetrunk = packagetrunk + 1
					end
				end
			end
            if packagetrunk >= 1 then
                if not DrugObject2 and not DrugObject then
                    QBCore.Functions.Notify("Go back to the payer for the payout!", "error")
                    PlaceDepotPayoutB()
                    while true do
                        local sleep = 500
                        local ped = PlayerPedId()
                        local coords = GetEntityCoords(ped)
                        if(GetDistanceBetweenCoords(coords,Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z, true) < 1.5) then	
                            sleep = 5
                            DrawText3Ds(Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z+1.0, 'To collect your paycheck, press [~g~G~w~]')
                            DrawMarker(25, Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
                            DrawMarker(36, Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                            if IsControlJustReleased(0, 47) and IsPedInAnyVehicle(ped, false) then
                                DeleteVehicle(Vehicle)
                                Vehicle = nil
                                RemoveBlip(PlaceBlip)
                                DrugTaken = 0
                                DrugTaken2 = 0
                                haspackage = false
                                haspackage2 = false
                                packagetrunk = 0
                                ClearPedTasks(ped)
                                DeleteEntity(pack)
                                minus = 0
                                anim = false
                                RemoveBlip(PlaceDepotPayoutBlip)
                                for i, v in pairs(Config.Package) do
                                    DeleteEntity(v.pack)
                                end
                                TriggerServerEvent("qb-shops:sv:addorderitemtostock", Item, Amount, Id, Categorie)
                                Place = nil
                                break
                            end
                        else
                            sleep = 5
                            DrawMarker(25, Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z-0.55, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                            DrawMarker(36, Config.Orders.carspawn[Id].x, Config.Orders.carspawn[Id].y, Config.Orders.carspawn[Id].z+0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                        end									
                        Citizen.Wait(sleep)
                    end
                end
            end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local doo = 0
	while true do
		sleep = 500
		if anim then
			sleep = 0
			RequestAnimDict('anim@heists@box_carry@')
			while not HasAnimDictLoaded('anim@heists@box_carry@') do
			  Citizen.Wait(0)
			end
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle' ,8.0, -8.0, -1, 49, 0, false, false, false)
			doo = doo + 1 
			if doo >= 3 then
				doo = 0
				anim = false
			end
		end			
		Citizen.Wait(sleep)
	end
end)