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
        local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
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
        local current = type(v["ped2"]) == "number" and v["ped2"] or joaat(v["ped2"])

        RequestModel(current)
        while not HasModelLoaded(current) do
            Wait(0)
        end

        ownablePed[k] = CreatePed(0, current, v["coords2"].x, v["coords2"].y, v["coords2"].z-1, v["coords2"].w, false, false)
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
    print(json.encode(allItems))
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

RegisterNetEvent('qb-shops:client:changeitemprice', function(data)
    local label = GetShopLabel(data.id)
    local items = GetAllItems(data.id)
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
            local current = type(v["ped"]) == "number" and v["ped"] or joaat(v["ped"])

            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
    
            ShopPed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
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