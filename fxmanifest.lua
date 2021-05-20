fx_version 'cerulean'
game 'gta5'

description 'Requires ESX Legacy'

dependency 'es_extended'

shared_scripts {
	'@es_extended/imports.lua',
	'config.lua'
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}
