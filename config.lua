-- DO NOT TOUCH
Config = {}
local second = 1000
----------------------------------------------------------------

Config.Locale = 'cs'

Config.OblivionDuration = second * 180 -- Change the number to how many seconds you want the effect of fake pill to last
Config.ShowTimer = true -- Shows player how many seconds is remaining
Config.DurationBeforeFakeEffect = second * 10 -- How many seconds before the fake pill kicks in
Config.Mode = "duration" -- duration -> player needs to wait for the effect go away | "control" -> player has complete control when to wake up (IF YOU USE THIS ONE, DO NOT ACTIVATE TIMER)
Config.KeyWakeUp = {"G", 47} -- Key used to wake up => name of the key and second is id which you can find here https://docs.fivem.net/docs/game-references/controls/
Config.ShowUseFakePillNotification = false -- Should player see a standart gta notification when he eats the fake pill?
Config.Animation = true -- When eating, do we want the ped to use animation of suicide from gta online?

Config.DurationBeforeDeathEffect = second * 10-- How many seconds before the death pill kicks in
Config.ShowUseRealPillNotification = false -- Should player see a standart gta notification when he eats the real pill?

----------------------------------------------------------------
-- JD_LOGS
----------------------------------------------------------------
Config.EnableLogs = false -- Will enable logging actions like (eating the pill, waking up), currently this option only supports JDlogs (https://github.com/prefech/JD_logs)
Config.LogColor = '#F1F1F1' -- hex code
Config.LogChannel = 'YOUR JDLOG CHANNEL NAME HERE'
-- For more inforamation https://docs.prefech.com/jd_logs/single-player-logs
-----------------
-- UI
-----------------
Config.TextPos = 0.9 -- Position of timer and key (which key to wake up)

Config.DisabledKeys = {289, 170} -- lest of disabledKeys while being in oblivion, list can be found here https://docs.fivem.net/docs/game-references/controls/