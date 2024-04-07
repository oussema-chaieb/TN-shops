local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-shop:sv:pay', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if next(data.cartArr) ~= nil then
        print(json.encode(data.cartArr))
        if data.payType == "cash" then
            if Player.Functions.GetMoney(data.payType) >= data.price then
                Player.Functions.RemoveMoney('cash', data.price, 'cash transfer')
                for k,v in pairs(data.cartArr) do
                    Player.Functions.AddItem(v.name, tonumber(v.count))
                end
                TriggerClientEvent('QBCore:Notify', src,'Purchase transaction successful', 'success')
                TriggerEvent("qb-log:server:CreateLog", "shops", "shops", "blue", "**" .. GetPlayerName(src) .. "** spend $" .. data.price .. " in shop")
            else
                TriggerClientEvent('QBCore:Notify', src,'You dont have enough funds', 'error')

            end
        else        
            if Player.PlayerData.money.bank >= data.price then
                Player.Functions.RemoveMoney(data.payType, data.price)
                for k,v in pairs(data.cartArr) do
                    Player.Functions.AddItem(v.name, tonumber(v.count))
                end
                TriggerClientEvent('QBCore:Notify', src,'Purchase transaction successful', 'success')
                TriggerEvent("qb-log:server:CreateLog", "shops", "shops", "blue", "**" .. GetPlayerName(src) .. "** spend $" .. data.price .. " in shop")
            else
                TriggerClientEvent('QBCore:Notify', src,'You dont have enough funds', 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src,'nothing to buy', 'error')
    end
end)

