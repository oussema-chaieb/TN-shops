Config = {}

Config.Products = {
    ['foods'] = {
        {name = 'tosti',         price = 6,   amount = 50,   info = {}, type = 'item', image = "tosti.png"},
        {name = 'twerks_candy',  price = 6,   amount = 50,   info = {}, type = 'item', image = "twerks_candy.png"},
        {name = 'snikkel_candy', price = 6,   amount = 50,   info = {}, type = 'item', image = "snikkel_candy.png"},
        {name = 'sandwich',      price = 6,   amount = 50,   info = {}, type = 'item', image = "sandwich.png"},
    },
    ['drinks'] = {
        {name = 'water_bottle',  price = 6,   amount = 50,   info = {}, type = 'item', image = "water_bottle.png"},
        {name = 'kurkakola',     price = 6,   amount = 50,   info = {}, type = 'item', image = "kurkakola.png"},
    },
    ['liquor'] = {
        {name = 'beer',    price = 7,  amount = 50, info = {}, type = 'item', image = "beer.png"},
        {name = 'whiskey', price = 10, amount = 50, info = {}, type = 'item', image = "whiskey.png"},
        {name = 'vodka',   price = 12, amount = 50, info = {}, type = 'item', image = "vodka.png"},
    },
    ['electrics'] = {
        {name = 'radio',             price = 250, amount = 50,  info = {}, type = 'item', image = "radio.png"},
        {name = 'cryptostick ',             price = 400, amount = 150, info = {}, type = 'item', image = "cryptostick .png"},
        {name = 'phone_dongle',            price = 400, amount = 150, info = {}, type = 'item', image = "phone_dongle.png"},
        {name = 'powerbank',            price = 400, amount = 150, info = {}, type = 'item', image = "powerbank.png"},
        {name = 'black_phone',            price = 400, amount = 150, info = {}, type = 'item', image = "black_phone.png"},
        {name = 'yellow_phone',            price = 400, amount = 150, info = {}, type = 'item', image = "yellow_phone.png"},
        {name = 'red_phone',            price = 400, amount = 150, info = {}, type = 'item', image = "red_phone.png"},
        {name = 'green_phone',            price = 400, amount = 150, info = {}, type = 'item', image = "green_phone.png"},
        {name = 'white_phone',            price = 400, amount = 150, info = {}, type = 'item', image = "white_phone.png"},
    },
    ['fireworks'] = {
        {name = 'firework1',         price = 50,  amount = 50,  info = {}, type = 'item', image = "firework1.png"},
        {name = 'firework2',         price = 50,  amount = 50,  info = {}, type = 'item', image = "firework2.png"},
        {name = 'firework3',         price = 50,  amount = 50,  info = {}, type = 'item', image = "firework3.png"},
        {name = 'firework4',         price = 50,  amount = 50,  info = {}, type = 'item', image = "firework4.png"},
    },
    ['gearshop'] = {
        {name = 'parachute',   price = 2500, amount = 10, info = {}, type = 'item', image = "parachute.png"},
        {name = 'binoculars',  price = 50,   amount = 50, info = {}, type = 'item', image = "binoculars.png"},
        {name = 'diving_gear', price = 2500, amount = 10, info = {}, type = 'item', image = "diving_gear.png"},
        {name = 'diving_fill', price = 500,  amount = 10, info = {}, type = 'item', image = "diving_fill.png"},
        {name = 'jerry_can',   price = 200,  amount = 50, info = {}, type = 'item', image = "jerry_can.png"},
    },
    ['leisureshop'] = {
        {name = 'parachute',   price = 2500, amount = 10, info = {}, type = 'item', image = "parachute.png"},
        {name = 'binoculars',  price = 50,   amount = 50, info = {}, type = 'item', image = "binoculars.png"},
        {name = 'diving_gear', price = 2500, amount = 10, info = {}, type = 'item', image = "diving_gear.png"},
        {name = 'diving_fill', price = 500,  amount = 10, info = {}, type = 'item', image = "diving_fill.png"},
    },

    ['weedneeds'] = {
        {name = 'femaleseed',   price = 10, amount = 10, info = {}, type = 'item', image = "femaleseed.png"},
        {name = 'maleseed',  price = 10,   amount = 50, info = {}, type = 'item', image = "maleseed.png"},
        {name = 'wateringcan', price = 10, amount = 10, info = {}, type = 'item', image = "wateringcan.png"},
        {name = 'fertilizer', price = 10,  amount = 10, info = {}, type = 'item', image = "fertilizer.png"},
        {name = 'emptybaggies', price = 10,  amount = 10, info = {}, type = 'item', image = "emptybaggies.png"},
        {name = 'rolling_paper', price = 10,  amount = 10, info = {}, type = 'item', image = "rolling_paper.png"},
    },

    ['cokeneeds'] = {
        {name = 'empty_green_boxes',   price = 20, amount = 50, info = {}, type = 'item', image = "coke_box.png"},
        {name = 'coke_figureempty',  price = 1,   amount = 10, info = {}, type = 'item', image = "coke_figureempty.png"},
        {name = 'baking_soda', price = 1, amount = 50, info = {}, type = 'item', image = "baking_soda.png"},
        {name = 'empty_syringe', price = 1, amount = 50, info = {}, type = 'item', image = "syringe.png"},
        {name = 'trowel', price = 1, amount = 50, info = {}, type = 'item', image = "trowel.png"},
    },
}

