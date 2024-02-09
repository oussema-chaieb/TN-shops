local Translations = {
    info = {
        open_shop = '[E] Shop',
        sell_chips = '[E] Sell Chips'
    },
    error = {
        missing_license = 'Missing a %s license for certain products',
    },
    success = {
        dealer_verify = 'The dealer verifies your license'
    },
    shop = {
        in_stock = "x %{amount} price : $%{price}",
        player_stock = " x %{amount}",
        amount = "amount",
        sold_out = "All items are sold out",
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})