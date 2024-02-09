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
        {name = 'fitbit',            price = 400, amount = 150, info = {}, type = 'item', image = "fitbit.png"},
    },
    ['clicklovers'] = {
        {name = 'phone',             price = 200, amount = 50,  info = {}, type = 'item', image = "phone.png"},
        {name = 'radio',             price = 2000, amount = 50,  info = {}, type = 'item', image = "radio.png"},

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
        {name = 'empty_green_boxes',   price = 5, amount = 50, info = {}, type = 'item', image = "coke_box.png"},
        {name = 'coke_figureempty',  price = 5,   amount = 10, info = {}, type = 'item', image = "coke_figureempty.png"},
        {name = 'baking_soda', price = 5, amount = 50, info = {}, type = 'item', image = "baking_soda.png"},
        {name = 'empty_syringe', price = 5, amount = 50, info = {}, type = 'item', image = "syringe.png"},
    },
    ['tools'] = {
        {name = 'ziptie',   price = 5, amount = 50, info = {}, type = 'item', image = "ziptie.png"},
        {name = 'flush_cutter',  price = 5,   amount = 10, info = {}, type = 'item', image = "flush_cutter.png"},
        {name = 'headbag', price = 5, amount = 50, info = {}, type = 'item', image = "headbag.png"},
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

    ['ltdgasoline5'] = {
        ['id'] = 13,
        ['label'] = 'Click Lovers',
        ['coords'] = vector4(212.32, -1507.68, 29.29, 221.16),
        ['ped'] = 'a_m_y_business_01',
        ["ownable"] = false,
        ["coords2"] = vector4(0, 0, 0, 0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-shopping-basket',
        ['targetLabel'] = 'Open Click Lovers Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["clicklovers"] = "clicklovers",
        },
        ["itemList"] = {
            ["clicklovers"] = Config.Products['clicklovers'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 647,
        ['blipscale'] = 0.6,
        ['blipcolor'] = 3
    },

    ['ltdgasoline6'] = {
        ['id'] = 14,
        ['label'] = 'LTD Gasoline',
        ['coords'] = vector4(1697.87, 4922.96, 42.06, 324.71),
        ['ped'] = 'mp_m_shopkeep_01',
        ["ownable"] = true,
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
    ['clicklovers'] = {
        ['id'] = 24,
        ['label'] = 'Phone Shop',
        ['coords'] = vector4(-1505.91, 1511.95, 115.29, 257.13),
        ['ped'] = 'a_m_y_beach_01',
        ["ownable"] = false,
        ["coords2"] = vector4(0, 0, 0, 0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE_CLUBHOUSE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-leaf',
        ['targetLabel'] = 'Open Leisure Shop',
        ["job"] = "",
        ["categoryList"] = {
            ["clicklovers"] = "clicklovers",
        },
        ["itemList"] = {
            ["clicklovers"] = Config.Products['clicklovers'],
        },
        ['showblip'] = true,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0
    },
    -- Leisure Shop Locations
    ['weedneeds'] = {
        ['id'] = 25,
        ['label'] = 'Weed Needs',
        ['coords'] = vector4(927.19, -1890.07, 32.25, 174.0),
        ['ped'] = 'a_m_y_beach_01',
        ["ownable"] = false,
        ["coords2"] = vector4(0, 0, 0, 0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE_CLUBHOUSE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-leaf',
        ['targetLabel'] = 'Open Weed Shoop',
        ["job"] = "",
        ["categoryList"] = {
            ["weedneeds"] = "weedneeds",
        },
        ["itemList"] = {
            ["weedneeds"] = Config.Products['weedneeds'],
        },
        ['showblip'] = false,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0
    },
    ['cokeneeds'] = {
        ['id'] = 25,
        ['label'] = 'Coke Needs',
        ['coords'] = vector4(179.06, -1678.18, 7.27, 246.52),
        ['ped'] = 'a_m_y_beach_01',
        ["ownable"] = false,
        ["coords2"] = vector4(0, 0, 0, 0),
        ["ped2"] = 'a_m_y_business_01',
        ['scenario'] = 'WORLD_HUMAN_STAND_MOBILE_CLUBHOUSE',
        ['radius'] = 1.5,
        ['targetIcon'] = 'fas fa-leaf',
        ['targetLabel'] = 'Open Coke Shoop',
        ["job"] = "",
        ["categoryList"] = {
            ["cokeneeds"] = "coke needs",
            ["tools"] = "Tools",
        },
        ["itemList"] = {
            ["cokeneeds"] = Config.Products['cokeneeds'],
            ["tools"] = Config.Products['tools'],
        },
        ['showblip'] = false,
        ['blipsprite'] = 52,
        ['blipscale'] = 0.8,
        ['blipcolor'] = 0
    },
}