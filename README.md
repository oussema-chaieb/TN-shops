Config.Stores = {
    categoryList = {
        ["chopchop"] = "some equipement",
    },
    itemList = {
        ["chopchop"] = Config.Products['chopchop'],
    },	
}

RegisterNetEvent('orbit-chopchop:client:openstore', function()
    local ShopItems = {}
    ShopItems.label = "Chop Chop"
    ShopItems.itemList = Config.Stores.itemList
    ShopItems.categoryList = Config.Stores.categoryList
    TriggerEvent('qb-shops:client:openscriptshop', ShopItems)
end)