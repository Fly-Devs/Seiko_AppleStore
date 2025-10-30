  local AllBlips = {}

lib.registerContext({
    id = 'Seiko_AppleStore:shopMenu', 
    title = 'Menu du Apple Store',
    options = {
        {
            title = "Acheter un téléphone",
            icon = "fa-solid fa-mobile-screen-button",
            iconColor = "white",
            description = "Acheter une armes blanche",
            onSelect = function()
                OpenitemsMenu()
            end
        },
    }
})

function OpenitemsMenu()

    local option = {}
    for k, v in pairs(Config.items) do 
        print(v.name)
        table.insert(option, {
            title = v.label,
            description = v.name .."  \n Prix : " ..v.price,
            image = (Config.items.image),
            onSelect = function()
                TriggerServerEvent("Seiko_AppleStore:addItem", v.name, v.price)
            end
        })
    end
    lib.registerContext({
        id = "Seiko_AppleStore:AppleStore",
        title = "Choix du téléphone",
        options = option
    })
    lib.showContext("Seiko_AppleStore:AppleStore")
end

Citizen.CreateThread(function()
    for _, pos in ipairs(Config.Pos) do
        exports.ox_target:addBoxZone({
            coords = pos.coords,
            size = vec3(2, 2, 2),
            rotation = pos.coords.w,
            debug = false,
            options = {
                {
                    label = pos.label or "Ouvrir l'Apple Store",
                    icon = "fa-solid fa-mobile-screen-button",
                    onSelect = function()
                        lib.showContext('Seiko_AppleStore:shopMenu')
                    end
                }
            }
        })
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
      for _,v in pairs(Config.Map) do
        local blipMap = AddBlipForCoord(v.pos)
        SetBlipSprite(blipMap, v.id)
        SetBlipDisplay(blipMap, 4)
        SetBlipScale(blipMap, 0.8)
        SetBlipColour(blipMap, v.color)
        SetBlipAsShortRange(blipMap, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.name)
        EndTextCommandSetBlipName(blipMap)
        SetBlipPriority(blipMap, 5)
    end
end)