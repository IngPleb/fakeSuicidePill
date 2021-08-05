fx_version 'adamant'
game 'gta5'

name 'suicide & fake pill'
author 'Mr. PLEB#0001 | Dix // Jérémy'
description 'ESX - suicide | fake pill'
version '1.0.0'
--[[ This is rework of oblivionPill from Dix // Jérémy 
I do not take any credit for creating this because it uses most of his code.
I just wanted to add features that are missing and fix bug
Please contribute on github :)
https://github.com/Mr-Pleb/oblivionPill ]]

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
    'es_extended'
}