RegisterNetEvent('qb-shops:server:buyshop', function(id,price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CitizenID = Player.PlayerData.citizenid
    local money = Player.PlayerData.money["bank"]
    local CostOfStation = price
    if 	money >= CostOfStation then
        Player.Functions.RemoveMoney("bank", CostOfStation) 
        MySQL.insert('INSERT INTO shops (shopid, owner, label, balance, category, items) VALUES (?, ?, ?, ?, ?, ?)', {id, CitizenID, 'supermarket', 0, json.encode({}), json.encode({})})
        TriggerClientEvent('QBCore:Notify', src, 'you successfly bought the shop', 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'not enough money', 'error', 5000)
    end
end)

QBCore.Functions.CreateCallback('qb-shops:server:getidsandowners', function(source, cb)
    local result = MySQL.Sync.fetchAll('SELECT shopid, owner FROM shops')
    if result then
        cb(result)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-shops:server:GetBalance', function(source, cb, id)
    local result = MySQL.Sync.fetchScalar('SELECT balance FROM shops WHERE shopid = ?', {id})
    cb(result)
end)

QBCore.Functions.CreateCallback('qb-shops:server:GetDuty', function(source, cb, id)
    local result = MySQL.Sync.fetchScalar('SELECT duty FROM shops WHERE shopid = ?', {id})
    cb(result)
end)

QBCore.Functions.CreateCallback('qb-shops:server:GetShopItemsAndCategory', function(source, cb, id)
    local category = MySQL.Sync.fetchScalar('SELECT category FROM shops WHERE shopid = ?', {id})
    local items = MySQL.Sync.fetchScalar('SELECT items FROM shops WHERE shopid = ?', {id})
    
    local dataToReturn = {
        categoryList = {},
        itemList = {}
    }
    local categoryL = json.decode(category)
    local itemsL = json.decode(items)
    dataToReturn.categoryList = categoryL or {}
    dataToReturn.itemList = itemsL or {}
    cb(dataToReturn)
end)

QBCore.Functions.CreateCallback('qb-shops:server:GetShopLabel', function(source, cb, id)
    local result = MySQL.Sync.fetchScalar('SELECT label FROM shops WHERE shopid = ?', {id})
    if result then        
        cb(result)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback("qb-shops:server:getPlayerItems", function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local items = Player.PlayerData.items
    cb(items)
end)

local function AddCategory(id, newCategory, description)
    local currentCategoryListJSON = MySQL.Sync.fetchScalar('SELECT category FROM shops WHERE shopid = ?', {id})

    local currentCategoryList = {}
    if currentCategoryListJSON then
        currentCategoryList = json.decode(currentCategoryListJSON) or {}
    end

    currentCategoryList[newCategory] = description

    local updatedCategoryList = json.encode(currentCategoryList)
    MySQL.update('UPDATE shops SET category = ? WHERE shopid = ?', {updatedCategoryList, id})
end

local function RemoveCategory(id, categoryToRemove)
    print(categoryToRemove)
    local currentCategoryListJSON = MySQL.Sync.fetchScalar('SELECT category FROM shops WHERE shopid = ?', {id})
    local currentItemsListJSON = MySQL.Sync.fetchScalar('SELECT items FROM shops WHERE shopid = ?', {id})

    local currentCategoryList = {}
    local currentItemsList = {}
    if currentCategoryListJSON then
        currentCategoryList = json.decode(currentCategoryListJSON) or {}
    end
    if currentItemsListJSON then
        currentItemsList = json.decode(currentItemsListJSON) or {}
    end

    currentCategoryList[categoryToRemove] = nil  -- Remove the specified category
    currentItemsList[categoryToRemove] = nil

    local updatedCategoryList = json.encode(currentCategoryList)
    local updatedItemsList = json.encode(currentItemsList)
    MySQL.update('UPDATE shops SET category = ?, items = ? WHERE shopid = ?', {updatedCategoryList, updatedItemsList, id})
end


RegisterNetEvent('qb-shops:server:addcategorie', function(id, categorie, desc)
    local src = source
    AddCategory(id, categorie, desc)
    TriggerClientEvent('QBCore:Notify', src,'You successfly Add New Categorie', 'success')
end)

RegisterNetEvent('qb-shops:server:removecategorie', function(id, categorie)
    local src = source
    RemoveCategory(id, categorie)
    TriggerClientEvent('QBCore:Notify', src,'You successfly Removed the Categorie', 'success')
end)

local function UpdateItems(id, itemList)
    local serializedItems = json.encode(itemList)
    MySQL.update('UPDATE shops SET items = ? WHERE shopid = ?', {serializedItems, id})
end


local function GetShopItems(id)
    local result = MySQL.Sync.fetchScalar('SELECT items FROM shops WHERE shopid = ?', {id})
    
    if result then
        local data = json.decode(result)
        local itemList = data or {}
        
        return itemList
    end
    
    return {}
end

local function AddItem(id, categoryName, newItem)
    local currentItemList = GetShopItems(id)
    
    if not currentItemList[categoryName] then
        currentItemList[categoryName] = {}
    end
    
    table.insert(currentItemList[categoryName], newItem)
    UpdateItems(id, currentItemList)
end

local function RemoveItem(id, itemName, amount)
    local currentItemList = GetShopItems(id)
    for categoryName, categoryItems in pairs(currentItemList) do
        print(json.encode(categoryItems))
        for i, item in pairs(categoryItems) do
            print(itemName)
            print(item.name)
            if item.name == itemName then
                if amount > item.amount then
                    return false
                elseif amount == item.amount then
                    table.remove(currentItemList, i)  -- If amount is equal to item amount, remove the item
                else
                    item.amount = item.amount - amount  -- If amount is less than item amount, update the item amount
                end
                UpdateItems(id, currentItemList)
                return true
            end
        end
    end
end

RegisterNetEvent('qb-shops:server:addshopitem', function(id, item, amount, price, itemtype, cat)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newItemToAdd = {
        name = item,
        price = price,
        amount = amount,
        info = {},
        type = itemtype,
        image = QBCore.Shared.Items[item].image,
    }
    if Player.Functions.GetItemByName(item).amount >= amount then
        Player.Functions.RemoveItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "Remove", amount)
        AddItem(id, cat, newItemToAdd)
        TriggerClientEvent('QBCore:Notify', src, "you successfly add "..item.." to your shop", 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "not enough amount in your packet", 'error')
    end
end)

RegisterNetEvent('qb-shops:server:removeitemfromshop', function(itemName, amount, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bool = RemoveItem(id, itemName, amount)
    if bool then
        Player.Functions.AddItem(itemName, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "add", amount)
        TriggerClientEvent('QBCore:Notify', src,'You took back '..amount..' '..itemName, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src,'You dont have that much', 'error')
    end
end)

local function UpdateItemPrice(id, itemName, newPrice)
    local currentItemList = GetShopItems(id)
    
    for categoryName, categoryItems in pairs(currentItemList) do
        for _, item in ipairs(categoryItems) do
            if item.name == itemName then
                item.price = newPrice
                UpdateItems(id, currentItemList)
                break  -- Break out of the loop once the item is found and updated
            end
        end
    end
end

RegisterNetEvent('qb-shops:server:changeitemprice', function(item, price, id)
    local src = source
    UpdateItemPrice(id, item, price)
    TriggerClientEvent('QBCore:Notify', src,'You successfly change '..item..' price to '..price, 'success')
end)

RegisterNetEvent('qb-shops:server:Withdraw', function(amount, id, ShopBalance)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local setamount = (ShopBalance - amount)
    if amount > ShopBalance then TriggerClientEvent('QBCore:Notify', src, "you do not have enough money in the shop", 'success') return end
    MySQL.update('UPDATE shops SET balance = ? WHERE shopid = ?', {setamount, id})
    Player.Functions.AddMoney("cash", amount)
    TriggerClientEvent('QBCore:Notify', src, "you successfly withdraw "..amount, 'success')
end)

RegisterNetEvent('qb-shops:server:Deposit', function(amount, id, ShopBalance)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local setamount = (ShopBalance + amount)
    if Player.Functions.RemoveMoney("cash", amount) then
        MySQL.update('UPDATE shops SET balance = ? WHERE shopid = ?', {setamount, id})
        TriggerClientEvent('QBCore:Notify', src, "you successfly deposit "..amount, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "you need to have "..amount, 'success')
    end
end)

RegisterNetEvent('qb-shops:server:toggleduty', function(duty, id)
    print("update")
    MySQL.update('UPDATE shops SET duty = ? WHERE shopid = ?', {duty, id})
end)

RegisterNetEvent('qb-shops:server:updatelocationname', function(newName, id)
    local src = source
    MySQL.update('UPDATE shops SET label = ? WHERE shopid = ?', {newName, id})
    TriggerClientEvent('QBCore:Notify', src, "store name successfly changed to "..newName.."!", 'success')
    TriggerClientEvent('qb-shops:cl:updatelabels', -1, id, newName)
end)

RegisterNetEvent('qb-shops:server:sellitback', function(id, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.AddMoney("cash", price, "sell shop back") then
        MySQL.execute('DELETE FROM shops WHERE shopid = ?', {id})
        TriggerClientEvent('QBCore:Notify', src, "shop sold succeffly", 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "failed to sell shops", 'error')
    end
end)

RegisterNetEvent('qb-shops:server:sellittoanother', function(playerid,price,shopid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherPlayer = QBCore.Functions.GetPlayer(playerid)
    if otherPlayer.Functions.RemoveMoney("cash", price, "sell shop to another player") then
        MySQL.Async.execute('UPDATE shops SET owner = ? WHERE shopid = ?', { otherPlayer.PlayerData.citizenid, shopid})
        Player.Functions.AddMoney('cash',price,'buy shop from another player')
        TriggerClientEvent('QBCore:Notify', src, "shop sold succeffly", 'success')
        TriggerClientEvent('QBCore:Notify', playerid, "shop bought succeffly with price "..price, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, "failed to sell shops", 'error')
        TriggerClientEvent('QBCore:Notify', playerid, "failed to bought shops, not enought cash", 'error')
    end
end)

RegisterNetEvent('qb-shops:sv:checklabels', function()
    local sqlresult = MySQL.Sync.fetchAll('SELECT shopid, label FROM shops', {})

    for _, row in pairs(sqlresult) do
        local citizenid = tonumber(row.citizenid)
        local timeInDB = tonumber(row.time)
        TriggerClientEvent('qb-shops:cl:updatelabels', -1, row.shopid, row.label)
    end
end)

RegisterNetEvent('qb-shops:server:orderitems', function(item, price, amount, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalprice = price * amount
    if Player.Functions.GetMoney("bank") >= totalprice then
        Player.Functions.RemoveMoney('bank', totalprice, 'order shop items')
        TriggerClientEvent('QBCore:Notify', src,'Take the vehicle outside and bring the items', 'success')
        TriggerClientEvent('qb-shops:client:startorderitems', src, item, id, amount)
    else
        TriggerClientEvent('QBCore:Notify', src,'You dont have enough money in your bank account', 'error')
    end
end)

local function checkcategorie(categorie, id)
    -- Fetch the current category list for the specified shop ID from the database
    local currentCategoryListJSON = MySQL.Sync.fetchScalar('SELECT category FROM shops WHERE shopid = ?', {id})

    -- Decode the JSON string into a Lua table
    local currentCategoryList = {}
    if currentCategoryListJSON then
        currentCategoryList = json.decode(currentCategoryListJSON) or {}
    end

    -- Check if the specified category exists in the decoded table
    return currentCategoryList[categorie] ~= nil
end

RegisterNetEvent('qb-shops:sv:addorderitemtostock', function(item, amount, id, categorie)
    local newItemToAdd = {
        name = item,
        price = 8,
        amount = amount,
        info = {},
        type = "item",
        image = QBCore.Shared.Items[item].image,
    }
    local iscategoriexist = checkcategorie(categorie, id)
    if iscategoriexist then
        AddItem(id,categorie,newItemToAdd)
    else
        AddCategory(id, categorie, "yoo")
        Wait(500)
        AddItem(id,categorie,newItemToAdd)
    end
    TriggerClientEvent('QBCore:Notify', source,'item has been successfly added', 'error')
end)