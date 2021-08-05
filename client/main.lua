ESX = nil

local locksound = false
local pillUsed = false
local timer = Config.OblivionDuration
local showTimer = Config.ShowTimer
local mode = Config.Mode
local scaleform

--- Initializes and requests some variables
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE") -- This needed to be moved here due to fivem logic that cant handle requesting multiple things at the same time
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    safetyChceck() -- Verifies that everthing is in order and If not throws error

    while true do
        Citizen.Wait(0)
        if pillUsed == true then
            animation()
            Citizen.Wait(Config.DurationBeforeFakeEffect) -- Waits x seconds before starting the effect (config.lua)
            if not isPlayerDead() then
                log(_U('LOGplayerUsedFakeSuicidePill'))
                --------------------------------------------------------
                -- DeathScreen
                --------------------------------------------------------
                StartScreenEffect("DeathFailOut", 0, 0)
                if not locksound then
                    PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
                    locksound = true
                    pillUsed = true
                end
                ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)

                if HasScaleformMovieLoaded(scaleform) then -- "ScaleMovie" is intialized in the intilialize thread 
                    Citizen.Wait(0)

                    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                    BeginTextComponent("STRING")
                    AddTextComponentString(_U('fall_oubli'))
                    EndTextComponent()
                    PopScaleformMovieFunctionVoid()
                    Citizen.Wait(100)
                    PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
                    ----------------------------------
                    startDesiredThread() -- Starts timer or starts chcecking if button to wake up was released

                    while pillUsed == true do
                        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                        SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
                        DisablePlayerFiring(PlayerId(), true)
                        drawDesiredText() -- Draws text that coresponds to config.lua settings
                        disableKeys() -- Disable keys which are set in config.lua

                        if isPlayerDead() then
                            pillUsed = false
                            timer = Config.OblivionDuration
                        end

                        Citizen.Wait(0)
                    end

                    StopScreenEffect("DeathFailOut")
                    locksound = false
                    log(_U('LOGplayerHasWokenUp'))
                end
            end
        end
    end
end)

function animation()
    if Config.Animation then
        local isAnimated = false
        local playerPed = PlayerPedId()
        if not isAnimated then
            isAnimated = true

            Citizen.CreateThread(function()

                ESX.Streaming.RequestAnimDict('mp_suicide', function()
                    TaskPlayAnim(playerPed, 'mp_suicide', 'pill', 8.0, -8, -1, 49, 0, 0, 0, 0) -- Nightmare

                    Citizen.Wait(3000)
                    isAnimated = false
                    ClearPedSecondaryTask(playerPed)
                end)
            end)
        end
        Citizen.Wait(3000)
    end
end

function disableKeys()
    for k, v in pairs(Config.DisabledKeys) do
        DisableControlAction(2, v, true)
    end
end

function drawDesiredText()
    if showTimer then
        drawText(_U('wakeUpTimer') .. " " .. math.floor(timer / 1000), 0.5, Config.TextPos)
    end

    if mode == "control" then
        drawText(_U('wakeUp'):gsub(":button:", "~b~[" .. Config.KeyWakeUp[1] .. "]~w~"), 0.5, Config.TextPos)
    end
end

function startDesiredThread()
    if showTimer then
        startTimer()
    elseif mode == "control" then
        startKeyChecking()
    end
end

function startKeyChecking()
    Citizen.CreateThread(function()
        while pillUsed == true do
            if IsControlJustReleased(0, Config.KeyWakeUp[2]) then
                pillUsed = false
            end
            Citizen.Wait(0)
        end
    end)
end

function startTimer()
    Citizen.CreateThread(function()
        while timer >= 0 do
            Citizen.Wait(1000)
            timer = timer - 1000
        end
        timer = Config.OblivionDuration
    end)
end

function safetyChceck()

    if mode == "control" and showTimer then
        error(
            "You cannot have control mode and showTimer activated at the same time! Contact server owner with this error message")
    end

end

----------------------------------
-- Utils / functions
----------------------------------

function drawText(text, x, y, scale)
    -- SetTextFont(font or 4)
    SetTextScale(scale or 0.45, scale or 0.45)
    -- SetTextColour(r or 185, g or 185, b or 185, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentString(text)
    EndTextCommandDisplayText(x, y)
end

function log(logMessage)
    if Config.EnableLogs then
        exports.JD_logs:discord(logMessage:gsub(":player_name:",GetPlayerName(PlayerId())), GetPlayerServerId(PlayerId()), 0, Config.LogColor, Config.LogChannel)
    end
end

function killPlayer()
    SetEntityHealth(PlayerPedId(), 0)
end

function isPlayerDead()
    if GetEntityHealth(PlayerPedId()) == 0 then
        return true
    else
        return false
    end
end
----------------------------------
-- Listeners
----------------------------------
RegisterNetEvent('suicidepills:fakepillused')
AddEventHandler('suicidepills:fakepillused', function()
    pillUsed = true
end)

RegisterNetEvent('suicidepills:stoppill')
AddEventHandler('suicidepills:stoppill', function()
    pillUsed = false
end)

RegisterNetEvent('suicidepills:deathpillused')
AddEventHandler('suicidepills:deathpillused', function()
    animation()
    Citizen.Wait(Config.DurationBeforeDeathEffect)
    killPlayer()
    log(_U('LOGplayerUsedSuicidePill'))
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
    pillUsed = false
end)
