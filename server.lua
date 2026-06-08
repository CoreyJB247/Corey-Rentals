local QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject()
local ESX = GetResourceState('es_extended') == 'started' and exports.es_extended:getSharedObject()

local function PlayerName(src)
    if QBCore then 
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return 'Unknown' end
        return Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    elseif ESX then 
        local Player = ESX.GetPlayerFromId(src)
        if not Player then return 'Unknown' end

        -- Modern ESX (1.9+): character data lives on Player directly
        local firstName = Player.get and Player.get('firstName')
        local lastName  = Player.get and Player.get('lastName')

        if firstName and lastName then
            return firstName..' '..lastName
        end

        -- Older ESX: fall back to the display name stored on the player object
        local name = Player.getName and Player.getName()
        if name then return name end

        -- Last resort: use the source name from the game
        return GetPlayerName(src) or 'Unknown'
    end
    return GetPlayerName(src) or 'Unknown'
end

RegisterNetEvent('solos-rentals:server:RentVehicle', function(vehicle, plate)
    local src = source
    local player_name = PlayerName(src)
    exports.ox_inventory:AddItem(src, 'rentalpapers', 1, 
        {description = 'Owner: '..player_name..' | Plate: '..plate..' | Vehicle: '..vehicle:gsub("^%l", string.upper)}
    )

end)

RegisterNetEvent('solos-rentals:server:MoneyAmounts', function(vehiclename, price, locationkey)
    local src = source
    local moneytype = 'bank'
    local price = tonumber(price)
    local bank 
    local cash
    if QBCore then 
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        bank = Player.PlayerData.money.bank
        cash = Player.PlayerData.money.cash
    elseif ESX then 
        local Player = ESX.GetPlayerFromId(src)
        if not Player then return end
        bank = Player.getAccount('bank').money
        cash = Player.getAccount('money').money
    end

    if bank < price then 
        moneytype = 'cash'
        if cash < price then 
            TriggerClientEvent('ox_lib:notify', src, {
                id = 'not_enough_money',
                description = 'You don\'t have enough money to rent this vehicle.',
                position = 'center-right',
                icon = 'ban',
                iconColor = '#C53030'
            })
            return 
        end    
    end

    if QBCore then 
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        Player.Functions.RemoveMoney(moneytype, price)
    elseif ESX then
        local Player = ESX.GetPlayerFromId(src)
        if not Player then return end
        if moneytype == 'cash' then
            Player.removeMoney(price)
        elseif moneytype == 'bank' then
            Player.removeAccountMoney('bank', price)
        end
    end
    TriggerClientEvent('ox_lib:notify', src, {
        id = 'rental_success',
        description = vehiclename:gsub("^%l", string.upper)..' rented for $'..price..'.',
        position = 'center-right',
        icon = 'car',
        iconColor = 'white'
    })
    TriggerClientEvent('solos-rentals:client:SpawnVehicle', src, vehiclename, locationkey)
end)