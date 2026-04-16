fx_version 'cerulean'
game 'gta5'

author 'CoreyJB247'
description 'solos-rentals edited by CoreyJB247'
version '1.0.0'


shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client.lua',
}

server_script {
    'server.lua'
}

escrow_ignore {
    'config.lua',
    'client.lua',
    'server.lua'
}

dependencies {
    --'ox_inventory',
    'ox_lib',
}

lua54 'yes'