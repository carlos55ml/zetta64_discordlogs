Config = {}

function SendWebHook(whLink, title, color, message)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = timestamp.." (Server Time).",
            },
        }
    }
    PerformHttpRequest(whLink,
    function(err, text, headers)end, 'POST', json.encode({username = Config.whName, avatar_url= Config.whLogo ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end


AddEventHandler('z64_logs:sendWebhook', function(whData)
    if whData.link == nil then
        whLink = Config.whlink
    else
        whLink = whData.link
    end
    title = whData.title
    color = whData.color
    message = whData.message
    SendWebHook(whLink, title, color, message)
end)

Citizen.CreateThread(function()
    if Config.loginLog then
        if Config.loginLogLink == '' then
            print('^7[^1INFO^7]: Please set a WebHook URL in the config.lua to log players joining and leaving.')
        else
        AddEventHandler('playerJoining', function()
            local id = source
            local ids = GetPlayerIdentifier(id, steam)
            local plyName = GetPlayerName(id)
            local whData = {
                link = Config.loginLogLink,
                title = plyName.." JOINING",
                color = 655104,
                message = 
                '**[User]: **'..plyName..'\n'..
                '**[Identifier]: **'..ids..'\n'..
                '**[Asigned ID]: **'..id..'\n'
            }
            TriggerEvent('z64_logs:sendWebhook', whData)
        end)

        AddEventHandler('playerDropped', function(reason)
            local id = source
            local ids = GetPlayerIdentifier(id, steam)
            local plyName = GetPlayerName(id)
            local reason = reason
            local whData = {
                link = Config.loginLogLink,
                title = plyName.." LEFT",
                color = 16711689,
                message = 
                '**[User]: **'..plyName..'\n'..
                '**[Identifier]: **'..ids..'\n'..
                '**[Reason]: **'..reason..'\n'
            }
            TriggerEvent('z64_logs:sendWebhook', whData)
        end)
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    resName = GetCurrentResourceName()
    if resource == resName then
        if Config.whlink == '' then
            print('^7[^1INFO^7]: No default WebHook URL detected. Please configure the script correctly.')
        else 
            print('^7[^2INFO^7]: '..resName..' initiated succesfully.')
            local whData = {
                link = Config.whlink,
                title = "LOGGER STARTED",
                color = 4521728,
                message = 
                '**'..resName..'** HAS STARTED SUCCESFULLY.'
            }
            TriggerEvent('z64_logs:sendWebhook', whData)
        end
    end
end)
