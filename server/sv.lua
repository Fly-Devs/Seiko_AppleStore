RegisterNetEvent("Seiko_AppleStore:addItem")
AddEventHandler("Seiko_AppleStore:addItem", function(name, price)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem(name, 1)
end)