fx_version 'cerulean'
game 'gta5'
author 'DON'
description 'TN-Shops'
version '1.0.0'
shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@qb-core/shared/locale.lua',
    'locale/en.lua',
    'locale/*.lua',
    'config.lua'
}
client_script 'client/main.lua'
server_scripts {
	'@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}
ui_page 'html/index.html'
files {
  'html/index.html',
  'html/script.js',
  'html/style.css',
  'html/*otf',
  'html/*png',
  'images/*.png',
  'images/*.jpg',
  'images/*.webp',
  'images/*.mp4',
  'fonts/*.ttf',
  'fonts/*.otf'
}
lua54 'yes'