Config.Locations = {
    -- 24/7 Locations
    ['247supermarket'] = {
        ['id'] = 1,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(24.47, -1346.62, 29.5, 271.66),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,   
        ["coords2"] = vector4(31.37, -1340.51, 29.5, 92.0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket2'] = {
        ['id'] = 2,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(-3039.54, 584.38, 7.91, 17.27),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,   
        ["coords2"] = vector4(-3047.44, 589.1, 7.91, 195.96),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket3'] = {
        ['id'] = 3,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(-3242.97, 1000.01, 12.83, 357.57),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-3248.5, 1007.3, 12.83, 169.69),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket4'] = {
        ['id'] = 4,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(1728.07, 6415.63, 35.04, 242.95),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(1736.97, 6418.29, 35.04, 63.36),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket5'] = {
        ['id'] = 5,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(1959.82, 3740.48, 32.34, 301.57),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(1962.62, 3749.38, 32.34, 113.0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket6'] = {
        ['id'] = 6,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(549.13, 2670.85, 42.16, 99.39),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(543.09, 2663.68, 42.16, 274.53),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket7'] = {
        ['id'] = 7,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(2677.47, 3279.76, 55.24, 335.08),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(2675.42, 3288.61, 55.24, 148.76),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket8'] = {
        ['id'] = 8,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(2556.66, 380.84, 108.62, 356.67),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(2550.73, 388.07, 108.62, 176.1),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['247supermarket9'] = {
        ['id'] = 9,
        ['label'] = '24/7 Supermarket',
        ['coords'] = vector4(372.66, 326.98, 103.57, 253.73),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(380.9, 331.32, 103.57, 81.36),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    -- LTD Gasoline Locations
    ['ltdgasoline'] = {
        ['id'] = 10,
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(-47.02, -1758.23, 29.42, 45.05),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-41.85, -1749.02, 29.42, 140.3),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['ltdgasoline2'] = {
        ['id'] = 11,
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(-706.06, -913.97, 19.22, 88.04),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-708.18, -903.58, 19.22, 179.59),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['ltdgasoline3'] = {
        ['id'] = 12,
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(-1820.02, 794.03, 138.09, 135.45),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-1828.46, 800.1, 138.17, 217.37),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['ltdgasoline4'] = {
        ['id'] = 13,
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(1164.71, -322.94, 69.21, 101.72),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(1160.82, -313.2, 69.21, 188.82),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },
    ['ltdgasoline6'] = {
        ['id'] = 14,
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(1697.87, 4922.96, 42.06, 324.71),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(1707.43, 4918.94, 42.06, 53.75),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["foods"] = "Foods for your hunger.",
            ["drinks"] = "Drinks for your thirst.",
        },
        ["itemList"] = {
            ["foods"] = Config.Products['foods'],
            ["drinks"] = Config.Products['drinks'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    -- Rob's Liquor Locations
    ['robsliquor'] = {
        ['id'] = 15,
        ['label'] = 'Rob\'s Liqour',
        ['coords'] = vector4(-1221.58, -908.15, 12.33, 35.49),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-1218.65, -916.27, 11.33, 24.74),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["liquor"] = "liquor to get drunk.",
        },
        ["itemList"] = {
            ["liquor"] = Config.Products['liquor'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['robsliquor2'] = {
        ['id'] = 16,
        ['label'] = 'Rob\'s Liqour',
        ['coords'] = vector4(-1486.59, -377.68, 40.16, 139.51),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-1479.1, -373.36, 39.16, 127.82),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["liquor"] = "liquor to get drunk.",
        },
        ["itemList"] = {
            ["liquor"] = Config.Products['liquor'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['robsliquor3'] = {
        ['id'] = 17,
        ['label'] = 'Rob\'s Liqour',
        ['coords'] = vector4(-2966.39, 391.42, 15.04, 87.48),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(-2958.24, 388.74, 14.04, 96.05),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["liquor"] = "liquor to get drunk.",
        },
        ["itemList"] = {
            ["liquor"] = Config.Products['liquor'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['robsliquor4'] = {
        ['id'] = 18,
        ['label'] = 'Rob\'s Liqour',
        ['coords'] = vector4(1165.17, 2710.88, 38.16, 179.43),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(1167.65, 2719.04, 37.16, 185.13),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["liquor"] = "liquor to get drunk.",
        },
        ["itemList"] = {
            ["liquor"] = Config.Products['liquor'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    ['robsliquor5'] = {
        ['id'] = 19,
        ['label'] = 'Rob\'s Liqour',
        ['coords'] = vector4(1134.2, -982.91, 46.42, 277.24),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
        ["price"] = 102040,  
        ["coords2"] = vector4(1125.77, -982.08, 45.42, 278.2),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["liquor"] = "liquor to get drunk.",
        },
        ["itemList"] = {
            ["liquor"] = Config.Products['liquor'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.7,
        ['blipcolor'] = 0
    },

    -- Sea Word Locations
    ['seaword'] = {
        ['id'] = 23,
        ['label'] = 'Sea Word',
        ['coords'] = vector4(-1687.03, -1072.18, 13.15, 52.93),
        ['ped'] = 'a_m_y_beach_01',
        ["ownable"] = false,
        ["coords2"] = vector4(0, 0, 0, 0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_IMPATIENT',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-fish',
        ['targetLabel'] = 'Sea Word',
        ["job"] = "",
        ["categoryList"] = {
            ["gearshop"] = "gearshop",
        },
        ["itemList"] = {
            ["gearshop"] = Config.Products['gearshop'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0
    },
    -- Leisure Shop Locations
}

Config.Orders = {
    items = {
        [1] = {item = "sandwich", price = 2, categorie = "food"},
        [2] = {item = "parachute", price = 3, categorie = "gear"},
        [3] = {item = "lighter", price = 4, categorie = "gear"},
        [4] = {item = "joint", price = 5, categorie = "weed"},
    },
    carmodel = "rebel",
    carspawn = {
        [1] = vector4(15.59, -1340.42, 29.28, 180.35),
        [2] = vector4(-3052.32, 596.73, 7.44, 285.06),
        [3] = vector4(-3249.57, 987.38, 12.49, 4.04),
        [4] = vector4(1717.29, 6419.31, 33.29, 153.22),
        [5] = vector4(1970.9, 3748.74, 32.32, 207.87),
        [6] = vector4(567.06, 2668.0, 42.06, 9.47),
        [7] = vector4(2683.88, 3292.94, 54.63, 239.66),
        [8] = vector4(2582.9, 427.79, 108.46, 180.57),
        [9] = vector4(365.9, 330.36, 103.56, 161.44),
        [10] = vector4(-59.99, -1744.98, 29.35, 52.04),
        [11] = vector4(-702.1, -920.81, 19.02, 94.05),
        [12] = vector4(-1814.94, 803.79, 138.51, 25.94),
        [13] = vector4(1175.24, -317.96, 69.18, 281.29),
        [14] = vector4(1692.68, 4917.48, 42.08, 55.8),
        [15] = vector4(-1254.77, -862.14, 12.34, 212.99),
        [16] = vector4(-1458.33, -383.67, 38.49, 130.21),
        [17] = vector4(-2962.23, 365.94, 14.77, 32.05),
        [18] = vector4(1169.52, 2726.28, 38.0, 268.22),
        [19] = vector4(1134.16, -974.31, 46.58, 277.41),
    },
    delivery = {
        [1] = {
            Pos = vector4(-222.22, 6445.48, 36.85, 275.93),
            DrugPos = vector4(-228.88, 6454.33, 31.14, 22.11),
            DrugPos2 = vector4(-236.13, 6450.23, 31.15, 224.2),
        },
        [2] = { 
            Pos = vector4(747.7, 4184.82, 50.2, 349.5),
            DrugPos = vector4(754.63, 4177.88, 40.94, 309.37),
            DrugPos2 = vector4(737.03, 4174.9, 40.71, 348.94),
        },
        [3] = { 
            Pos = vector4(1377.58, 4304.9, 36.76, 216.31),
            DrugPos = vector4(1381.04, 4286.94, 36.48, 313.86),
            DrugPos2 = vector4(1388.81, 4309.78, 36.89, 263.88),
        },
        [4] = { 
            Pos = vector4(1903.05, 4922.0, 48.79, 336.29),
            DrugPos = vector4(1904.35, 4909.91, 48.75, 253.3),
            DrugPos2 = vector4(1893.53, 4927.11, 48.93, 340.79),
        },
        [5] = { 
            Pos = vector4(2527.12, 4985.54, 44.81, 103.93),
            DrugPos = vector4(2524.75, 4996.59, 44.67, 140.68),
            DrugPos2 = vector4(2521.33, 4977.66, 44.87, 196.17),
        },
        [6] = { 
            Pos = vector4(3333.01, 5161.66, 18.28, 120.14),
            DrugPos = vector4(3327.00, 5170.67, 18.37, 13.83),
            DrugPos2 = vector4(3337.87, 5156.20, 18.37, 35.28),
        },
        [7] = { 
            Pos = vector4(1911.82, 3729.16, 32.41, 317.03),
            DrugPos = vector4(1909.57, 3737.44, 32.51, 351.28),
            DrugPos2 = vector4(1903.99, 3733.75, 32.54, 217.63),
        },
        [8] = { 
            Pos = vector4(894.67, 3578.11, 33.36, 258.26),
            DrugPos = vector4(899.59, 3575.07, 33.49, 75.79),
            DrugPos2 = vector4(899.17, 3582.79, 33.41, 348.45),
        },
        [9] = { 
            Pos = vector4(374.99, 3585.20, 33.29, 162.71),
            DrugPos = vector4(373.04, 3580.03, 33.29, 157.81),
            DrugPos2 = vector4(372.60, 3583.59, 33.29, 330.95),
        },
        [10] = { 
            Pos = vector4(55.71, 3712.88, 39.75, 260.65),
            DrugPos = vector4(48.58, 3715.11, 39.75, 84.48),
            DrugPos2 = vector4(50.38, 3706.24, 39.75, 178.42),
        },
        [11] = { 
            Pos = vector4(260.46, 3103.04, 42.40, 178.30),
            DrugPos = vector4(263.51, 3101.88, 42.61, 96.29),
            DrugPos2 = vector4(257.33, 3106.73, 42.49, 286.51),
        },
        [12] = { 
            Pos = vector4(870.25, 2866.49, 56.81, 191.53),
            DrugPos = vector4(867.57, 2871.62, 56.97, 247.63),
            DrugPos2 = vector4(859.79, 2870.20, 57.46, 76.47),
        },
        [13] = { 
            Pos = vector4(1581.50, 2904.52, 56.88, 31.36),
            DrugPos = vector4(1581.50, 2909.13, 56.90, 355.41),
            DrugPos2 = vector4(1587.98, 2900.90, 57.03, 228.92),
        },
        [14] = { 
            Pos = vector4(1983.33, 3035.76, 47.06, 303.65),
            DrugPos = vector4(1986.94, 3041.27, 47.06, 166.29),
            DrugPos2 = vector4(1988.86, 3024.96, 47.06, 280.15),
        },
        [15] = { 
            Pos = vector4(2311.18, 2519.64, 46.67, 179.44),
            DrugPos = vector4(2310.79, 2526.56, 46.66, 359.33),
            DrugPos2 = vector4(2315.98, 2519.91, 46.67, 222.11),
        },        
    }
}

Config.Package = {
    [0] = {pack},
    [1] = {pack},
    [2] = {pack},
    [3] = {pack},
    [4] = {pack},
    [5] = {pack},
    [6] = {pack},
    [7] = {pack},
    [8] = {pack},
    [9] = {pack},
    [10] = {pack},
    [11] = {pack},
    [12] = {pack},
    [13] = {pack},
    [14] = {pack},
}

Config.Fuel = "cdn-fuel"